/*
 * main.c
 *
 *  Created on: Oct 26, 2026
 *      Author: lucek
 */

/*
 * ============================================================================
 *  Kalkulator RPN (wzorzec: HP-12C) na procesorze MicroBlaze
 *  Vivado / Xilinx SDK 2019.x  -  aplikacja standalone
 *
 *  Peryferia:
 *    - AXI UartLite      : wejscie znakow z portu RS232 (9600, 8N1)
 *    - AXI GPIO (8 bit)  : anody wyswietlaczy 7-segmentowych (AN0..AN7)
 *    - AXI GPIO (8 bit)  : segmenty (a,b,c,d,e,f,g,dp)
 *    - AXI GPIO (>=3 bit): diody LED (LD2=Y, LD1=Z, LD0=T)
 *
 *  Klawisze (znaki wysylane z terminala, np. putty):
 *    0..9     - wprowadzanie cyfr
 *    +  -  *  /   - dzialania arytmetyczne (wynik = Y op X)
 *    S        - CHS  (zmiana znaku rejestru X)
 *    ENTER    - wprowadzenie X na stos (podniesienie stosu)
 *    C        - CLx  (zerowanie X, kasowanie bledu)
 *    X        - X<->Y (zamiana X i Y)
 *    R        - R(dol) (rotacja stosu w dol, X -> T)
 *    ,        - zmniejszenie jasnosci wyswietlacza o 1 krok
 *    .        - zwiekszenie jasnosci wyswietlacza o 1 krok
 * ============================================================================
 */

#include <stdint.h>
#include "xparameters.h"
#include "xgpio.h"
#include "xuartlite.h"
#include "xil_printf.h"

/* ===========================================================================
 *  1. KONFIGURACJA SPRZETOWA  --  TO TRZEBA DOPASOWAC DO WLASNEGO BLOCK DESIGN
 *     (sprawdz nazwy w pliku xparameters.h w projekcie BSP)
 * ===========================================================================
 */

#define UART_DEVICE_ID        XPAR_UARTLITE_0_DEVICE_ID

/* Segmenty - rdzen AXI GPIO i numer kanalu (1 = GPIO, 2 = GPIO2) */
#define GPIO_SEG_DEVICE_ID    XPAR_AXI_GPIO_0_DEVICE_ID
#define GPIO_SEG_CHANNEL      1

/* Anody */
#define GPIO_AN_DEVICE_ID     XPAR_AXI_GPIO_0_DEVICE_ID
#define GPIO_AN_CHANNEL       2

/* Diody LED */
#define GPIO_LED_DEVICE_ID    XPAR_AXI_GPIO_1_DEVICE_ID
#define GPIO_LED_CHANNEL      1

/* Polaryzacja sygnalow (plytki Digilent Nexys: anody i segmenty aktywne w 0) */
#define SEG_ACTIVE_LOW        1
#define AN_ACTIVE_LOW         1
#define LED_ACTIVE_LOW        0

/* 1 = bit 0 portu anod steruje SKRAJNIE PRAWYM wyswietlaczem (typowe: AN0)
 * 0 = bit 0 steruje skrajnie lewym (gdy anody sa podlaczone odwrotnie)      */
#define AN_BIT0_IS_RIGHT      1

/* Czestotliwosc zegara MicroBlaze - uzywana tylko do petli opozniajacej.
 * Dokladnosc nie jest krytyczna (patrz delay_us).                          */
#define CPU_FREQ_HZ           100000000UL
#define LOOP_CYCLES           7UL     /* ~cykli na obrot petli opozniajacej  */

/* Echo odebranego znaku z powrotem do terminala (putty nie ma echa lokalnego) */
#define ECHO_UART             1

/* ===========================================================================
 *  2. PARAMETRY WYSWIETLANIA I JASNOSCI
 * ===========================================================================
 */

#define NDIGITS               8          /* liczba wyswietlaczy              */
#define MAX_ENTRY_VALUE       9999999L   /* 7 pozycji na liczbe              */

#define BRIGHT_LEVELS         16         /* liczba krokow regulacji jasnosci */
#define BRIGHT_DEFAULT        12
#define SLOT_UNIT_US          25         /* kwant czasu jednego kroku [us]   */
/* Czas jednej pozycji = BRIGHT_LEVELS * SLOT_UNIT_US = 400 us
 * Odswiezanie calego wyswietlacza = 8 * 400 us = 3.2 ms  ->  ok. 310 Hz
 * Z czasu pozycji "level" krokow swieci, a (BRIGHT_LEVELS-level) jest ciemne
 * (wszystkie anody wylaczone) - stad regulacja jasnosci bez zmiany czestotliwosci. */

