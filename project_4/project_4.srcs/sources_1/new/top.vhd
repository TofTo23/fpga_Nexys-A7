----------------------------------------------------------------------------------
-- Monitor portu RS-232
--
-- Odebrany bajt (9600 bps, 8N1) wyswietlany jest szesnastkowo na dwoch
-- prawych cyfrach wyswietlacza: AN1 = starsza cyfra hex, AN0 = mlodsza.
-- Cyfry AN3 i AN2 sa wygaszone.
--
-- clk_i      - zegar 100 MHz
-- rst_i      - reset asynchroniczny, aktywny '1' (przycisk BTNR)
-- RXD_i      - wejscie danych RS-232
-- led7_an_o  - anody wyswietlacza (aktywne '0')
-- led7_seg_o - segmenty wyswietlacza (aktywne '0'), bit 7 = A, ..., bit 0 = DP
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk_i      : in  STD_LOGIC;
           rst_i      : in  STD_LOGIC;
           RXD_i      : in  STD_LOGIC;
           led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

    constant SEG_OFF : std_logic_vector (7 downto 0) := "11111111";    -- cyfra wygaszona

    -- dekoder: cyfra hex -> segmenty ABCDEFG + DP (aktywne '0')
    function hex2seg (hex : std_logic_vector (3 downto 0)) return std_logic_vector is
    begin
        case hex is             
            when "0000" => return "00000011";   -- 0
            when "0001" => return "10011111";   -- 1
            when "0010" => return "00100101";   -- 2
            when "0011" => return "00001101";   -- 3
            when "0100" => return "10011001";   -- 4
            when "0101" => return "01001001";   -- 5
            when "0110" => return "01000001";   -- 6
            when "0111" => return "00011111";   -- 7
            when "1000" => return "00000001";   -- 8
            when "1001" => return "00001001";   -- 9
            when "1010" => return "00010001";   -- A
            when "1011" => return "11000001";   -- b
            when "1100" => return "01100011";   -- C
            when "1101" => return "10000101";   -- d
            when "1110" => return "01100001";   -- E
            when others => return "01110001";   -- F
        end case;
    end function;

    signal rx_data  : std_logic_vector (7 downto 0);    -- ostatni odebrany bajt
    signal digits   : std_logic_vector (31 downto 0);

begin

    rx : entity work.receiver
        generic map ( clk_freq => 100000000,
                      baud     => 9600 )
        port map ( clk_i   => clk_i,
                   rst_i   => rst_i,
                   rxd_i   => RXD_i,
                   data_o  => rx_data);

    -- AN1 & AN0 
    digits <= SEG_OFF & SEG_OFF & hex2seg(rx_data(7 downto 4)) & hex2seg(rx_data(3 downto 0));

    disp : entity work.display
        generic map ( clk_div => 100000 )
        port map ( clk_i      => clk_i,
                   rst_i      => rst_i,
                   digit_i    => digits,
                   led7_an_o  => led7_an_o,
                   led7_seg_o => led7_seg_o );

end Behavioral;