----------------------------------------------------------------------------------
-- Testbench modulu top (monitor portu RS-232)
--
-- 1. reset na poczatku symulacji
-- 2. trzykrotne wyslanie kodu 01010011 (0x53) z Rys. 1:
--      ramka 1 - predkosc nominalna 9600 bps
--      ramka 2 - predkosc mniejsza o 4%  (9216 bps)
--      ramka 3 - predkosc wieksza o 4%   (9984 bps)
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

    constant CLK_PERIOD : time := 10 ns;                -- 100 MHz

    constant T_NOM  : time := 1 sec / 9600;             -- czas bitu, predkosc nominalna
    constant T_SLOW : time := 1 sec / 9216;             -- 9600 bps - 4%
    constant T_FAST : time := 1 sec / 9984;             -- 9600 bps + 4%

    constant TEST_BYTE : std_logic_vector (7 downto 0) := "01010011";  -- 0x53


    signal clk_i      : std_logic := '0';
    signal rst_i      : std_logic := '0';
    signal RXD_i      : std_logic := '1';               -- linia w stanie spoczynkowym
    signal led7_an_o  : std_logic_vector (3 downto 0);
    signal led7_seg_o : std_logic_vector (7 downto 0);

    signal done : boolean := false;

begin

    uut : entity work.top
        port map ( clk_i      => clk_i,
                   rst_i      => rst_i,
                   RXD_i      => RXD_i,
                   led7_an_o  => led7_an_o,
                   led7_seg_o => led7_seg_o );

    -- zegar 100 MHz, zatrzymywany po zakonczeniu testu
    clk_i <= not clk_i after CLK_PERIOD / 2 when not done else '0';

    stimulus : process

        -- wyslanie jednej ramki 8N1: bit startu, D0..D7, bit stopu
        procedure send_byte (data : std_logic_vector (7 downto 0); bit_time : time) is
        begin
            RXD_i <= '0';                               -- bit startu
            wait for bit_time;
            for i in 0 to 7 loop                        -- dane, D0 jako pierwszy
                RXD_i <= data(i);
                wait for bit_time;
            end loop;
            RXD_i <= '1';                               -- bit stopu
            wait for bit_time;
        end procedure;

    begin
        -- reset
        rst_i <= '1';
        wait for 100 ns;
        rst_i <= '0';
        wait for 200 us;

        -- ramka 1: predkosc nominalna
        send_byte(TEST_BYTE, T_NOM);

        -- ramka 2: predkosc mniejsza o 4%
        send_byte(TEST_BYTE, T_SLOW);

        -- ramka 3: predkosc wieksza o 4%
        send_byte(TEST_BYTE, T_FAST);

        wait for 3 ms;
        done <= true;
        wait;
    end process;

end Behavioral;