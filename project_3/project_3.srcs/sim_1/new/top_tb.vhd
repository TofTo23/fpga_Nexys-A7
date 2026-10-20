----------------------------------------------------------------------------------
-- 25ms 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
end top_tb;

architecture sim of top_tb is

    component top is
        Port ( clk_i      : in  STD_LOGIC;
               btn_i      : in  STD_LOGIC_VECTOR (3 downto 0);
               sw_i       : in  STD_LOGIC_VECTOR (7 downto 0);
               led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
               led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal clk_i      : STD_LOGIC := '0';
    signal btn_i      : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal sw_i       : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal led7_an_o  : STD_LOGIC_VECTOR (3 downto 0);
    signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);

    -- sygnaly pomocnicze: ostatnio wyswietlony stan segmentow kazdej cyfry
    signal an3_seg : STD_LOGIC_VECTOR (7 downto 0) := (others => '1');
    signal an2_seg : STD_LOGIC_VECTOR (7 downto 0) := (others => '1');
    signal an1_seg : STD_LOGIC_VECTOR (7 downto 0) := (others => '1');
    signal an0_seg : STD_LOGIC_VECTOR (7 downto 0) := (others => '1');

    constant CLK_PERIOD : TIME := 10 ns;      -- 100 MHz

begin

    uut : top
        port map ( clk_i      => clk_i,
                   btn_i      => btn_i,
                   sw_i       => sw_i,
                   led7_an_o  => led7_an_o,
                   led7_seg_o => led7_seg_o );

    -- zegar 100 MHz
    clk_i <= not clk_i after CLK_PERIOD / 2;

    -- demultiplekser pomocniczy: co aktualnie swieci na kazdej cyfrze
    process (clk_i)
    begin
        if falling_edge(clk_i) then
            case led7_an_o is
                when "0111" => an3_seg <= led7_seg_o;
                when "1011" => an2_seg <= led7_seg_o;
                when "1101" => an1_seg <= led7_seg_o;
                when "1110" => an0_seg <= led7_seg_o;
                when others => null;
            end case;
        end if;
    end process;

    -- pobudzenia
    stim : process
    begin
        -- stan poczatkowy: kropki na AN3 i AN1, na przelacznikach cyfra A
        sw_i  <= "1010" & x"A";
        btn_i <= "0000";
        wait for 1 ms;

        -- BTNL -> AN3
        btn_i <= "1000";
        wait for 1 ms;                     -- przycisk trzymany 1 ms
        btn_i <= "0000";
        wait for 1 ms;                     -- srodek 2 ms przerwy
        sw_i(3 downto 0) <= x"5";
        wait for 1 ms;

        -- BTNC -> AN2
        btn_i <= "0100";
        wait for 1 ms;
        btn_i <= "0000";
        wait for 1 ms;
        sw_i(3 downto 0) <= x"C";
        wait for 1 ms;

        -- BTNR -> AN1
        btn_i <= "0010";
        wait for 1 ms;
        btn_i <= "0000";
        wait for 1 ms;
        sw_i(3 downto 0) <= x"3";
        wait for 1 ms;

        -- BTND -> AN0
        btn_i <= "0001";
        wait for 1 ms;
        btn_i <= "0000";
        wait for 2 ms;

        -- pierwsza zmiana kropek (przyciski zwolnione): AN2 i AN0
        sw_i(7 downto 4) <= "0101";
        wait for 6 ms;

        -- druga zmiana kropek: AN3 i AN2
        sw_i(7 downto 4) <= "1100";
        wait for 6 ms;

        wait;
    end process;

end sim;