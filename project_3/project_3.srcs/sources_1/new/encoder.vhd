----------------------------------------------------------------------------------
-- Enkoder i pamiec wyswietlacza (blok testujacy komponent display)
--
-- clk_i   - zegar systemowy (100 MHz)
-- btn_i   - przyciski: (3) BTNL -> AN3, (2) BTNC -> AN2, (1) BTNR -> AN1, (0) BTND -> AN0
-- sw_i    - SW3..SW0: cyfra szesnastkowa do wpisania
--           SW7..SW4: kropki dziesietne DP cyfr AN3..AN0
-- digit_o - stan segmentow 4 cyfr dla bloku display ('0' = segment swieci)
--
-- Nacisniecie przycisku wpisuje do pamieci danej cyfry kod 7-segmentowy
-- wartosci ustawionej na SW3..SW0. Po zwolnieniu przycisku cyfra pozostaje
-- zapamietana. Kropki DP nie sa pamietane - zaleza wprost od SW7..SW4.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder is
    Port ( clk_i   : in  STD_LOGIC;
           btn_i   : in  STD_LOGIC_VECTOR (3 downto 0);
           sw_i    : in  STD_LOGIC_VECTOR (7 downto 0);
           digit_o : out STD_LOGIC_VECTOR (31 downto 0));
end encoder;

architecture Behavioral of encoder is

    -- kod 7-segmentowy cyfry 
    signal seg : STD_LOGIC_VECTOR (6 downto 0);

    -- pamiec segmentow 
    signal mem3 : STD_LOGIC_VECTOR (6 downto 0) := "1111111";
    signal mem2 : STD_LOGIC_VECTOR (6 downto 0) := "1111111";
    signal mem1 : STD_LOGIC_VECTOR (6 downto 0) := "1111111";
    signal mem0 : STD_LOGIC_VECTOR (6 downto 0) := "1111111";

    -- synchronizator przyciskow (wejscia asynchroniczne wzgledem clk_i)
    signal btn_s1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal btn_s2 : STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin
    with sw_i(3 downto 0) select
        seg <= "0000001" when "0000",   -- 0
               "1001111" when "0001",   -- 1
               "0010010" when "0010",   -- 2
               "0000110" when "0011",   -- 3
               "1001100" when "0100",   -- 4
               "0100100" when "0101",   -- 5
               "0100000" when "0110",   -- 6
               "0001111" when "0111",   -- 7
               "0000000" when "1000",   -- 8
               "0000100" when "1001",   -- 9
               "0001000" when "1010",   -- A
               "1100000" when "1011",   -- b
               "0110001" when "1100",   -- C
               "1000010" when "1101",   -- d
               "0110000" when "1110",   -- E
               "0111000" when others;   -- F

    -- wpis cyfry
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            btn_s1 <= btn_i;
            btn_s2 <= btn_s1;

            if btn_s2(3) = '1' then
                mem3 <= seg;
            end if;
            if btn_s2(2) = '1' then
                mem2 <= seg;
            end if;
            if btn_s2(1) = '1' then
                mem1 <= seg;
            end if;
            if btn_s2(0) = '1' then
                mem0 <= seg;
            end if;
        end if;
    end process;

    digit_o <= mem3 & (not sw_i(7)) &
               mem2 & (not sw_i(6)) &
               mem1 & (not sw_i(5)) &
               mem0 & (not sw_i(4));

end Behavioral;