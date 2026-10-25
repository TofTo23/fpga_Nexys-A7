-- Top-level projektu PicoBlaze dla Digilent Basys 3 (Artix-7, zegar 100 MHz).
-- Wymagane pliki z dystrybucji KCPSM6: kcpsm6.vhd oraz ROM wygenerowany z PSM.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port (
        clk_i      : in  std_logic;
        rst_i      : in  std_logic; -- SW7, aktywny '1'
        button_i   : in  std_logic_vector(3 downto 0);
        led7_an_o  : out std_logic_vector(3 downto 0);
        led7_seg_o : out std_logic_vector(7 downto 0)
    );
end top;

architecture rtl of top is
    component kcpsm6 is
        generic (
            hwbuild                    : std_logic_vector(7 downto 0) := x"00";
            interrupt_vector           : std_logic_vector(11 downto 0) := x"3FF";
            scratch_pad_memory_size    : integer := 64
        );
        port (
            address        : out std_logic_vector(11 downto 0);
            instruction    : in  std_logic_vector(17 downto 0);
            bram_enable    : out std_logic;
            in_port        : in  std_logic_vector(7 downto 0);
            out_port       : out std_logic_vector(7 downto 0);
            port_id        : out std_logic_vector(7 downto 0);
            write_strobe   : out std_logic;
            k_write_strobe : out std_logic;
            read_strobe    : out std_logic;
            interrupt      : in  std_logic;
            interrupt_ack  : out std_logic;
            sleep          : in  std_logic;
            reset          : in  std_logic;
            clk            : in  std_logic
        );
    end component;

    signal rst_meta, rst_sync : std_logic := '0';
    signal cpu_reset, rom_rdl : std_logic;

    signal address        : std_logic_vector(11 downto 0);
    signal instruction    : std_logic_vector(17 downto 0);
    signal bram_enable    : std_logic;
    signal in_port        : std_logic_vector(7 downto 0);
    signal out_port       : std_logic_vector(7 downto 0);
    signal port_id        : std_logic_vector(7 downto 0);
    signal write_strobe   : std_logic;
    signal k_write_strobe : std_logic;
    signal read_strobe    : std_logic;
    signal interrupt_ack  : std_logic;
    signal cpu_sleep      : std_logic := '0';

    signal button_events : std_logic_vector(4 downto 0);
    signal clear_mask    : std_logic_vector(4 downto 0);

    signal digit0_reg : std_logic_vector(3 downto 0) := (others => '0');
    signal digit1_reg : std_logic_vector(3 downto 0) := (others => '0');
    signal digit2_reg : std_logic_vector(3 downto 0) := (others => '0');
    signal digit3_reg : std_logic_vector(3 downto 0) := (others => '0');
    signal selected_reg : std_logic_vector(1 downto 0) := "00";
    signal edit_reg     : std_logic := '0';
    signal digit_bus    : std_logic_vector(15 downto 0);
begin
    -- Resetzsynchronizator: reset wejscia KCPSM6 pozostaje synchroniczny.
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            rst_meta <= rst_i;
            rst_sync <= rst_meta;
        end if;
    end process;
    cpu_reset <= rst_sync or rom_rdl;

    processor : kcpsm6
        generic map (
            hwbuild                 => x"00",
            interrupt_vector        => x"3FF",
            scratch_pad_memory_size => 64
        )
        port map (
            address        => address,
            instruction    => instruction,
            bram_enable    => bram_enable,
            in_port        => in_port,
            out_port       => out_port,
            port_id        => port_id,
            write_strobe   => write_strobe,
            k_write_strobe => k_write_strobe,
            read_strobe    => read_strobe,
            interrupt      => interrupt_ack,
            interrupt_ack  => interrupt_ack,
            sleep          => cpu_sleep,
            reset          => cpu_reset,
            clk            => clk_i
        );

    -- ROM generowana przez assembler KCPSM6 z pliku counter_editor.psm.
    program_rom : entity work.counter_editor
        generic map (
            C_FAMILY             => "7S",
            C_RAM_SIZE_KWORDS    => 1,
            C_JTAG_LOADER_ENABLE => 0
        )
        port map (
            address     => address,
            instruction => instruction,
            enable      => bram_enable,
            rdl         => rom_rdl,
            clk         => clk_i
        );

    -- Odczyt portu 00: zatrzasniete zdarzenia przyciskow.
    process (port_id, button_events)
    begin
        in_port <= x"00";
        case port_id is
            when x"00" => in_port <= "000" & button_events;
            when others => null;
        end case;
    end process;

    -- Zapis maski odczytanych zdarzen do portu 20 potwierdza je w button_if.
    clear_mask <= out_port(4 downto 0)
                  when (write_strobe = '1' and port_id = x"20")
                  else (others => '0');

    buttons : entity work.button_if
        generic map (
            CLK_HZ        => 100_000_000,
            DEBOUNCE_MS   => 1, -- USTAW NA 10!!!!!!!!!
            LONG_PRESS_MS => 10 -- USTAW NA 500
        )
        port map (
            clk_i        => clk_i,
            rst_i        => rst_sync,
            button_i     => button_i,
            clear_mask_i => clear_mask,
            events_o     => button_events
        );

    -- Rejestry wyjsciowe mapowane na porty 10..14 PicoBlaze.
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if cpu_reset = '1' then
                digit0_reg <= (others => '0');
                digit1_reg <= (others => '0');
                digit2_reg <= (others => '0');
                digit3_reg <= (others => '0');
                selected_reg <= "00";
                edit_reg <= '0';
            elsif write_strobe = '1' then
                case port_id is
                    when x"10" => digit0_reg <= out_port(3 downto 0);
                    when x"11" => digit1_reg <= out_port(3 downto 0);
                    when x"12" => digit2_reg <= out_port(3 downto 0);
                    when x"13" => digit3_reg <= out_port(3 downto 0);
                    when x"14" =>
                        selected_reg <= out_port(1 downto 0);
                        edit_reg     <= out_port(2);
                    when others => null;
                end case;
            end if;
        end if;
    end process;

    digit_bus <= digit3_reg & digit2_reg & digit1_reg & digit0_reg;

    seven_segment_display : entity work.display
        generic map (
            clk_div   => 100, -- 100_000
            blink_div => 25_000_000
        )
        port map (
            clk_i      => clk_i,
            rst_i      => rst_sync,
            digit_i    => digit_bus,
            selected_i => selected_reg,
            edit_i     => edit_reg,
            led7_an_o  => led7_an_o,
            led7_seg_o => led7_seg_o
        );
end rtl;