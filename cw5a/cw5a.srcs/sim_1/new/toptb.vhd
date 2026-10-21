----------------------------------------------------------------------------------
-- Testbench modulu top (drukarka pseudograficzna RS-232), 9600 bps
--
-- 1. wyslanie "a" + Enter -> uklad drukuje linie (16 wierszy po 8 pikseli),
--    wydruk odczytany z TXD_o jest wypisywany w konsoli Tcl
-- 2. w trakcie druku wyslanie 70 x 'b' -> FIFO (64) sie przepelnia,
--    LD0 musi sie zapalic
-- 3. po wydrukowaniu linii automat pobiera znak z FIFO -> zwalnia sie
--    miejsce, LD0 musi zgasnac
--
-- 175ms
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

    constant CLK_PERIOD : time := 10 ns;                -- 100 MHz
    constant T_BIT      : time := 1 sec / 9600;         -- czas jednego bitu

    signal clk_i      : std_logic := '0';
    signal RXD_i      : std_logic := '1';
    signal TXD_o      : std_logic;
    signal ld0        : std_logic;
    signal led7_an_o  : std_logic_vector (3 downto 0);
    signal led7_seg_o : std_logic_vector (7 downto 0);

    signal n_rows : integer := 0;                       -- liczba wydrukowanych wierszy
    signal done   : boolean := false;

begin

    uut : entity work.top
        port map ( clk_i      => clk_i,
                   RXD_i      => RXD_i,
                   TXD_o      => TXD_o,
                   ld0        => ld0,
                   led7_an_o  => led7_an_o,
                   led7_seg_o => led7_seg_o );

    clk_i <= not clk_i after CLK_PERIOD / 2 when not done else '0';

    -- odbior tego, co uklad wysyla na TXD_o; kazdy wiersz wypisywany w konsoli
    monitor : process
        variable b : std_logic_vector (7 downto 0);
        variable l : line;
    begin
        loop
            wait until TXD_o = '0' or done;
            exit when done;
            wait for T_BIT / 2;                         -- srodek bitu startu
            for i in 0 to 7 loop
                wait for T_BIT;
                b(i) := TXD_o;
            end loop;
            wait for T_BIT;                             -- bit stopu
            case to_integer(unsigned(b)) is
                when 13 => null;                        -- CR
                when 10 => writeline(output, l);        -- LF: wypisz wiersz
                           n_rows <= n_rows + 1;
                when others => write(l, character'val(to_integer(unsigned(b))));
            end case;
        end loop;
        wait;
    end process;

    stimulus : process

        -- wyslanie jednego znaku 8N1
        procedure send_byte (data : integer) is
            variable d : std_logic_vector (7 downto 0);
        begin
            d := std_logic_vector(to_unsigned(data, 8));
            RXD_i <= '0';                               -- bit startu
            wait for T_BIT;
            for i in 0 to 7 loop                        -- dane, D0 jako pierwszy
                RXD_i <= d(i);
                wait for T_BIT;
            end loop;
            RXD_i <= '1';                               -- bit stopu
            wait for T_BIT;
        end procedure;

    begin
        wait for 100 us;

        -- 1. "a" + Enter: start druku linii
        send_byte(character'pos('a'));
        send_byte(13);

        -- 2. w trakcie druku 70 znakow -> przepelnienie FIFO
        assert ld0 = '0' report "LD0 zapalona przed przepelnieniem" severity error;
        for i in 1 to 70 loop
            send_byte(character'pos('b'));
        end loop;
        assert ld0 = '1' report "LD0 nie zapalila sie po przepelnieniu" severity error;
        report "Przepelnienie: LD0 = " & std_logic'image(ld0);

        -- 3. koniec druku -> automat czyta z FIFO -> LD0 gasnie
        wait until ld0 = '0' for 200 ms;
        assert ld0 = '0' report "LD0 nie zgasla po zwolnieniu bufora" severity error;
        wait until n_rows = 16 for 5 ms;                -- ostatni LF jest jeszcze wysylany
        assert n_rows = 16 report "Linia nie zostala wydrukowana w calosci" severity error;
        report "Zwolnienie bufora: LD0 = " & std_logic'image(ld0)
               & ", wydrukowane wiersze: " & integer'image(n_rows);

        wait for 1 ms;
        report "Koniec symulacji";
        done <= true;
        wait;
    end process;

end Behavioral;