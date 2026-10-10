----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2026 17:11:32
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
    Port ( clk_i      : in  STD_LOGIC;
           btn_i      : in  STD_LOGIC_VECTOR (3 downto 0);
           sw_i       : in  STD_LOGIC_VECTOR (7 downto 0);
           led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

    component encoder is
        Port ( clk_i   : in  STD_LOGIC;
               btn_i   : in  STD_LOGIC_VECTOR (3 downto 0);
               sw_i    : in  STD_LOGIC_VECTOR (7 downto 0);
               digit_o : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
 
    component display is
        Generic ( clk_div : INTEGER := 100000 );
        Port ( clk_i      : in  STD_LOGIC;
               rst_i      : in  STD_LOGIC;
               digit_i    : in  STD_LOGIC_VECTOR (31 downto 0);
               led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
               led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
 
    signal digit : STD_LOGIC_VECTOR (31 downto 0);
 
begin
 
    encoder_i : encoder
        port map ( clk_i   => clk_i,
                   btn_i   => btn_i,
                   sw_i    => sw_i,
                   digit_o => digit );
 
    display_i : display
        generic map ( clk_div => 100000 )      -- 100 MHz / 100000 = 1 kHz
        port map ( clk_i      => clk_i,
                   rst_i      => '0',          -- reset nieuzywany w tym ukladzie
                   digit_i    => digit,
                   led7_an_o  => led7_an_o,
                   led7_seg_o => led7_seg_o );


end Behavioral;
