----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2026 14:31:12
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
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           led_o : out STD_LOGIC_VECTOR (2 downto 0));
end top;

architecture Behavioral of top is
    signal bin_cnt  : unsigned(2 downto 0) := (others => '0');
    signal gray_cnt : unsigned(2 downto 0);
begin
 -- 3-bitowy licznik binarny
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            bin_cnt <= (others => '0');
        elsif rising_edge(clk_i) then
            bin_cnt <= bin_cnt + 1;
        end if;
    end process;

    -- Konwersja binarnego stanu licznika na kod Graya:
    gray_cnt <= bin_cnt xor ('0' & bin_cnt(2 downto 1));

    led_o <= std_logic_vector(gray_cnt);

end Behavioral;
