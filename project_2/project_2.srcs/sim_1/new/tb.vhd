----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2026 18:08:59
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

signal clk_i : STD_LOGIC := '0';
signal rst_i : STD_LOGIC := '0';
signal led_o : STD_LOGIC_VECTOR(2 downto 0);

begin

    dut : entity work.top
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            led_o => led_o
        );

    clk_i  <= not clk_i  after 10 ns;

    -- generowanie sygna³u reset
    process
    begin

        -- pierwszy reset na pocz¹tku symulacji
        rst_i <= '1';
        wait for 15 ns;

        rst_i <= '0';

        -- licznik przechodzi przez wszystkie stany (okres jednego stanu 20 ns, 8 stanów + 30 ns na reset podczas drugiego stanu)
        wait for 190 ns;

        -- drugi reset w trakcie dzia³ania
        rst_i <= '1';
        wait for 15 ns;

        rst_i <= '0';

        -- dalsze dzia³anie po resecie
        wait for 170 ns;

        wait;

    end process;

end Behavioral;