/* ===========================================================================
 *  3. KODY SEGMENTOW
 *     bit0=a, bit1=b, bit2=c, bit3=d, bit4=e, bit5=f, bit6=g, bit7=dp
 *     (1 = segment ma swiecic; polaryzacja dokladana jest w segWrite())
 * ===========================================================================
 */

static const uint8_t SEG_DIGIT[10] = {
    0x3F, /* 0 */  0x06, /* 1 */  0x5B, /* 2 */  0x4F, /* 3 */  0x66, /* 4 */
    0x6D, /* 5 */  0x7D, /* 6 */  0x07, /* 7 */  0x7F, /* 8 */  0x6F  /* 9 */
};

#define SEG_BLANK   0x00
#define SEG_MINUS   0x40    /* g            */
#define SEG_E       0x79    /* a d e f g    */
#define SEG_r       0x50    /* e g          */
#define SEG_o       0x5C    /* c d e g      */

/* ===========================================================================
 *  4. ZMIENNE GLOBALNE
 * ===========================================================================
 */

static XGpio      gpioSeg, gpioAn, gpioLed;
static XUartLite  uart;

/* Stos RPN */
static int32_t regX, regY, regZ, regT;

static int  entering;       /* trwa wprowadzanie liczby z klawiatury   */
static int  entryNeg;       /* wprowadzana liczba ma znak minus        */
static int  stackLift;      /* nastepna liczba ma podniesc stos        */
static int  errorFlag;      /* stan bledu - na wyswietlaczu "Error"    */

static int  brightness = BRIGHT_DEFAULT;    /* 1 .. BRIGHT_LEVELS      */

/* Bufor obrazu: indeks 0 = skrajnie prawa pozycja, 7 = skrajnie lewa  */
static uint8_t dispBuf[NDIGITS];

/* ===========================================================================
 *  5. FUNKCJE NISKOPOZIOMOWE
 * ===========================================================================
 */

/* Prosta petla opozniajaca. Dla regulacji jasnosci istotny jest stosunek
 * czasow, a nie bezwzgledna wartosc - jesli wyswietlacz migocze, zmniejsz
 * SLOT_UNIT_US, jesli jest za ciemny przy maksimum - zwieksz LOOP_CYCLES. */
static void delay_us(uint32_t us)
{
    volatile uint32_t n = (uint32_t)(((uint64_t)us * (CPU_FREQ_HZ / 1000000UL)) / LOOP_CYCLES);
    while (n--) {
        /* pusto */
    }
}

static void segWrite(uint8_t pattern)
{
#if SEG_ACTIVE_LOW
    XGpio_DiscreteWrite(&gpioSeg, GPIO_SEG_CHANNEL, (uint8_t)(~pattern));
#else
    XGpio_DiscreteWrite(&gpioSeg, GPIO_SEG_CHANNEL, pattern);
#endif
}

static void anWrite(uint8_t mask)   /* mask: 1 = anoda wlaczona */
{
#if AN_ACTIVE_LOW
    XGpio_DiscreteWrite(&gpioAn, GPIO_AN_CHANNEL, (uint8_t)(~mask));
#else
    XGpio_DiscreteWrite(&gpioAn, GPIO_AN_CHANNEL, mask);
#endif
}

static void ledWrite(uint8_t value)
{
#if LED_ACTIVE_LOW
    XGpio_DiscreteWrite(&gpioLed, GPIO_LED_CHANNEL, (uint8_t)(~value));
#else
    XGpio_DiscreteWrite(&gpioLed, GPIO_LED_CHANNEL, value);
#endif
}

/* ===========================================================================
 *  6. PRZYGOTOWANIE OBRAZU
 * ===========================================================================
 */

static void updateLeds(void)
{
    uint8_t v = 0;
    if (regY != 0) v |= 0x04;   /* LED 2 - rejestr Y */
    if (regZ != 0) v |= 0x02;   /* LED 1 - rejestr Z */
    if (regT != 0) v |= 0x01;   /* LED 0 - rejestr T */
    ledWrite(v);
}

