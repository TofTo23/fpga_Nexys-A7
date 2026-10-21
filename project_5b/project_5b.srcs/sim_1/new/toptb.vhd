----------------------------------------------------------------------------------
-- Testbench generatora figur Lissajous
--
-- 1. zaraz po starcie: przechwycenie jednej klatki VGA -> okrag z kropek
--    (ustawienia poczatkowe IP: X = Y = 0.1953125 MHz, faza Y = pi/2)
-- 2. ustawienie przyciskami X = 1, Y = 2, faza Y = pi/2 (SW = 64), BTND,
--    przechwycenie klatki -> parabola ramionami w dol
--
-- Kazda klatka jest zapisywana jako obraz 640x480 w formacie PBM
-- (klatka1.pbm, klatka2.pbm w katalogu symulacji, w Vivado:
--  <projekt>.sim/sim_1/behav/xsim/). Mozna go otworzyc np. w GIMP-ie.
-- Sprawdzane sa tez czasy VGA i zerowanie RGB poza obrazem.
--
-- 66 ms 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

    constant CLK_PERIOD : time := 10 ns;            -- 100 MHz
    constant T_PIX      : time := 40 ns;            -- 25 MHz

    signal clk_i   : std_logic := '0';
    signal sw_i    : std_logic_vector (7 downto 0) := (others => '0');
    signal btn_i   : std_logic_vector (3 downto 0) := (others => '0');
    signal red_o   : std_logic_vector (3 downto 0);
    signal green_o : std_logic_vector (3 downto 0);
    signal blue_o  : std_logic_vector (3 downto 0);
    signal hsync_o : std_logic;
    signal vsync_o : std_logic;

    signal done : boolean := false;

begin

    uut : entity work.top
        port map ( clk_i   => clk_i,
                   sw_i    => sw_i,
                   btn_i   => btn_i,
                   red_o   => red_o,
                   green_o => green_o,
                   blue_o  => blue_o,
                   hsync_o => hsync_o,
                   vsync_o => vsync_o );

    clk_i <= not clk_i after CLK_PERIOD / 2 when not done else '0';

    -- kontrola czasow VGA 640x480@60Hz
    hsync_check : process
        variable t_fall : time;
    begin
        wait until falling_edge(hsync_o);
        t_fall := now;
        loop
            wait until rising_edge(hsync_o) or done;
            exit when done;
            assert now - t_fall = 96 * T_PIX
                report "Zla dlugosc impulsu HSYNC" severity error;
            wait until falling_edge(hsync_o) or done;
            exit when done;
            assert now - t_fall = 800 * T_PIX
                report "Zly okres linii (HSYNC)" severity error;
            t_fall := now;
        end loop;
        wait;
    end process;

    vsync_check : process
        variable t_fall : time := 0 ns;
    begin
        loop
            wait until falling_edge(vsync_o) or done;
            exit when done;
            assert t_fall = 0 ns or now - t_fall = 525 * 800 * T_PIX
                report "Zly okres ramki (VSYNC)" severity error;
            t_fall := now;
            wait until rising_edge(vsync_o) or done;
            exit when done;
            assert now - t_fall = 2 * 800 * T_PIX
                report "Zla dlugosc impulsu VSYNC" severity error;
        end loop;
        wait;
    end process;

    stimulus : process

        -- przechwycenie jednej klatki do pliku PBM (640x480, 1 = bialy)
        procedure capture (name : string) is
            file f       : text open write_mode is name;
            variable l   : line;
            variable n_w : integer := 0;
        begin
            write(l, string'("P1"));      writeline(f, l);
            write(l, string'("640 480")); writeline(f, l);
            wait until falling_edge(vsync_o);
            -- k-ta linia po VSYNC: widoczne linie obrazu to k = 34 .. 513
            for k in 0 to 513 loop
                wait until falling_edge(hsync_o);
                wait for T_PIX / 2;                         -- srodek piksela
                -- po HSYNC: 96 synchronizacja + 48 tylny prog, potem 640 pikseli
                for p in 0 to 789 loop
                    if k >= 34 and p >= 144 and p < 784 then
                        if red_o(0) = '1' then
                            write(l, string'("1 "));
                            n_w := n_w + 1;
                        else
                            write(l, string'("0 "));
                        end if;
                    else
                        assert red_o = "0000" and green_o = "0000" and blue_o = "0000"
                            report "RGB rozne od zera poza obszarem obrazu" severity error;
                    end if;
                    assert red_o = green_o and green_o = blue_o
                        report "Skladowe RGB nie sa jednakowe" severity error;
                    wait for T_PIX;
                end loop;
                if k >= 34 then
                    writeline(f, l);
                end if;
            end loop;
            assert n_w > 0 report name & ": brak figury na ekranie" severity error;
            report name & ": zapisano klatke, bialych pikseli: " & integer'image(n_w);
        end procedure;

        -- ustawienie przelacznikow i wcisniecie przycisku
        procedure press (button : integer; value : integer) is
        begin
            sw_i <= std_logic_vector(to_unsigned(value, 8));
            wait for 1 us;
            btn_i(button) <= '1';
            wait for 1 us;
            btn_i(button) <= '0';
            wait for 1 us;
        end procedure;

    begin
        -- 1. ustawienia poczatkowe: okrag
        wait for 1 ms;
        capture("klatka1.pbm");

        -- 2. X = 1, Y = 2, faza Y = pi/2, wyczyszczenie ekranu
        press(3, 1);        -- BTNL: czestotliwosc X
        press(2, 2);        -- BTNC: czestotliwosc Y
        press(1, 64);       -- BTNR: faza Y (64 * 256 / 65536 = 1/4 okresu = pi/2)
        press(0, 0);        -- BTND: czyszczenie i reset DDS
        wait for 3 ms;      -- pelny okres X (ok. 1.3 ms) z zapasem
        capture("klatka2.pbm");

        report "Koniec symulacji";
        done <= true;
        wait;
    end process;

end Behavioral;