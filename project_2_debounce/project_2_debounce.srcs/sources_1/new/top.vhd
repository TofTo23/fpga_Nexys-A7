----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2026 17:02:51
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
 generic (
        -- Dla zegara 100 MHz: 200000 -> 2 ms
        DEBOUNCE_CYCLES : positive := 200000
    );
    Port ( sys_clk_i : in STD_LOGIC;
           clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (2 downto 0));
end top;

architecture Behavioral of top is

    signal bin_cnt : unsigned(2 downto 0) := (others => '0');
    signal gray_cnt : unsigned(2 downto 0);

    -- synchronizacja przycisku
    signal btn_sync1 : STD_LOGIC := '0';
    signal btn_sync2 : STD_LOGIC := '0';

    -- stan przycisku po debouncingu
    signal btn_state : STD_LOGIC := '0';
    signal btn_prev  : STD_LOGIC := '0';

    -- licznik debouncera
    signal debounce_cnt : integer range 0 to DEBOUNCE_CYCLES - 1 := 0;

begin
    process(sys_clk_i, rst_i)
    begin
        if rst_i = '1' then
            btn_sync1   <= '0';
            btn_sync2   <= '0';
            btn_state   <= '0';
            debounce_cnt <= 0;

        elsif sys_clk_i'event and sys_clk_i = '1' then
            -- synchronizacja przycisku z zegarem systemowym
            btn_sync1 <= clk_i;
            btn_sync2 <= btn_sync1;

            if btn_sync2 = btn_state then
                debounce_cnt <= 0;
            else
                if debounce_cnt = DEBOUNCE_CYCLES - 1 then
                    btn_state <= btn_sync2;
                    debounce_cnt <= 0;
                else
                    debounce_cnt <= debounce_cnt + 1;
                end if;
            end if;
        end if;
    end process;


    process(sys_clk_i, rst_i)
    begin
        -- reset asynchroniczny
        if rst_i = '1' then
            bin_cnt  <= (others => '0');
            btn_prev <= '0';
        elsif sys_clk_i'event and sys_clk_i = '1' then
            btn_prev <= btn_state;
            -- wykrycie naciœniêcia przycisku
            if btn_state = '1' and btn_prev = '0' then
                bin_cnt <= bin_cnt + 1;
            end if;
        end if;
    end process;

    gray_cnt <= bin_cnt xor ('0' & bin_cnt(2 downto 1));
    led_o <= std_logic_vector(gray_cnt);

end Behavioral;