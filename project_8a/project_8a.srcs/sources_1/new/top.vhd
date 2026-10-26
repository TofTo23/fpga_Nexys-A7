----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2026 21:20:27
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
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port ( clk_i   : in STD_LOGIC;
           sw_i    : in STD_LOGIC_VECTOR (7 downto 0);
           btn_i   : in STD_LOGIC_VECTOR (3 downto 0);
           red_o   : out STD_LOGIC_VECTOR (3 downto 0);
           green_o : out STD_LOGIC_VECTOR (3 downto 0);
           blue_o  : out STD_LOGIC_VECTOR (3 downto 0);
           hsync_o : out STD_LOGIC;
           vsync_o : out STD_LOGIC);
end top;

architecture rtl of top is
    constant H_ACTIVE : integer := 640;
    constant H_FRONT  : integer := 16;
    constant H_SYNC   : integer := 96;
    constant H_BACK   : integer := 48;
    constant H_TOTAL  : integer := H_ACTIVE + H_FRONT + H_SYNC + H_BACK; -- 800

    constant V_ACTIVE : integer := 480;
    constant V_FRONT  : integer := 10;
    constant V_SYNC   : integer := 2;
    constant V_BACK   : integer := 33;
    constant V_TOTAL  : integer := V_ACTIVE + V_FRONT + V_SYNC + V_BACK; -- 525

    constant FB_W     : integer := 384;
    constant FB_H     : integer := 384;
    constant FB_SIZE  : integer := FB_W * FB_H; -- 147456 bits
    constant X0       : integer := 128; -- (640-384)/2
    constant Y0       : integer := 48;  -- (480-384)/2

    COMPONENT video_mem
      PORT (
        clka  : IN STD_LOGIC;
        wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        dina  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        clkb  : IN STD_LOGIC;
        addrb : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
      );
    END COMPONENT;

    COMPONENT singen
      PORT (
        aclk                            : IN STD_LOGIC;
        aclken                          : IN STD_LOGIC;
        aresetn                         : IN STD_LOGIC;
        s_axis_config_tvalid            : IN STD_LOGIC;
        s_axis_config_tdata             : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axis_config_tlast             : IN STD_LOGIC;
        m_axis_data_tvalid              : OUT STD_LOGIC;
        m_axis_data_tdata               : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axis_phase_tvalid             : OUT STD_LOGIC;
        m_axis_phase_tdata              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        event_s_config_tlast_missing    : OUT STD_LOGIC;
        event_s_config_tlast_unexpected : OUT STD_LOGIC
      );
    END COMPONENT;

    signal pix_div   : integer range 0 to 3 := 0;
    signal h_count   : integer range 0 to H_TOTAL-1 := 0;
    signal v_count   : integer range 0 to V_TOTAL-1 := 0;

    signal hsync_int : std_logic;
    signal vsync_int : std_logic;
    signal hsync_d   : std_logic := '1';
    signal vsync_d   : std_logic := '1';
    signal video_d   : std_logic := '0';
    signal square_d  : std_logic := '0';

    signal mem_wea   : std_logic_vector(0 downto 0);
    signal mem_addra : std_logic_vector(17 downto 0);
    signal mem_dina  : std_logic_vector(0 downto 0);
    signal mem_addrb : std_logic_vector(17 downto 0) := (others => '0');
    signal mem_doutb : std_logic_vector(0 downto 0);

    signal clear_busy  : std_logic := '1';
    signal clear_index : integer range 0 to FB_SIZE-1 := 0;

    signal draw_we_reg   : std_logic := '0';
    signal draw_addr_reg : unsigned(17 downto 0) := (others => '0');
    signal amp_a_reg     : signed(9 downto 0) := to_signed(64, 10);
    signal amp_b_reg     : signed(7 downto 0) := to_signed(20, 8);

    signal p1_valid : std_logic := '0';
    signal prod_x0  : signed(20 downto 0) := (others => '0');
    signal prod_x1  : signed(18 downto 0) := (others => '0');
    signal prod_y0  : signed(20 downto 0) := (others => '0');
    signal prod_y1  : signed(18 downto 0) := (others => '0');

    signal p2_valid : std_logic := '0';
    signal x_pix_s2 : signed(11 downto 0) := (others => '0');
    signal y_pix_s2 : signed(11 downto 0) := (others => '0');

    signal f1_reg : unsigned(7 downto 0) := to_unsigned(1, 8);
    signal f2_reg : unsigned(7 downto 0) := to_unsigned(1, 8);

    -- Button synchronizer
    signal btn_meta : std_logic_vector(3 downto 0) := (others => '0');
    signal btn_sync : std_logic_vector(3 downto 0) := (others => '0');
    signal btn_prev : std_logic_vector(3 downto 0) := (others => '0');

    -- DDS config state machine
    signal cfg_req_toggle  : std_logic := '1';
    signal cfg_seen_toggle : std_logic := '0';
    type cfg_state_t is (cfg_idle, cfg_channel_0, cfg_channel_1);
    signal cfg_state  : cfg_state_t := cfg_idle;
    signal cfg_tvalid : std_logic;
    signal cfg_tlast  : std_logic;
    signal cfg_tdata  : std_logic_vector(15 downto 0);

    signal dds_aresetn : std_logic;
    signal dds_aclken  : std_logic;
    signal dds_valid   : std_logic;
    signal dds_data    : std_logic_vector(31 downto 0);

    signal have_channel_0 : std_logic := '0';
    signal cos0_hold : std_logic_vector(10 downto 0) := (others => '0');
    signal sin0_hold : std_logic_vector(10 downto 0) := (others => '0');