static void updateDisplay(void)
{
    int i;

    if (errorFlag) {
        /* obraz (od lewej):  _ E r r o r _ _  */
        dispBuf[7] = SEG_BLANK;
        dispBuf[6] = SEG_E;
        dispBuf[5] = SEG_r;
        dispBuf[4] = SEG_r;
        dispBuf[3] = SEG_o;
        dispBuf[2] = SEG_r;
        dispBuf[1] = SEG_BLANK;
        dispBuf[0] = SEG_BLANK;
    } else {
        uint32_t m = (regX < 0) ? (uint32_t)(-(int64_t)regX) : (uint32_t)regX;

        /* 7 mlodszych pozycji: wartosc bezwzgledna rejestru X */
        for (i = 0; i < NDIGITS - 1; i++) {
            dispBuf[i] = SEG_DIGIT[m % 10];
            m /= 10;
        }
        /* wygaszenie zer nieznaczacych (pozycja 0 zawsze widoczna) */
        m = (regX < 0) ? (uint32_t)(-(int64_t)regX) : (uint32_t)regX;
        for (i = NDIGITS - 2; i >= 1; i--) {
            uint32_t div = 1;
            int k;
            for (k = 0; k < i; k++) div *= 10;
            if (m / div == 0) dispBuf[i] = SEG_BLANK;
            else break;                      /* dalej sa juz cyfry znaczace */
        }

        /* najstarsza pozycja: znak minus */
        dispBuf[7] = ((regX < 0) || (entering && entryNeg)) ? SEG_MINUS : SEG_BLANK;
    }

    updateLeds();
}

/* ===========================================================================
 *  7. LOGIKA KALKULATORA RPN
 * ===========================================================================
 */

static void stackLiftUp(void)       /* podniesienie stosu: T<-Z, Z<-Y, Y<-X */
{
    regT = regZ;
    regZ = regY;
    regY = regX;
}

static void stackDrop(void)         /* zdjecie: Y<-Z, Z<-T, T bez zmian     */
{
    regY = regZ;
    regZ = regT;
    /* regT celowo pozostaje bez zmian - tak dziala HP-12C */
}

static void setError(void)
{
    errorFlag = 1;
    entering  = 0;
    entryNeg  = 0;
}

static void keyDigit(int d)
{
    int64_t m;

    if (!entering) {
        if (stackLift) stackLiftUp();
        regX      = 0;
        entering  = 1;
        entryNeg  = 0;
        stackLift = 1;          /* po zakonczeniu wpisu stos bedzie podnoszony */
    }

    m = (regX < 0) ? -(int64_t)regX : (int64_t)regX;
    m = m * 10 + d;
    if (m > MAX_ENTRY_VALUE) return;        /* wiecej niz 7 cyfr - ignoruj   */

    regX = (int32_t)(entryNeg ? -m : m);
}

static void keyEnter(void)
{
    entering = 0;
    entryNeg = 0;
    stackLiftUp();
    stackLift = 0;              /* po ENTER kolejna liczba NIE podnosi stosu */
}

static void keyClx(void)
{
    regX      = 0;
    entering  = 0;
    entryNeg  = 0;
    errorFlag = 0;
    stackLift = 0;
}

static void keyChs(void)
{
    if (entering) entryNeg = !entryNeg;
    regX = -regX;
}

static void keySwapXY(void)
{
    int32_t t = regX;
    entering  = 0;
    entryNeg  = 0;
    regX      = regY;
    regY      = t;
    stackLift = 1;
}

static void keyRollDown(void)
{
    int32_t t = regX;
    entering  = 0;
    entryNeg  = 0;
    regX = regY;
    regY = regZ;
    regZ = regT;
    regT = t;
    stackLift = 1;
}

static void keyOperation(char op)
{
    int64_t r;

    entering = 0;
    entryNeg = 0;

    switch (op) {
    case '+': r = (int64_t)regY + (int64_t)regX; break;
    case '-': r = (int64_t)regY - (int64_t)regX; break;
    case '*': r = (int64_t)regY * (int64_t)regX; break;
    case '/':
        if (regX == 0) { setError(); return; }       /* dzielenie przez zero */
        r = (int64_t)regY / (int64_t)regX;           /* dzielenie calkowite  */
        break;
    default:  return;
    }

    if (r > MAX_ENTRY_VALUE || r < -MAX_ENTRY_VALUE) {   /* przekroczenie zakresu */
        setError();
        return;
    }

    regX = (int32_t)r;
    stackDrop();
    stackLift = 1;
}

static void keyBrightness(int delta)
{
    brightness += delta;
    if (brightness < 1)             brightness = 1;
    if (brightness > BRIGHT_LEVELS) brightness = BRIGHT_LEVELS;
}

