library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
    Generic ( clk_div : INTEGER := 100000 );
    Port ( clk_i      : in  STD_LOGIC;
           digit_i    : in  STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end display;

architecture Behavioral of display is

    signal cnt : integer range 0 to clk_div - 1 := 0;   -- dzielnik czestotliwosci
    signal sel : integer range 0 to 3 := 0;             -- numer aktywnej cyfry

begin

    process (clk_i)
    begin
        if rising_edge(clk_i) then

            -- dzielnik: co clk_div taktow przejscie do kolejnej cyfry
            if cnt = clk_div - 1 then
                cnt <= 0;
                if sel = 3 then
                    sel <= 0;
                else
                    sel <= sel + 1;
                end if;
            else
                cnt <= cnt + 1;
            end if;

            -- multiplekser: wybor anody i odpowiadajacych jej segmentow
            case sel is
                when 0 =>
                    led7_an_o  <= "1110";
                    led7_seg_o <= digit_i(7 downto 0);
                when 1 =>
                    led7_an_o  <= "1101";
                    led7_seg_o <= digit_i(15 downto 8);
                when 2 =>
                    led7_an_o  <= "1011";
                    led7_seg_o <= digit_i(23 downto 16);
                when others =>
                    led7_an_o  <= "0111";
                    led7_seg_o <= digit_i(31 downto 24);
            end case;

        end if;
    end process;

end Behavioral;