begin

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if pix_div = 3 then
                pix_div <= 0;
                if h_count = H_TOTAL-1 then
                    h_count <= 0;
                    if v_count = V_TOTAL-1 then
                        v_count <= 0;
                    else
                        v_count <= v_count + 1;
                    end if;
                else
                    h_count <= h_count + 1;
                end if;
            else
                pix_div <= pix_div + 1;
            end if;
        end if;
    end process;

    hsync_int <= '0' when (h_count >= H_ACTIVE + H_FRONT and
                           h_count <  H_ACTIVE + H_FRONT + H_SYNC) else '1';
    vsync_int <= '0' when (v_count >= V_ACTIVE + V_FRONT and
                           v_count <  V_ACTIVE + V_FRONT + V_SYNC) else '1';

    process(clk_i)
        variable x_local : unsigned(17 downto 0);
        variable y_local : unsigned(17 downto 0);
    begin
        if rising_edge(clk_i) then
            hsync_d <= hsync_int;
            vsync_d <= vsync_int;

            if h_count < H_ACTIVE and v_count < V_ACTIVE then
                video_d <= '1';
            else
                video_d <= '0';
            end if;

            if h_count >= X0 and h_count < X0 + FB_W and
               v_count >= Y0 and v_count < Y0 + FB_H then
                square_d <= '1';
                x_local := to_unsigned(h_count - X0, 18);
                y_local := to_unsigned(v_count - Y0, 18);
                -- Fast multiplication by 384: (y * 256) + (y * 128) + x
                mem_addrb <= std_logic_vector(shift_left(y_local, 8) + shift_left(y_local, 7) + x_local);
            else
                square_d <= '0';
                mem_addrb <= (others => '0');
            end if;
        end if;
    end process;

    hsync_o <= hsync_d;
    vsync_o <= vsync_d;

    mem_wea(0) <= '1' when clear_busy = '1' else draw_we_reg;
    mem_addra  <= std_logic_vector(to_unsigned(clear_index, mem_addra'length))
                  when clear_busy = '1' else
                  std_logic_vector(draw_addr_reg);
    mem_dina(0) <= '0' when clear_busy = '1' else '1';

    u_video_mem : video_mem
        port map (
            clka  => clk_i,
            wea   => mem_wea,
            addra => mem_addra,
            dina  => mem_dina,
            clkb  => clk_i,
            addrb => mem_addrb,
            doutb => mem_doutb
        );

    dds_aresetn <= not clear_busy;
    dds_aclken  <= '1';

    cfg_tvalid <= '1' when clear_busy = '0' and
                           (cfg_state = cfg_channel_0 or cfg_state = cfg_channel_1)
                  else '0';
    cfg_tdata <= std_logic_vector(resize(f1_reg, cfg_tdata'length))
                 when cfg_state = cfg_channel_0 else
                 std_logic_vector(resize(f2_reg, cfg_tdata'length));
    cfg_tlast <= '1' when cfg_state = cfg_channel_1 else '0';

    u_singen : singen
        port map (
            aclk                            => clk_i,
            aclken                          => dds_aclken,
            aresetn                         => dds_aresetn,
            s_axis_config_tvalid            => cfg_tvalid,
            s_axis_config_tdata             => cfg_tdata,
            s_axis_config_tlast             => cfg_tlast,
            m_axis_data_tvalid              => dds_valid,
            m_axis_data_tdata               => dds_data,
            m_axis_phase_tvalid             => open,
            m_axis_phase_tdata              => open,
            event_s_config_tlast_missing    => open,
            event_s_config_tlast_unexpected => open
        );

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if clear_busy = '1' then
                cfg_state <= cfg_idle;
            else
                case cfg_state is
                    when cfg_idle =>
                        if cfg_req_toggle /= cfg_seen_toggle then
                            cfg_seen_toggle <= cfg_req_toggle;
                            cfg_state <= cfg_channel_0;
                        end if;
                    when cfg_channel_0 =>
                        cfg_state <= cfg_channel_1;
                    when cfg_channel_1 =>
                        cfg_state <= cfg_idle;
                end case;
            end if;
        end if;
    end process;

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            btn_meta <= btn_i;
            btn_sync <= btn_meta;
            btn_prev <= btn_sync;

            if clear_busy = '1' then
                if clear_index = FB_SIZE-1 then
                    clear_index <= 0;
                    clear_busy <= '0';
                else
                    clear_index <= clear_index + 1;
                end if;
            else
                if btn_sync(0) = '1' and btn_prev(0) = '0' then
                    clear_busy <= '1';
                    clear_index <= 0;
                    cfg_req_toggle <= not cfg_req_toggle;
                elsif btn_sync(3) = '1' and btn_prev(3) = '0' then
                    f1_reg <= unsigned(sw_i);
                    cfg_req_toggle <= not cfg_req_toggle;
                elsif btn_sync(2) = '1' and btn_prev(2) = '0' then
                    f2_reg <= unsigned(sw_i);
                    cfg_req_toggle <= not cfg_req_toggle;
                elsif btn_sync(1) = '1' and btn_prev(1) = '0' then
                    amp_a_reg <= signed(resize(unsigned(sw_i(7 downto 4)), 10) sll 4);
                    amp_b_reg <= signed(resize(unsigned(sw_i(3 downto 0)), 8) sll 2);
                end if;
            end if;
        end if;
    end process;

    process(clk_i)
        variable diff_x : signed(20 downto 0);
        variable diff_y : signed(20 downto 0);
        variable x_u    : unsigned(17 downto 0);
        variable y_u    : unsigned(17 downto 0);
    begin
        if rising_edge(clk_i) then
            if clear_busy = '1' then
                have_channel_0 <= '0';
                cos0_hold      <= (others => '0');
                sin0_hold      <= (others => '0');
                p1_valid       <= '0';
                p2_valid       <= '0';
                draw_we_reg    <= '0';
            else
                p1_valid <= '0';
                if dds_valid = '1' then
                    if have_channel_0 = '0' then
                        cos0_hold      <= dds_data(10 downto 0);
                        sin0_hold      <= dds_data(26 downto 16);
                        have_channel_0 <= '1';
                    else
                        have_channel_0 <= '0';
                        prod_x0  <= signed(cos0_hold) * amp_a_reg;
                        prod_x1  <= signed(dds_data(10 downto 0)) * amp_b_reg;
                        prod_y0  <= signed(sin0_hold) * amp_a_reg;
                        prod_y1  <= signed(dds_data(26 downto 16)) * amp_b_reg;
                        p1_valid <= '1';
                    end if;
                end if;

                p2_valid <= p1_valid;
                if p1_valid = '1' then
                    diff_x   := prod_x0 - resize(prod_x1, 21);
                    diff_y   := prod_y0 - resize(prod_y1, 21);
                    x_pix_s2 <= to_signed(192, 12) + resize(shift_right(diff_x, 10), 12);
                    y_pix_s2 <= to_signed(192, 12) - resize(shift_right(diff_y, 10), 12);
                end if;

                draw_we_reg <= '0';
                if p2_valid = '1' then
                    if x_pix_s2 >= 0 and x_pix_s2 < FB_W and
                       y_pix_s2 >= 0 and y_pix_s2 < FB_H then
                        x_u := resize(unsigned(x_pix_s2), 18);
                        y_u := resize(unsigned(y_pix_s2), 18);
                        draw_addr_reg <= shift_left(y_u, 8) + shift_left(y_u, 7) + x_u;
                        draw_we_reg   <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Monochrome output
    process(video_d, square_d, mem_doutb)
    begin
        if video_d = '1' and square_d = '1' and mem_doutb(0) = '1' then
            red_o   <= (others => '1');
            green_o <= (others => '1');
            blue_o  <= (others => '1');
        else
            red_o   <= (others => '0');
            green_o <= (others => '0');
            blue_o  <= (others => '0');
        end if;
    end process;
end architecture;