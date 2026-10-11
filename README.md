# FPGA lab projects (Nexys-A7, VHDL)


## proj3: LED display control


### Task

The main goal of this exercise is to design a sub-block that drives four digits of an LED display, to be reused in later exercises.

To check that it works, embed it in a circuit that lets you set (using buttons and switches) and show any 4-character hexadecimal number on the LED display, including decimal points. Then run a functional simulation and verify the design in practice by programming the test board.

Only the right half (4 digits) of the 7-segment display is used. The left half may show something as well; ignore it.

### Display block interface

This block will be needed again in later exercises.

![Display control block interface](http://www.ue.eti.pg.gda.pl/pucair1/cw3s/led_disp_pliki/image001.gif)

*Fig. 1: Interface of the display control block.*

| Port | Meaning |
| --- | --- |
| `clk_i` | Clock input, 100 MHz. |
| `rst_i` | Asynchronous reset, active high (`'1'`). After `rst_i` is asserted, all display segments should light up. |
| `digit_i` | 32-bit input in which each bit corresponds to one segment (the 8 most significant bits belong to digit AN3, and so on). |
| `led7_an_o` | Output driving the display anodes (selects which digit is lit). |
| `led7_seg_o` | Output driving the segments (selects which segments are lit). |

### How the display works

The display consists of four 7-segment LED digits whose corresponding segments are wired together, so multiplexing is required.

- To light a segment, drive **`'0'`** on both the digit line (ANx) and the segment line (A–G or DP).
- The required multiplexing frequency is 1 kHz, i.e. the display switches to the next digit every 1 ms.
- The division ratio that turns the 100 MHz system clock into the 1 kHz multiplexing frequency should be a changeable parameter of the `display` component.

![Segment connections](http://www.ue.eti.pg.gda.pl/pucair1/cw3s/led_disp_pliki/image002.gif)

*Fig. 2: Connection of the individual display segments, with an example of showing the digit '2'.*

### Second component: encoder and display memory

This component is used to test the `display` block and should behave as follows:

1. Switches **SW3**, **SW2**, **SW1**, **SW0** set a 4-bit value.
2. Pressing **BTNL** shows the value currently set on **SW3–SW0** on digit **AN3**, in hexadecimal. The other buttons work the same way: **BTNC** → **AN2**, **BTNR** → **AN1**, **BTND** → **AN0**. After the button is pressed and released, the character should stay lit until a new value is written.
3. Turning **SW7** on lights the decimal point (**DP**) of digit **AN3**, and turning it off switches that DP off. The same applies to **SW6** → **DP AN2**, **SW5** → **DP AN1**, **SW4** → **DP AN0**. This function must work independently of the state of the **BTNx** buttons.

![Block diagram](http://www.ue.eti.pg.gda.pl/pucair1/cw3s/led_disp_pliki/image003.gif)

*Fig. 3: Block diagram of the complete circuit.*

### Minimum simulation requirements

- Emulate pressing and releasing each BTNx button in turn. Hold each button for 1 ms and keep it released for 2 ms.
- In the middle of the interval between a release and the next press, change SW3–0 to any hexadecimal digit different from the previous ones.
- Set SW7–4 at the start so that any 2 decimal points are lit, then change them at least twice (the BTNx buttons should be released while you do).
- Let the simulation run long enough to show all entered digits being displayed and the decimal points changing.

An example of this simulation is shown as waveforms near the end of the presentation: [Vivado demonstration](http://www.ue.eti.pg.gda.pl/isplab/vivado_demo.mp4).

### Top-level VHDL entity

Fragment of the main VHDL design file with the port declarations:

```vhdl
entity top is
    Port ( clk_i      : in  STD_LOGIC;
           btn_i      : in  STD_LOGIC_VECTOR (3 downto 0);
           sw_i       : in  STD_LOGIC_VECTOR (7 downto 0);
           led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;
```

Button mapping:

| Signal | Button |
| --- | --- |
| `btn_i(3)` | BTNL |
| `btn_i(2)` | BTNC |
| `btn_i(1)` | BTNR |
| `btn_i(0)` | BTND |

---

## proj4: RS-232 port monitor


### Task

Design an RS-232 data receiver module for the following transmission parameters:

- 8 data bits
- no parity bit
- one stop bit
- 9600 bps
- no hardware flow control

Connect the module to the `display` module from the previous assignment (proj3) so that, after receiving data, the RS-232 receiver shows it on the LED display in hexadecimal (2 hex digits). Use any two adjacent digits of the display to show the received code.

Only the right half (4 digits) of the 7-segment display is used. The left half may show something as well; ignore it.

### Inputs and outputs

| Port | Meaning |
| --- | --- |
| `clk_i` | 100 MHz clock. |
| `rst_i` | Asynchronous reset (button BTNR). |
| `RXD_i` | RS-232 data input. |
| `led7_an_o` | Output driving the anodes of the LED digits. |
| `led7_seg_o` | Output driving the segments of the LED digits. |

Run a functional simulation and verify the design in practice by programming the test board.

### Sending data to the board (PuTTY)

1. Start PuTTY and choose the "Serial" connection type.
2. Enter the speed (9600) and the port: COMx, where x is the port number.
3. To find the port number, open Device Manager (on the remote computer it is easy to find with the search "magnifying glass" button). Under "Ports (COM & LPT)" look for the device named "USB Serial Port"; the port number is shown next to it.
4. Turn on local echo so that the characters sent to the board are visible on screen: click the "Terminal" category and select "Force on" for "Local echo".
5. Click "Open" to open the connection.

Pressing a key on the keyboard should show its ASCII code on the LED display.

### Transmitting and receiving RS-232 signals

RS-232 signals are sent and received serially, on two separate lines, one for each direction (to and from the device).

- While nothing is being transmitted, the line stays high.
- A transmission begins with a start bit, which is a logic **"0"** lasting one bit period, i.e. the reciprocal of the transmission speed. In our case that is 1/9600 s. All following bits are sent with the same duration.
- The data bits follow serially, from the least significant bit to the most significant bit (**D0**–**D7**).
- Next comes the parity bit, which is the logical **XOR** of the data bits **D0**–**D7**. The parity bit is optional and is not used in this assignment.
- The end of the transmission is signalled by stop bits, usually 1 or 2 of them.

The figure below shows an example signal that meets the requirements of this assignment and carries the code **01010011**.

![RS-232 transmission](http://www.ue.eti.pg.gda.pl/pucair1/cw4s/rs232_pliki/image001.gif)

*Fig. 1: Example transmission of the code 01010011 over RS-232.*

Additional information about the RS-232 standard (in Polish):

- <http://www.fizyka.umk.pl/~ptarg/labview/folie/RS232.pdf>
- <http://pl.wikipedia.org/wiki/RS-232>

### Minimum simulation requirements

- Perform a reset at the beginning of the simulation.
- During the simulation, send the data from the example (Fig. 1) three times:
  1. at the nominal speed (9600 bps),
  2. at a speed 4% lower than nominal,
  3. at a speed 4% higher than nominal.

> **Note!** The design must contain a flip-flop that synchronises the `RXD_i` signal with the clock.

### Top-level VHDL entity

Fragment of the main VHDL design file with the port declarations:

```vhdl
entity top is
    Port ( clk_i      : in  STD_LOGIC;
           rst_i      : in  STD_LOGIC;
           RXD_i      : in  STD_LOGIC;
           led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;
```
