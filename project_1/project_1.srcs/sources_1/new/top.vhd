----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2026 12:32:40
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( sw_i : in STD_LOGIC_VECTOR (7 downto 0);
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

    -- kolejnosc bitow led7_seg_o: 7=A, 6=B, 5=C, 4=D, 3=E, 2=F, 1=G, 0=DP

    constant SEG_E : STD_LOGIC_VECTOR (7 downto 0) := "01100001";
    constant SEG_O : STD_LOGIC_VECTOR (7 downto 0) := "00000011";
    -- '0' = parzysta liczba jedynek, '1' = nieparzysta liczba jedynek
    signal parity : STD_LOGIC;
    
begin

    parity <= sw_i(7) xor sw_i(6) xor sw_i(5) xor sw_i(4) xor
              sw_i(3) xor sw_i(2) xor sw_i(1) xor sw_i(0);

    -- wyswietlacz AN3 aktywny
    led7_an_o <= "0111";

    -- wybor wyswietlanego symbolu
    led7_seg_o <= SEG_O when parity = '1' else SEG_E;

end Behavioral;
