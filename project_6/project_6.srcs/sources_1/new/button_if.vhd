-- Synchronizacja, filtracja drgan stykow i rejestr zdarzen przyciskow.
-- button_i(3)=BTNL, (2)=BTNR, (1)=BTNU, (0)=BTND; przyciski aktywne '1'.
-- events_o(0)=krotkie BTNL, (1)=BTNR, (2)=BTNU, (3)=BTND,
-- events_o(4)=dlugie BTNL (500 ms). Zdarzenia pozostaja ustawione do potwierdzenia.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity button_if is
    generic (
        CLK_HZ        : positive := 100_000_000;
        DEBOUNCE_MS   : positive := 10;
        LONG_PRESS_MS : positive := 500
    );
    port (
        clk_i        : in  std_logic;
        rst_i        : in  std_logic;
        button_i     : in  std_logic_vector(3 downto 0);
        clear_mask_i : in  std_logic_vector(4 downto 0);
        events_o     : out std_logic_vector(4 downto 0)
    );
end button_if;

architecture rtl of button_if is

    constant SAMPLE_DIV : positive := CLK_HZ / 1000;

    type debounce_array_t is
        array (3 downto 0) of integer range 0 to DEBOUNCE_MS-1;

    signal db_count : debounce_array_t := (others => 0);

    signal sync_meta  : std_logic_vector(3 downto 0) := (others => '0');
    signal sync_input : std_logic_vector(3 downto 0) := (others => '0');
    signal buttons_db : std_logic_vector(3 downto 0) := (others => '0');
    signal buttons_q  : std_logic_vector(3 downto 0) := (others => '0');

    signal sample_count : integer range 0 to SAMPLE_DIV-1 := 0;
    signal sample_tick  : std_logic := '0';

    signal events : std_logic_vector(4 downto 0) := (others => '0');

    signal left_hold_ms : integer range 0 to LONG_PRESS_MS-1 := 0;
    signal left_long_sent : std_logic := '0';

begin

    events_o <= events;

    -- Synchronizator dwustopniowy
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                sync_meta  <= (others => '0');
                sync_input <= (others => '0');
            else
                sync_meta  <= button_i;
                sync_input <= sync_meta;
            end if;
        end if;
    end process;

    -- Impuls co 1 ms
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                sample_count <= 0;
                sample_tick  <= '0';
            elsif sample_count = SAMPLE_DIV-1 then
                sample_count <= 0;
                sample_tick  <= '1';
            else
                sample_count <= sample_count + 1;
                sample_tick  <= '0';
            end if;
        end if;
    end process;

    -- Filtracja drga? styków
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                buttons_db <= (others => '0');
                db_count   <= (others => 0);
            elsif sample_tick = '1' then
                for i in 0 to 3 loop
                    if sync_input(i) = buttons_db(i) then
                        db_count(i) <= 0;
                    elsif db_count(i) = DEBOUNCE_MS-1 then
                        buttons_db(i) <= sync_input(i);
                        db_count(i)   <= 0;
                    else
                        db_count(i) <= db_count(i) + 1;
                    end if;
                end loop;
            end if;
        end if;
    end process;

    -- Rejestr zdarze? przycisków
    process(clk_i)
        variable ev : std_logic_vector(4 downto 0);
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                events         <= (others => '0');
                buttons_q      <= (others => '0');
                left_hold_ms   <= 0;
                left_long_sent <= '0';
            else
                ev := events and not clear_mask_i;

                -- BTNL: d?ugie naci?ni?cie i krótkie klikni?cie
                if buttons_db(3) = '1' then

                    if buttons_q(3) = '0' then
                        left_hold_ms   <= 0;
                        left_long_sent <= '0';

                    elsif sample_tick = '1' and left_long_sent = '0' then
                        if left_hold_ms = LONG_PRESS_MS-1 then
                            ev(4) := '1';
                            left_long_sent <= '1';
                        else
                            left_hold_ms <= left_hold_ms + 1;
                        end if;
                    end if;

                else
                    if buttons_q(3) = '1' then
                        if left_long_sent = '0' then
                            ev(0) := '1';
                        end if;
                    end if;

                    left_hold_ms   <= 0;
                    left_long_sent <= '0';
                end if;

                -- BTNR, BTNU, BTND: zdarzenie przy naci?ni?ciu
                for i in 0 to 2 loop
                    if buttons_db(i) = '1' and buttons_q(i) = '0' then
                        ev(3-i) := '1';
                    end if;
                end loop;

                events    <= ev;
                buttons_q <= buttons_db;
            end if;
        end if;
    end process;

end rtl;