/* ===========================================================================
 *  8. OBSLUGA ZNAKOW Z RS232
 * ===========================================================================
 */

static void handleChar(uint8_t c)
{
#if ECHO_UART
    if (c == '\r' || c == '\n') { xil_printf("\r\n"); }
    else                        { XUartLite_SendByte(uart.RegBaseAddress, c); }
#endif

    /* Regulacja jasnosci dziala takze w stanie bledu */
    if (c == ',') { keyBrightness(-1); return; }
    if (c == '.') { keyBrightness(+1); return; }

    /* W stanie bledu reaguje wylacznie klawisz CLx */
    if (errorFlag) {
        if (c == 'C' || c == 'c') {
            keyClx();
            updateDisplay();
        }
        return;
    }

    if (c >= '0' && c <= '9') {
        keyDigit(c - '0');
    } else {
        switch (c) {
        case '+': case '-': case '*': case '/':
            keyOperation((char)c);
            break;
        case '\r': case '\n':
            keyEnter();
            break;
        case 'C': case 'c':
            keyClx();
            break;
        case 'S': case 's':
            keyChs();
            break;
        case 'X': case 'x':
            keySwapXY();
            break;
        case 'R': case 'r':
            keyRollDown();
            break;
        default:
            return;             /* nieznany znak - ignorowany */
        }
    }

    updateDisplay();
}

static void uartPoll(void)
{
    u8 c;
    while (XUartLite_Recv(&uart, &c, 1) == 1) {
        handleChar(c);
    }
}

/* ===========================================================================
 *  9. ODSWIEZANIE WYSWIETLACZA (multipleksowanie + regulacja jasnosci)
 * ===========================================================================
 */

static void displayRefresh(void)
{
    int i;
    uint32_t tOn  = (uint32_t)brightness * SLOT_UNIT_US;
    uint32_t tOff = (uint32_t)(BRIGHT_LEVELS - brightness) * SLOT_UNIT_US;

    for (i = 0; i < NDIGITS; i++) {
#if AN_BIT0_IS_RIGHT
        uint8_t anMask = (uint8_t)(1u << i);
#else
        uint8_t anMask = (uint8_t)(1u << (NDIGITS - 1 - i));
#endif
        anWrite(0x00);              /* gaszenie anod przed zmiana segmentow */
        segWrite(dispBuf[i]);
        anWrite(anMask);
        delay_us(tOn);

        anWrite(0x00);              /* okres ciemny - regulacja jasnosci    */
        if (tOff) delay_us(tOff);

        uartPoll();                 /* odpytanie UART co ok. 400 us         */
    }
}

/* ===========================================================================
 * 10. INICJALIZACJA I PETLA GLOWNA
 * ===========================================================================
 */

int main(void)
{
    int status;

    status = XUartLite_Initialize(&uart, UART_DEVICE_ID);
    if (status != XST_SUCCESS) return XST_FAILURE;
    XUartLite_ResetFifos(&uart);

    status = XGpio_Initialize(&gpioSeg, GPIO_SEG_DEVICE_ID);
    if (status != XST_SUCCESS) return XST_FAILURE;
    status = XGpio_Initialize(&gpioAn, GPIO_AN_DEVICE_ID);
    if (status != XST_SUCCESS) return XST_FAILURE;
    status = XGpio_Initialize(&gpioLed, GPIO_LED_DEVICE_ID);
    if (status != XST_SUCCESS) return XST_FAILURE;

    XGpio_SetDataDirection(&gpioSeg, GPIO_SEG_CHANNEL, 0x00000000);  /* wyjscia */
    XGpio_SetDataDirection(&gpioAn,  GPIO_AN_CHANNEL,  0x00000000);
    XGpio_SetDataDirection(&gpioLed, GPIO_LED_CHANNEL, 0x00000000);

    anWrite(0x00);
    segWrite(SEG_BLANK);
    ledWrite(0x00);

    regX = regY = regZ = regT = 0;
    entering = entryNeg = errorFlag = 0;
    stackLift = 0;

    updateDisplay();

    xil_printf("\r\nKalkulator RPN (MicroBlaze) - gotowy.\r\n");
    xil_printf("0-9 +-*/ ENTER C(CLx) S(CHS) X(X<>Y) R(roll) , . (jasnosc)\r\n");

    for (;;) {
        displayRefresh();
    }

    return 0;
}
