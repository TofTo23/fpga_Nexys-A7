----------------------------------------------------------------------------------
-- Generator figur Lissajous (IP Core Generator, wersja 2)
--
-- Generator DDS (IP singen) wytwarza dwie sinusoidy: kanal 1 = X, kanal 2 = Y.
-- Kazda para probek (X, Y) wyznacza punkt, ktory jest zapisywany jako bialy
-- piksel do pamieci obrazu 384 x 384 (IP video_mem). Obraz jest wyswietlany na
-- monitorze VGA 640x480@60Hz (piksel 25 MHz), wycentrowany: kolumny 128..511,
-- wiersze 48..431. Punkt (0,0) jest w srodku kwadratu, X rosnie w prawo,
-- Y rosnie w gore.
--
-- Przelaczniki SW7..SW0 (0..255) i przyciski:
--   BTNL (btn_i(3)) - wpis czestotliwosci X
--   BTNC (btn_i(2)) - wpis czestotliwosci Y
--   BTNR (btn_i(1)) - wpis przesuniecia fazy Y (SW = najstarsze bity fazy)
--   BTND (btn_i(0)) - wyczyszczenie ekranu i reset generatora DDS
-- Bez resetu - stan poczatkowy ustalaja wartosci poczatkowe sygnalow.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port ( clk_i   : in  STD_LOGIC;
           sw_i    : in  STD_LOGIC_VECTOR (7 downto 0);
           btn_i   : in  STD_LOGIC_VECTOR (3 downto 0);
           red_o   : out STD_LOGIC_VECTOR (3 downto 0);
           green_o : out STD_LOGIC_VECTOR (3 downto 0);
           blue_o  : out STD_LOGIC_VECTOR (3 downto 0);
           hsync_o : out STD_LOGIC;
           vsync_o : out STD_LOGIC);
end top;

architecture Behavioral of top is

    -- pamiec obrazu 384 x 384 x 1 bit (Block Memory Generator, Simple Dual Port)
    component video_mem
        port ( clka  : in  std_logic;
               wea   : in  std_logic_vector(0 downto 0);
               addra : in  std_logic_vector(17 downto 0);
               dina  : in  std_logic_vector(0 downto 0);
               clkb  : in  std_logic;
               addrb : in  std_logic_vector(17 downto 0);
               doutb : out std_logic_vector(0 downto 0));
    end component;

    -- generator DDS, 2 kanaly (DDS Compiler)
    component singen
        port ( aclk                            : in  std_logic;
               aclken                          : in  std_logic;
               aresetn                         : in  std_logic;
               s_axis_config_tvalid            : in  std_logic;
               s_axis_config_tdata             : in  std_logic_vector(31 downto 0);
               s_axis_config_tlast             : in  std_logic;
               m_axis_data_tvalid              : out std_logic;
               m_axis_data_tdata               : out std_logic_vector(15 downto 0);
               event_s_config_tlast_missing    : out std_logic;
               event_s_config_tlast_unexpected : out std_logic);
    end component;

    ------------------------------------------------------------------------------
    -- stale
    ------------------------------------------------------------------------------
    constant SIZE  : integer := 384;                -- bok kwadratu z figura
    constant N_PIX : integer := SIZE * SIZE;        -- 147456 pikseli
    constant HALF  : integer := SIZE / 2;           -- 192

    -- VGA 640x480@60Hz, zegar piksela 25 MHz
    constant H_VISIBLE : integer := 640;
    constant H_FRONT   : integer := 16;
    constant H_SYNC    : integer := 96;
    constant H_TOTAL   : integer := 800;
    constant V_VISIBLE : integer := 480;
    constant V_FRONT   : integer := 10;
    constant V_SYNC    : integer := 2;
    constant V_TOTAL   : integer := 525;

    constant X0 : integer := (H_VISIBLE - SIZE) / 2;    -- 128: lewa krawedz kwadratu
    constant Y0 : integer := (V_VISIBLE - SIZE) / 2;    -- 48:  gorna krawedz kwadratu

    -- przeskalowanie probki DDS (-1024..1023) do przesuniecia od srodka
    -- ekranu (-192..191): s * 3 / 16
    function scale (s : signed(10 downto 0)) return integer is
        variable p : signed(12 downto 0);
    begin
        p := resize(s, 13) + shift_left(resize(s, 13), 1);     -- 3 * s
        return to_integer(shift_right(p, 4));                   -- / 16
    end function;

    ------------------------------------------------------------------------------
    -- sygnaly
    ------------------------------------------------------------------------------
    -- przelaczniki i przyciski (synchronizacja z zegarem, wykrywanie wcisniecia)
    signal sw_meta, sw_sync : std_logic_vector (7 downto 0) := (others => '0');
    signal btn_meta, btn_sync, btn_prev : std_logic_vector (3 downto 0) := (others => '0');
    signal btn_press : std_logic_vector (3 downto 0);

    -- nastawy generatora: wartosci poczatkowe = ustawienia IP
    -- (0.1953125 MHz -> PINC = 256; faza Y 0.25 * 2pi -> POFF = 0x4000)
    signal pinc_x : std_logic_vector (15 downto 0) := x"0100";
    signal pinc_y : std_logic_vector (15 downto 0) := x"0100";
    signal poff_y : std_logic_vector (15 downto 0) := x"4000";

    -- interfejs generatora DDS
    signal dds_resetn : std_logic := '1';
    signal cfg_valid  : std_logic := '0';
    signal cfg_last   : std_logic := '0';
    signal cfg_data   : std_logic_vector (31 downto 0) := (others => '0');
    signal dds_valid  : std_logic;
    signal dds_data   : std_logic_vector (15 downto 0);

    -- automat sterujacy
    type ctrl_t is (RUN, CFG_X, CFG_Y, CLEAR);
    signal state     : ctrl_t := RUN;
    signal after_clr : std_logic := '0';                    -- konfiguracja po czyszczeniu
    signal clr_addr  : integer range 0 to N_PIX - 1 := 0;   -- adres czyszczonego piksela

    -- rysowanie
    signal chan     : std_logic := '0';                     -- '0' = probka X, '1' = probka Y
    signal x_smp    : signed (10 downto 0) := (others => '0');
    signal pix_we   : std_logic := '0';
    signal pix_addr : integer range 0 to N_PIX - 1 := 0;

    -- porty pamieci obrazu
    signal mem_we   : std_logic_vector (0 downto 0);
    signal mem_wadr : std_logic_vector (17 downto 0);
    signal mem_din  : std_logic_vector (0 downto 0);
    signal mem_radr : std_logic_vector (17 downto 0);
    signal mem_dout : std_logic_vector (0 downto 0);

    -- VGA
    signal pix_div   : unsigned (1 downto 0) := "00";       -- 100 MHz / 4 = 25 MHz
    signal h_cnt     : integer range 0 to H_TOTAL - 1 := 0;
    signal v_cnt     : integer range 0 to V_TOTAL - 1 := 0;
    signal in_square : std_logic;
    signal pixel     : std_logic := '0';
    signal hsync     : std_logic := '1';
    signal vsync     : std_logic := '1';

