----------------------------------------------------------------------------------
-- Nadajnik RS-232: 8 bitow danych, bez parzystosci, 1 bit stopu (8N1)
--
-- clk_i    - zegar systemowy (100 MHz)
-- data_i   - bajt do wyslania
-- start_i  - '1' przez jeden takt: rozpocznij wysylanie data_i
--            (brane pod uwage tylko, gdy busy_o = '0')
-- busy_o   - '1' w trakcie wysylania ramki
-- txd_o    - wyjscie szeregowe (stan spoczynkowy '1')
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity transmitter is
    Generic ( clk_freq : INTEGER := 100000000;
              baud     : INTEGER := 9600 );
    Port ( clk_i   : in  STD_LOGIC;
           data_i  : in  STD_LOGIC_VECTOR (7 downto 0);
           start_i : in  STD_LOGIC;
           busy_o  : out STD_LOGIC;
           txd_o   : out STD_LOGIC);
end transmitter;

architecture Behavioral of transmitter is

    constant BIT_TIME : integer := (clk_freq + baud / 2) / baud;

    -- ramka: bit stopu & dane & bit startu, wysylana od prawej (bit 0)
    signal shreg  : std_logic_vector (9 downto 0) := (others => '1');
    signal cnt    : integer range 0 to BIT_TIME - 1 := 0;
    signal bit_no : integer range 0 to 9 := 0;
    signal busy   : std_logic := '0';

begin

    txd_o  <= shreg(0);
    busy_o <= busy;

    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if busy = '0' then
                if start_i = '1' then
                    shreg  <= '1' & data_i & '0';   -- stop, D7..D0, start
                    cnt    <= 0;
                    bit_no <= 0;
                    busy   <= '1';
                end if;
            else
                if cnt = BIT_TIME - 1 then
                    cnt   <= 0;
                    shreg <= '1' & shreg(9 downto 1);   -- nastepny bit, z lewej wchodzi '1'
                    if bit_no = 9 then
                        busy <= '0';                    -- wyslano 10 bitow
                    else
                        bit_no <= bit_no + 1;
                    end if;
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

end Behavioral;