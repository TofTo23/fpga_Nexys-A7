----------------------------------------------------------------------------------
-- Drukarka pseudograficzna RS-232 (IP Core Generator)
--
-- Odebrane znaki trafiaja do bufora FIFO (64 znaki, IP fifo_mem). Automat
-- pobiera je z FIFO do bufora linii; po 18 znakach lub po kodzie 13 (Enter)
-- drukuje linie z powrotem na TXD_o: 16 wierszy, kazdy znak jako 8 "pikseli"
-- (ksztalty z pamieci ROM, IP char_mem). Pikselem jest sam znak, a dla kodow
-- < 32 i > 127 gwiazdka. Po kazdym wierszu wysylane sa CR (13) i LF (10).
-- Na wyswietlaczu (AN1, AN0) widac ostatni odebrany kod, jak w "Monitorze RS-232".
-- LD0 zapala sie, gdy przyszedl znak, a FIFO bylo pelne (przepelnienie).
-- Bez resetu - stan poczatkowy ustalaja wartosci poczatkowe sygnalow.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port ( clk_i      : in  STD_LOGIC;
           RXD_i      : in  STD_LOGIC;
           TXD_o      : out STD_LOGIC;
           ld0        : out STD_LOGIC;
           led7_an_o  : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

    -- pamiec ROM z ksztaltami znakow (Block Memory Generator)
    component char_mem
        port ( clka  : in  std_logic;
               addra : in  std_logic_vector(11 downto 0);
               douta : out std_logic_vector(7 downto 0));
    end component;

    -- bufor FIFO 64 x 8 bitow (FIFO Generator)
    component fifo_mem
        port ( clk   : in  std_logic;
               din   : in  std_logic_vector(7 downto 0);
               wr_en : in  std_logic;
               rd_en : in  std_logic;
               dout  : out std_logic_vector(7 downto 0);
               full  : out std_logic;
               empty : out std_logic);
    end component;

    constant SEG_OFF : std_logic_vector (7 downto 0) := "11111111";    -- cyfra wygaszona

    -- dekoder: cyfra hex -> segmenty ABCDEFG + DP (aktywne '0')
    function hex2seg (hex : std_logic_vector (3 downto 0)) return std_logic_vector is
    begin
        case hex is
            when "0000" => return "00000011";   -- 0
            when "0001" => return "10011111";   -- 1
            when "0010" => return "00100101";   -- 2
            when "0011" => return "00001101";   -- 3
            when "0100" => return "10011001";   -- 4
            when "0101" => return "01001001";   -- 5
            when "0110" => return "01000001";   -- 6
            when "0111" => return "00011111";   -- 7
            when "1000" => return "00000001";   -- 8
            when "1001" => return "00001001";   -- 9
            when "1010" => return "00010001";   -- A
            when "1011" => return "11000001";   -- b
            when "1100" => return "01100011";   -- C
            when "1101" => return "10000101";   -- d
            when "1110" => return "01100001";   -- E
            when others => return "01110001";   -- F
        end case;
    end function;

    constant LINE_LEN : integer := 18;          -- maksymalna liczba znakow w linii
    constant CR       : std_logic_vector (7 downto 0) := x"0D";
    constant LF       : std_logic_vector (7 downto 0) := x"0A";
    constant SPACE    : std_logic_vector (7 downto 0) := x"20";
    constant STAR     : std_logic_vector (7 downto 0) := x"2A";

    -- odbiornik i wyswietlacz
    signal rx_data  : std_logic_vector (7 downto 0);
    signal rx_valid : std_logic;
    signal digits   : std_logic_vector (31 downto 0);

    -- FIFO
    signal fifo_dout  : std_logic_vector (7 downto 0);
    signal fifo_rd    : std_logic;
    signal fifo_full  : std_logic;
    signal fifo_empty : std_logic;
    signal overflow   : std_logic := '0';

    -- ROM
    signal rom_addr : std_logic_vector (11 downto 0);
    signal rom_dout : std_logic_vector (7 downto 0);

    -- nadajnik
    signal tx_data  : std_logic_vector (7 downto 0) := (others => '0');
    signal tx_start : std_logic := '0';
    signal tx_busy  : std_logic;

    -- bufor linii
    type line_t is array (0 to LINE_LEN - 1) of std_logic_vector (7 downto 0);
    signal line_buf : line_t := (others => (others => '0'));
    signal n_chars  : integer range 0 to LINE_LEN := 0;     -- liczba znakow w linii

    -- automat drukujacy
    type ctrl_t is (COLLECT, FIFO_DATA, ROM_WAIT, ROM_DATA, SEND_PIX, SEND_CR, SEND_LF);
    signal state  : ctrl_t := COLLECT;
    signal col    : integer range 0 to LINE_LEN - 1 := 0;   -- numer znaku w linii
    signal row    : integer range 0 to 15 := 0;             -- numer wiersza znaku
    signal pix_no : integer range 0 to 7 := 0;              -- numer piksela w wierszu
    signal pixels : std_logic_vector (7 downto 0) := (others => '0');
    signal pix_char : std_logic_vector (7 downto 0);        -- znak uzywany jako piksel

begin

    ------------------------------------------------------------------------------
    -- odbiornik RS-232 i wyswietlacz (monitor odebranych znakow)
    ------------------------------------------------------------------------------
    rx : entity work.receiver
        generic map ( clk_freq => 100000000,
                      baud     => 9600 )
        port map ( clk_i   => clk_i,
                   rxd_i   => RXD_i,
                   data_o  => rx_data,
                   valid_o => rx_valid );

    -- AN3, AN2 wygaszone; AN1 = starsza cyfra hex, AN0 = mlodsza
    digits <= SEG_OFF & SEG_OFF & hex2seg(rx_data(7 downto 4)) & hex2seg(rx_data(3 downto 0));

    disp : entity work.display
        generic map ( clk_div => 100000 )
        port map ( clk_i      => clk_i,
                   digit_i    => digits,
                   led7_an_o  => led7_an_o,
                   led7_seg_o => led7_seg_o );

    ------------------------------------------------------------------------------
    -- bufor FIFO: kazdy odebrany znak jest zapisywany
    ------------------------------------------------------------------------------
    fifo : fifo_mem
        port map ( clk   => clk_i,
                   din   => rx_data,
                   wr_en => rx_valid,
                   rd_en => fifo_rd,
                   dout  => fifo_dout,
                   full  => fifo_full,
                   empty => fifo_empty );

    -- przepelnienie: przyszedl znak, a FIFO bylo pelne -> LD0 swieci na stale
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if rx_valid = '1' and fifo_full = '1' then
                overflow <= '1';
            end if;
        end if;
    end process;

    ld0 <= overflow;

    ------------------------------------------------------------------------------
    -- pamiec ROM: adres = kod znaku & numer wiersza (0-15)
    ------------------------------------------------------------------------------
    rom : char_mem
        port map ( clka  => clk_i,
                   addra => rom_addr,
                   douta => rom_dout );

    rom_addr <= line_buf(col) & std_logic_vector(to_unsigned(row, 4));

    -- piksel: sam znak, a dla kodow < 32 i > 127 gwiazdka
    pix_char <= STAR when unsigned(line_buf(col)) < 32 or unsigned(line_buf(col)) > 127
                else line_buf(col);

    ------------------------------------------------------------------------------
    -- nadajnik RS-232
    ------------------------------------------------------------------------------
    tx : entity work.transmitter
        generic map ( clk_freq => 100000000,
                      baud     => 9600 )
        port map ( clk_i   => clk_i,
                   data_i  => tx_data,
                   start_i => tx_start,
                   busy_o  => tx_busy,
                   txd_o   => TXD_o );

    ------------------------------------------------------------------------------
    -- automat: zbieranie linii z FIFO i drukowanie
    ------------------------------------------------------------------------------

    -- odczyt z FIFO: jeden takt w stanie COLLECT, gdy FIFO nie jest puste
    fifo_rd <= '1' when state = COLLECT and fifo_empty = '0' else '0';

    process (clk_i)
    begin
        if rising_edge(clk_i) then

            tx_start <= '0';

            case state is

                -- czekanie na znak w FIFO (odczyt: fifo_rd)
                when COLLECT =>
                    if fifo_empty = '0' then
                        state <= FIFO_DATA;
                    end if;

                -- znak z FIFO jest juz na fifo_dout (opoznienie odczytu 1 takt)
                when FIFO_DATA =>
                    col <= 0;
                    row <= 0;
                    if fifo_dout = CR then
                        if n_chars > 0 then
                            state <= ROM_WAIT;          -- Enter: drukuj linie
                        else
                            state <= COLLECT;           -- pusta linia: nic do druku
                        end if;
                    else
                        line_buf(n_chars) <= fifo_dout;
                        n_chars <= n_chars + 1;
                        if n_chars = LINE_LEN - 1 then
                            state <= ROM_WAIT;          -- 18 znakow: drukuj linie
                        else
                            state <= COLLECT;
                        end if;
                    end if;

                -- ROM zapamietuje adres (opoznienie odczytu 1 takt)
                when ROM_WAIT =>
                    state <= ROM_DATA;

                -- wiersz ksztaltu znaku jest juz na rom_dout
                when ROM_DATA =>
                    pixels <= rom_dout;
                    pix_no <= 0;
                    state  <= SEND_PIX;

                -- wyslanie 8 pikseli wiersza, od lewego (bit 7)
                when SEND_PIX =>
                    if tx_busy = '0' and tx_start = '0' then
                        if pixels(7) = '1' then
                            tx_data <= pix_char;
                        else
                            tx_data <= SPACE;
                        end if;
                        tx_start <= '1';
                        pixels   <= pixels(6 downto 0) & '0';
                        if pix_no = 7 then
                            if col = n_chars - 1 then
                                state <= SEND_CR;       -- koniec wiersza
                            else
                                col   <= col + 1;       -- nastepny znak
                                state <= ROM_WAIT;
                            end if;
                        else
                            pix_no <= pix_no + 1;
                        end if;
                    end if;

                -- koniec wiersza: CR
                when SEND_CR =>
                    if tx_busy = '0' and tx_start = '0' then
                        tx_data  <= CR;
                        tx_start <= '1';
                        state    <= SEND_LF;
                    end if;

                -- koniec wiersza: LF, potem nastepny wiersz albo koniec linii
                when SEND_LF =>
                    if tx_busy = '0' and tx_start = '0' then
                        tx_data  <= LF;
                        tx_start <= '1';
                        col      <= 0;
                        if row = 15 then
                            n_chars <= 0;               -- linia wydrukowana
                            state   <= COLLECT;
                        else
                            row   <= row + 1;
                            state <= ROM_WAIT;
                        end if;
                    end if;

            end case;
        end if;
    end process;

end Behavioral;