library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
    generic (
        clk_div   : positive := 100_000;       -- zmiana cyfry co 1 ms przy 100 MHz
        blink_div : positive := 25_000_000     -- zmiana fazy migania co 250 ms
    );
    port (
        clk_i      : in  std_logic;
        rst_i      : in  std_logic;
        digit_i    : in  std_logic_vector(15 downto 0);
        selected_i : in  std_logic_vector(1 downto 0); -- 0=prawa, 3=lewa
        edit_i     : in  std_logic;
        led7_an_o  : out std_logic_vector(3 downto 0);
        led7_seg_o : out std_logic_vector(7 downto 0)
    );
end display;

architecture rtl of display is
    signal mux_count   : integer range 0 to clk_div-1 := 0;
    signal blink_count : integer range 0 to blink_div-1 := 0;
    signal sel         : integer range 0 to 3 := 0;
    signal blink_phase : std_logic := '0';

    function hex_to_7seg(x : std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
        -- Basys 3: aktywne '0'; kolejnosc bitow DP,G,F,E,D,C,B,A.
        case x is
            when "0000" => return x"03"; -- 0
            when "0001" => return x"9F"; -- 1
            when "0010" => return x"25"; -- 2
            when "0011" => return x"0D"; -- 3
            when "0100" => return x"99"; -- 4
            when "0101" => return x"49"; -- 5
            when "0110" => return x"41"; -- 6
            when "0111" => return x"1F"; -- 7
            when "1000" => return x"01"; -- 8
            when "1001" => return x"09"; -- 9
            when "1010" => return x"11"; -- A
            when "1011" => return x"C1"; -- b
            when "1100" => return x"63"; -- C
            when "1101" => return x"85"; -- d
            when "1110" => return x"61"; -- E
            when others => return x"71"; -- F
        end case;
    end function;
begin
    process (clk_i, rst_i)
        variable nibble : std_logic_vector(3 downto 0);
        variable chosen : boolean;
    begin
        if rst_i = '1' then
            mux_count   <= 0;
            blink_count <= 0;
            sel         <= 0;
            blink_phase <= '0';
            led7_an_o   <= "1111";
            led7_seg_o  <= x"FF";
        elsif rising_edge(clk_i) then
            if mux_count = clk_div-1 then
                mux_count <= 0;
                if sel = 3 then
                    sel <= 0;
                else
                    sel <= sel + 1;
                end if;
            else
                mux_count <= mux_count + 1;
            end if;

            if blink_count = blink_div-1 then
                blink_count <= 0;
                blink_phase <= not blink_phase;
            else
                blink_count <= blink_count + 1;
            end if;

            chosen := false;
            case sel is
                when 0 =>
                    led7_an_o <= "1110";
                    nibble := digit_i(3 downto 0);
                    chosen := (selected_i = "00");
                when 1 =>
                    led7_an_o <= "1101";
                    nibble := digit_i(7 downto 4);
                    chosen := (selected_i = "01");
                when 2 =>
                    led7_an_o <= "1011";
                    nibble := digit_i(11 downto 8);
                    chosen := (selected_i = "10");
                when others =>
                    led7_an_o <= "0111";
                    nibble := digit_i(15 downto 12);
                    chosen := (selected_i = "11");
            end case;

            if edit_i = '1' and chosen and blink_phase = '1' then
                led7_seg_o <= x"FF";
            else
                led7_seg_o <= hex_to_7seg(nibble);
            end if;
        end if;
    end process;
end rtl;