begin

    ------------------------------------------------------------------------------
    -- przelaczniki i przyciski
    ------------------------------------------------------------------------------
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            sw_meta  <= sw_i;
            sw_sync  <= sw_meta;
            btn_meta <= btn_i;
            btn_sync <= btn_meta;
            btn_prev <= btn_sync;
        end if;
    end process;

    btn_press <= btn_sync and not btn_prev;     -- '1' przez jeden takt po wcisnieciu

    ------------------------------------------------------------------------------
    -- automat: wpis nastaw, konfiguracja DDS, czyszczenie ekranu
    ------------------------------------------------------------------------------
    process (clk_i)
    begin
        if rising_edge(clk_i) then

            cfg_valid <= '0';
            cfg_last  <= '0';

            case state is

                when RUN =>
                    dds_resetn <= '1';
                    if btn_press(3) = '1' then                  -- BTNL: czestotliwosc X
                        pinc_x <= x"00" & sw_sync;
                        state  <= CFG_X;
                    elsif btn_press(2) = '1' then               -- BTNC: czestotliwosc Y
                        pinc_y <= x"00" & sw_sync;
                        state  <= CFG_X;
                    elsif btn_press(1) = '1' then               -- BTNR: faza Y
                        poff_y <= sw_sync & x"00";
                        state  <= CFG_X;
                    elsif btn_press(0) = '1' then               -- BTND: czyszczenie i reset
                        clr_addr   <= 0;
                        dds_resetn <= '0';
                        state      <= CLEAR;
                    end if;

                -- konfiguracja DDS, transakcja 1: kanal X (faza zawsze 0)
                when CFG_X =>
                    cfg_valid <= '1';
                    cfg_data  <= x"0000" & pinc_x;
                    state     <= CFG_Y;

                -- konfiguracja DDS, transakcja 2 (ostatnia): kanal Y
                when CFG_Y =>
                    cfg_valid <= '1';
                    cfg_last  <= '1';
                    cfg_data  <= poff_y & pinc_y;
                    state     <= RUN;

                -- czyszczenie pamieci obrazu; DDS przez caly czas w resecie
                when CLEAR =>
                    dds_resetn <= '0';
                    if clr_addr = N_PIX - 1 then
                        dds_resetn <= '1';
                        state      <= CFG_X;    -- nastawy jeszcze raz, zaraz po resecie
                    else
                        clr_addr <= clr_addr + 1;
                    end if;

            end case;
        end if;
    end process;

    ------------------------------------------------------------------------------
    -- generator DDS
    ------------------------------------------------------------------------------
    dds : singen
        port map ( aclk                            => clk_i,
                   aclken                          => '1',
                   aresetn                         => dds_resetn,
                   s_axis_config_tvalid            => cfg_valid,
                   s_axis_config_tdata             => cfg_data,
                   s_axis_config_tlast             => cfg_last,
                   m_axis_data_tvalid              => dds_valid,
                   m_axis_data_tdata               => dds_data,
                   event_s_config_tlast_missing    => open,
                   event_s_config_tlast_unexpected => open );

    ------------------------------------------------------------------------------
    -- rysowanie: probki X i Y przychodza na zmiane (najpierw X)
    ------------------------------------------------------------------------------
    process (clk_i)
        variable col, row : integer range 0 to SIZE - 1;
    begin
        if rising_edge(clk_i) then
            pix_we <= '0';
            if dds_resetn = '0' then
                chan <= '0';                                -- po resecie pierwsza jest probka X
            elsif dds_valid = '1' then
                if chan = '0' then
                    x_smp <= signed(dds_data(10 downto 0)); -- zapamietaj X
                    chan  <= '1';
                else
                    -- X: ujemne w lewo; Y: ujemne w dol (wiersz 0 jest na gorze)
                    col := HALF + scale(x_smp);
                    row := HALF - 1 - scale(signed(dds_data(10 downto 0)));
                    pix_addr <= row * SIZE + col;
                    if state = RUN then
                        pix_we <= '1';                      -- bialy piksel
                    end if;
                    chan <= '0';
                end if;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------------------
    -- pamiec obrazu: port A - zapis (rysowanie lub czyszczenie), port B - odczyt (VGA)
    ------------------------------------------------------------------------------
    mem_we(0) <= '1' when state = CLEAR else pix_we;
    mem_din   <= "0" when state = CLEAR else "1";
    mem_wadr  <= std_logic_vector(to_unsigned(clr_addr, 18)) when state = CLEAR
                 else std_logic_vector(to_unsigned(pix_addr, 18));

    vram : video_mem
        port map ( clka  => clk_i,
                   wea   => mem_we,
                   addra => mem_wadr,
                   dina  => mem_din,
                   clkb  => clk_i,
                   addrb => mem_radr,
                   doutb => mem_dout );

    ------------------------------------------------------------------------------
    -- VGA 640x480@60Hz: liczniki piksela i linii (25 MHz = co 4 takty)
    ------------------------------------------------------------------------------
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            pix_div <= pix_div + 1;
            if pix_div = "11" then

                -- wyjscia: stan dla aktualnych licznikow (dane z pamieci sa juz gotowe)
                if h_cnt >= H_VISIBLE + H_FRONT and h_cnt < H_VISIBLE + H_FRONT + H_SYNC then
                    hsync <= '0';
                else
                    hsync <= '1';
                end if;
                if v_cnt >= V_VISIBLE + V_FRONT and v_cnt < V_VISIBLE + V_FRONT + V_SYNC then
                    vsync <= '0';
                else
                    vsync <= '1';
                end if;
                if in_square = '1' then
                    pixel <= mem_dout(0);
                else
                    pixel <= '0';                   -- czarne tlo i zero poza obszarem obrazu
                end if;

                -- nastepny piksel
                if h_cnt = H_TOTAL - 1 then
                    h_cnt <= 0;
                    if v_cnt = V_TOTAL - 1 then
                        v_cnt <= 0;
                    else
                        v_cnt <= v_cnt + 1;
                    end if;
                else
                    h_cnt <= h_cnt + 1;
                end if;

            end if;
        end if;
    end process;

    -- adres odczytu pamieci dla aktualnego piksela VGA
    process (h_cnt, v_cnt)
    begin
        if h_cnt >= X0 and h_cnt < X0 + SIZE and v_cnt >= Y0 and v_cnt < Y0 + SIZE then
            in_square <= '1';
            mem_radr  <= std_logic_vector(to_unsigned((v_cnt - Y0) * SIZE + (h_cnt - X0), 18));
        else
            in_square <= '0';
            mem_radr  <= (others => '0');
        end if;
    end process;

    hsync_o <= hsync;
    vsync_o <= vsync;
    red_o   <= (others => pixel);
    green_o <= (others => pixel);
    blue_o  <= (others => pixel);

end Behavioral;