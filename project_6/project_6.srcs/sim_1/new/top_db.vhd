library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_tb is
end top_tb;

architecture sim of top_tb is

    -- Sygna³y testowane
    signal clk_i      : std_logic := '0';
    signal rst_i      : std_logic := '0';
    signal button_i   : std_logic_vector(3 downto 0) := (others => '0');
    signal led7_an_o  : std_logic_vector(3 downto 0);
    signal led7_seg_o : std_logic_vector(7 downto 0);

    -- Zegar 100 MHz (okres 10 ns)
    constant CLK_PERIOD : time := 10 ns;

    -- Procedura pomocnicza do symulacji naciœniêcia przycisku
    procedure press_button(
        constant btn_index : in integer;
        constant duration  : in time;
        signal   btn_sig   : out std_logic_vector(3 downto 0)
    ) is
    begin
        btn_sig(btn_index) <= '1';
        wait for duration;
        btn_sig(btn_index) <= '0';
        wait for 20 us; -- przerwa na ustabilizowanie po puszczeniu
    end procedure;

begin

    -- Instancja testowanego modu³u g³ównego (UUT)
    uut : entity work.top
        port map (
            clk_i      => clk_i,
            rst_i      => rst_i,
            button_i   => button_i,
            led7_an_o  => led7_an_o,
            led7_seg_o => led7_seg_o
        );

    -- Generator zegara 100 MHz
    clk_process : process
    begin
        while true loop
            clk_i <= '0';
            wait for CLK_PERIOD / 2;
            clk_i <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Proces stymulacji
    stim_proc : process
    begin
        -- 1. Reset pocz¹tkowy
        rst_i <= '1';
        wait for 200 ns;
        rst_i <= '0';
        wait for 50 us;

        -- Uwaga: W domyœlnej konfiguracji button_if DEBOUNCE_MS=10ms, LONG_PRESS_MS=500ms.
        -- Poni¿sze czasy odpowiadaj¹ domyœlnym parametrom modu³u button_if:
        -- Jeœli testujesz na standardowym button_if.vhd:
        -- Krótkie naciœniêcie: >15 ms i <500 ms (np. 30 ms)
        -- D³ugie naciœniêcie: >500 ms (np. 550 ms)

        -- 2. D³ugie naciœniêcie BTNL (button_i(3)) -> Wejœcie w tryb edycji
        report "Test: Wejscie w tryb edycji (dlugie BTNL)...";
        press_button(3, 520 ms, button_i);
        wait for 20 ms;

        -- 3. Zwiêkszenie prawej cyfry przyciskiem BTNU (button_i(1))
        report "Test: Zwiekszenie cyfry (BTNU)...";
        press_button(1, 20 ms, button_i);
        wait for 20 ms;
        press_button(1, 20 ms, button_i);
        wait for 20 ms;

        -- 4. Przejœcie do cyfry w lewo za pomoc¹ krótkiego BTNL (button_i(3))
        report "Test: Przesuniecie wyboru w lewo (krotkie BTNL)...";
        press_button(3, 25 ms, button_i);
        wait for 20 ms;

        -- 5. Zmniejszenie wybranej cyfry przyciskiem BTND (button_i(0)) -> test zawijania 0 -> F
        report "Test: Zmniejszenie cyfry z zawinieciem 0 -> F (BTND)...";
        press_button(0, 20 ms, button_i);
        wait for 20 ms;

        -- 6. Przesuniêcie wyboru w prawo przyciskiem BTNR (button_i(2))
        report "Test: Przesuniecie wyboru w prawo (BTNR)...";
        press_button(2, 20 ms, button_i);
        wait for 20 ms;

        -- 7. Wyjœcie z trybu edycji (d³ugie naciœniêcie BTNL)
        report "Test: Wyjscie z trybu edycji (dlugie BTNL)...";
        press_button(3, 520 ms, button_i);
        wait for 50 ms;

        report "Symulacja zakonczona sukcesem." severity note;
        wait;
    end process;

end sim;