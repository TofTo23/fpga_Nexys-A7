library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity receiver is
    Generic ( clk_freq : INTEGER := 100000000;
              baud     : INTEGER := 9600 );
    Port ( clk_i   : in  STD_LOGIC;
           rxd_i   : in  STD_LOGIC;
           data_o  : out STD_LOGIC_VECTOR (7 downto 0);
           valid_o : out STD_LOGIC);
end receiver;

architecture Behavioral of receiver is

    -- liczba taktow zegara na jeden bit: 100 MHz / 9600 = 10417
    constant BIT_TIME  : integer := (clk_freq + baud / 2) / baud;
    constant HALF_TIME : integer := BIT_TIME / 2;

    type state_t is (IDLE, START, DATA, STOP);
    signal state : state_t := IDLE;

    signal rxd_meta : std_logic := '1';     -- 1. przerzutnik 
    signal rxd_sync : std_logic := '1';     -- 2. przerzutnik 

    signal cnt    : integer range 0 to BIT_TIME - 1 := 0;   -- licznik czasu bitu
    signal bit_no : integer range 0 to 7 := 0;              -- numer odbieranego bitu
    signal shreg  : std_logic_vector (7 downto 0) := (others => '0');
    signal byte_r : std_logic_vector (7 downto 0) := (others => '0');
    signal valid  : std_logic := '0';

begin

    data_o  <= byte_r;
    valid_o <= valid;

    process (clk_i)
    begin
        if rising_edge(clk_i) then

            -- synchronizacja asynchronicznego wejscia rxd_i z zegarem clk_i
            rxd_meta <= rxd_i;
            rxd_sync <= rxd_meta;

            valid <= '0';

            case state is
                -- oczekiwanie na poczatek bitu startu
                when IDLE =>
                    cnt    <= 0;
                    bit_no <= 0;
                    if rxd_sync = '0' then
                        state <= START;
                    end if;

                -- pol bitu pozniej: sprawdzenie, czy to faktycznie bit startu
                when START =>
                    if cnt = HALF_TIME - 1 then
                        cnt <= 0;
                        if rxd_sync = '0' then
                            state <= DATA;
                        else
                            state <= IDLE;
                        end if;
                    else
                        cnt <= cnt + 1;
                    end if;

                -- probkowanie bitow danych w srodku kazdego bitu, D0 jako pierwszy
                when DATA =>
                    if cnt = BIT_TIME - 1 then
                        cnt   <= 0;
                        shreg <= rxd_sync & shreg(7 downto 1);
                        if bit_no = 7 then
                            state <= STOP;
                        else
                            bit_no <= bit_no + 1;
                        end if;
                    else
                        cnt <= cnt + 1;
                    end if;

                -- srodek bitu stopu
                when STOP =>
                    if cnt = BIT_TIME - 1 then
                        if rxd_sync = '1' then
                            byte_r <= shreg;
                            valid <= '1';
                        end if;
                        state <= IDLE;
                    else
                        cnt <= cnt + 1;
                    end if;
            end case;

        end if;
    end process;

end Behavioral;