----------------------------------------------------------------------------------
-- Odbiornik RS-232: 8 bitow danych, bez parzystosci, 1 bit stopu (8N1)
--
-- clk_i    - zegar systemowy (100 MHz)
-- rst_i    - reset asynchroniczny, aktywny '1'
-- rxd_i    - wejscie szeregowe (stan spoczynkowy '1')
--
-- data_o   - ostatni poprawnie odebrany bajt
-- valid_o  - impuls '1' na jeden takt clk_i po odebraniu poprawnej ramki
--
-- clk_freq - czestotliwosc zegara clk_i [Hz]
-- baud     - szybkosc transmisji [bps]
--
-- Zasada dzialania: po wykryciu '0' na linii odbiornik odczekuje pol bitu
-- (srodek bitu startu), a nastepnie co jeden okres bitu probkuje linie:
-- 8 razy dane (D0 jako pierwszy) i raz bit stopu. Probkowanie w srodku bitu
-- daje zapas ok. +/-0,5 bitu na 9,5 bitu ramki, czyli tolerancje ok. +/-5%.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity receiver is
    Generic ( clk_freq : INTEGER := 100000000;
              baud     : INTEGER := 9600 );
    Port ( clk_i   : in  STD_LOGIC;
           rst_i   : in  STD_LOGIC;
           rxd_i   : in  STD_LOGIC;
           data_o  : out STD_LOGIC_VECTOR (7 downto 0));
end receiver;

architecture Behavioral of receiver is

    -- liczba taktow zegara na jeden bit (z zaokragleniem): 100 MHz / 9600 = 10417
    constant BIT_TIME  : integer := (clk_freq + baud / 2) / baud;
    constant HALF_TIME : integer := BIT_TIME / 2;

    type state_t is (IDLE, START, DATA, STOP);
    signal state : state_t := IDLE;

    signal rxd_meta : std_logic := '1';     -- 1. przerzutnik synchronizatora
    signal rxd_sync : std_logic := '1';     -- 2. przerzutnik synchronizatora

    signal cnt    : integer range 0 to BIT_TIME - 1 := 0;   -- licznik czasu bitu
    signal bit_no : integer range 0 to 7 := 0;              -- numer odbieranego bitu
    signal shreg  : std_logic_vector (7 downto 0) := (others => '0');

begin

    -- synchronizacja asynchronicznego wejscia rxd_i z zegarem clk_i
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            rxd_meta <= '1';
            rxd_sync <= '1';
        elsif rising_edge(clk_i) then
            rxd_meta <= rxd_i;
            rxd_sync <= rxd_meta;
        end if;
    end process;

    -- automat odbiornika
    process (clk_i, rst_i)
    begin
        if rst_i = '1' then
            state   <= IDLE;
            cnt     <= 0;
            bit_no  <= 0;
            shreg   <= (others => '0');
            data_o  <= (others => '0');
        elsif rising_edge(clk_i) then
            case state is
                -- oczekiwanie na poczatek bitu startu
                when IDLE =>
                    cnt    <= 0;
                    bit_no <= 0;
                    if rxd_sync = '0' then
                        state <= START;
                    end if;
                -- pol bitu pozniej: sprawdzenie, czy to faktycznie bit startu
                when START =>
                    if cnt = HALF_TIME - 1 then
                        cnt <= 0;
                        if rxd_sync = '0' then
                            state <= DATA;
                        else
                            state <= IDLE;      -- zaklocenie, nie bit startu
                        end if;
                    else
                        cnt <= cnt + 1;
                    end if;
                -- probkowanie bitow danych w srodku kazdego bitu, D0 jako pierwszy
                when DATA =>
                    if cnt = BIT_TIME - 1 then
                        cnt   <= 0;
                        shreg <= rxd_sync & shreg(7 downto 1);
                        if bit_no = 7 then
                            state <= STOP;
                        else
                            bit_no <= bit_no + 1;
                        end if;
                    else
                        cnt <= cnt + 1;
                    end if;
                -- srodek bitu stopu: ramka poprawna tylko, gdy linia jest w '1'
                when STOP =>
                    if cnt = BIT_TIME - 1 then
                        if rxd_sync = '1' then
                            data_o  <= shreg;
                        end if;
                        state <= IDLE;
                    else
                        cnt <= cnt + 1;
                    end if;
            end case;
        end if;
    end process;

end Behavioral;