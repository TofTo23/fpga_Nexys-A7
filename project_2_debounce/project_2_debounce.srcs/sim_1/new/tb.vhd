----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2026 17:03:38
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

    signal sys_clk_i : STD_LOGIC := '0';
    signal rst_i : STD_LOGIC := '0';
    signal led_o : STD_LOGIC_VECTOR(2 downto 0);

    signal btn_clean : STD_LOGIC := '0';
    signal btn_bounce : STD_LOGIC;

begin
    dut : entity work.top
        generic map (
            DEBOUNCE_CYCLES => 200000
        )
        port map (
            sys_clk_i => sys_clk_i,
            clk_i     => btn_bounce,
            rst_i     => rst_i,
            led_o     => led_o
        );
    bounce_inst : entity work.bounce
        generic map (
            min_time => 100 us,
            max_time => 1 ms,
            max_cnt  => 2,
            seed     => 777
        )
        port map (
            in_i  => btn_clean,
            out_o => btn_bounce
        );

    sys_clk_i <= not sys_clk_i after 5 ns;

    process
    begin

        rst_i <= '1';
        wait for 1 ms;
        rst_i <= '0';
        wait for 5 ms;
        for i in 1 to 4 loop

            btn_clean <= '1';
            wait for 10 ms;
            btn_clean <= '0';
            wait for 10 ms;
        end loop;

        rst_i <= '1';
        wait for 1 ms;
        rst_i <= '0';
        wait for 5 ms;

        for i in 1 to 8 loop
            btn_clean <= '1';
            wait for 10 ms;
            btn_clean <= '0';
            wait for 10 ms;
        end loop;
        wait;

    end process;

end Behavioral;
