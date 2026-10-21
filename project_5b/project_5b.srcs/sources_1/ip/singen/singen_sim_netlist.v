// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Wed Oct 21 14:04:29 2026
// Host        : mx running 64-bit Debian GNU/Linux 12 (bookworm)
// Command     : write_verilog -force -mode funcsim
//               /home/lucek/0_lucek/puc/fpga_Nexys-A7/project_5b/project_5b.srcs/sources_1/ip/singen/singen_sim_netlist.v
// Design      : singen
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "singen,dds_compiler_v6_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dds_compiler_v6_0_18,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module singen
   (aclk,
    aclken,
    aresetn,
    s_axis_config_tvalid,
    s_axis_config_tdata,
    s_axis_config_tlast,
    m_axis_data_tvalid,
    m_axis_data_tdata,
    event_s_config_tlast_missing,
    event_s_config_tlast_unexpected);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF M_AXIS_PHASE:S_AXIS_CONFIG:M_AXIS_DATA:S_AXIS_PHASE, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input aclk;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 aclken_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME aclken_intf, POLARITY ACTIVE_LOW" *) input aclken;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 aresetn_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME aresetn_intf, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input aresetn;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXIS_CONFIG, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_config_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TDATA" *) input [31:0]s_axis_config_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TLAST" *) input s_axis_config_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_DATA, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_data_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TDATA" *) output [15:0]m_axis_data_tdata;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_s_config_tlast_missing_intf INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME event_s_config_tlast_missing_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_s_config_tlast_missing;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_s_config_tlast_unexpected_intf INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME event_s_config_tlast_unexpected_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_s_config_tlast_unexpected;

  wire aclk;
  wire aclken;
  wire aresetn;
  wire event_s_config_tlast_missing;
  wire event_s_config_tlast_unexpected;
  wire [15:0]m_axis_data_tdata;
  wire m_axis_data_tvalid;
  wire [31:0]s_axis_config_tdata;
  wire s_axis_config_tlast;
  wire s_axis_config_tvalid;
  wire NLW_U0_debug_axi_resync_in_UNCONNECTED;
  wire NLW_U0_debug_core_nd_UNCONNECTED;
  wire NLW_U0_debug_phase_nd_UNCONNECTED;
  wire NLW_U0_event_phase_in_invalid_UNCONNECTED;
  wire NLW_U0_event_pinc_invalid_UNCONNECTED;
  wire NLW_U0_event_poff_invalid_UNCONNECTED;
  wire NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_missing_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED;
  wire NLW_U0_m_axis_data_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_phase_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_phase_tvalid_UNCONNECTED;
  wire NLW_U0_s_axis_config_tready_UNCONNECTED;
  wire NLW_U0_s_axis_phase_tready_UNCONNECTED;
  wire [0:0]NLW_U0_debug_axi_chan_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_pinc_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_poff_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_phase_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_data_tuser_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_phase_tdata_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_phase_tuser_UNCONNECTED;

  (* C_ACCUMULATOR_WIDTH = "16" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "2" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "1" *) 
  (* C_HAS_ARESETN = "1" *) 
  (* C_HAS_M_DATA = "1" *) 
  (* C_HAS_M_PHASE = "0" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "0" *) 
  (* C_HAS_SINCOS = "1" *) 
  (* C_HAS_S_CONFIG = "1" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "0" *) 
  (* C_LATENCY = "5" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "16" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "1" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "0" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "11" *) 
  (* C_PHASE_ANGLE_WIDTH = "11" *) 
  (* C_PHASE_INCREMENT = "1" *) 
  (* C_PHASE_INCREMENT_VALUE = "100000000,100000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "1" *) 
  (* C_PHASE_OFFSET_VALUE = "0,100000000000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "32" *) 
  (* C_S_PHASE_HAS_TUSER = "0" *) 
  (* C_S_PHASE_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_TUSER_WIDTH = "1" *) 
  (* C_USE_DSP48 = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  singen_dds_compiler_v6_0_18 U0
       (.aclk(aclk),
        .aclken(aclken),
        .aresetn(aresetn),
        .debug_axi_chan_in(NLW_U0_debug_axi_chan_in_UNCONNECTED[0]),
        .debug_axi_pinc_in(NLW_U0_debug_axi_pinc_in_UNCONNECTED[15:0]),
        .debug_axi_poff_in(NLW_U0_debug_axi_poff_in_UNCONNECTED[15:0]),
        .debug_axi_resync_in(NLW_U0_debug_axi_resync_in_UNCONNECTED),
        .debug_core_nd(NLW_U0_debug_core_nd_UNCONNECTED),
        .debug_phase(NLW_U0_debug_phase_UNCONNECTED[15:0]),
        .debug_phase_nd(NLW_U0_debug_phase_nd_UNCONNECTED),
        .event_phase_in_invalid(NLW_U0_event_phase_in_invalid_UNCONNECTED),
        .event_pinc_invalid(NLW_U0_event_pinc_invalid_UNCONNECTED),
        .event_poff_invalid(NLW_U0_event_poff_invalid_UNCONNECTED),
        .event_s_config_tlast_missing(event_s_config_tlast_missing),
        .event_s_config_tlast_unexpected(event_s_config_tlast_unexpected),
        .event_s_phase_chanid_incorrect(NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED),
        .event_s_phase_tlast_missing(NLW_U0_event_s_phase_tlast_missing_UNCONNECTED),
        .event_s_phase_tlast_unexpected(NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tlast(NLW_U0_m_axis_data_tlast_UNCONNECTED),
        .m_axis_data_tready(1'b0),
        .m_axis_data_tuser(NLW_U0_m_axis_data_tuser_UNCONNECTED[0]),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(NLW_U0_m_axis_phase_tdata_UNCONNECTED[0]),
        .m_axis_phase_tlast(NLW_U0_m_axis_phase_tlast_UNCONNECTED),
        .m_axis_phase_tready(1'b0),
        .m_axis_phase_tuser(NLW_U0_m_axis_phase_tuser_UNCONNECTED[0]),
        .m_axis_phase_tvalid(NLW_U0_m_axis_phase_tvalid_UNCONNECTED),
        .s_axis_config_tdata(s_axis_config_tdata),
        .s_axis_config_tlast(s_axis_config_tlast),
        .s_axis_config_tready(NLW_U0_s_axis_config_tready_UNCONNECTED),
        .s_axis_config_tvalid(s_axis_config_tvalid),
        .s_axis_phase_tdata(1'b0),
        .s_axis_phase_tlast(1'b0),
        .s_axis_phase_tready(NLW_U0_s_axis_phase_tready_UNCONNECTED),
        .s_axis_phase_tuser(1'b0),
        .s_axis_phase_tvalid(1'b0));
endmodule

(* C_ACCUMULATOR_WIDTH = "16" *) (* C_AMPLITUDE = "0" *) (* C_CHANNELS = "2" *) 
(* C_CHAN_WIDTH = "1" *) (* C_DEBUG_INTERFACE = "0" *) (* C_HAS_ACLKEN = "1" *) 
(* C_HAS_ARESETN = "1" *) (* C_HAS_M_DATA = "1" *) (* C_HAS_M_PHASE = "0" *) 
(* C_HAS_PHASEGEN = "1" *) (* C_HAS_PHASE_OUT = "0" *) (* C_HAS_SINCOS = "1" *) 
(* C_HAS_S_CONFIG = "1" *) (* C_HAS_S_PHASE = "0" *) (* C_HAS_TLAST = "0" *) 
(* C_HAS_TREADY = "0" *) (* C_LATENCY = "5" *) (* C_MEM_TYPE = "1" *) 
(* C_MODE_OF_OPERATION = "0" *) (* C_MODULUS = "9" *) (* C_M_DATA_HAS_TUSER = "0" *) 
(* C_M_DATA_TDATA_WIDTH = "16" *) (* C_M_DATA_TUSER_WIDTH = "1" *) (* C_M_PHASE_HAS_TUSER = "0" *) 
(* C_M_PHASE_TDATA_WIDTH = "1" *) (* C_M_PHASE_TUSER_WIDTH = "1" *) (* C_NEGATIVE_COSINE = "0" *) 
(* C_NEGATIVE_SINE = "0" *) (* C_NOISE_SHAPING = "0" *) (* C_OPTIMISE_GOAL = "0" *) 
(* C_OUTPUTS_REQUIRED = "0" *) (* C_OUTPUT_FORM = "0" *) (* C_OUTPUT_WIDTH = "11" *) 
(* C_PHASE_ANGLE_WIDTH = "11" *) (* C_PHASE_INCREMENT = "1" *) (* C_PHASE_INCREMENT_VALUE = "100000000,100000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
(* C_PHASE_OFFSET = "1" *) (* C_PHASE_OFFSET_VALUE = "0,100000000000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) (* C_POR_MODE = "0" *) 
(* C_RESYNC = "0" *) (* C_S_CONFIG_SYNC_MODE = "0" *) (* C_S_CONFIG_TDATA_WIDTH = "32" *) 
(* C_S_PHASE_HAS_TUSER = "0" *) (* C_S_PHASE_TDATA_WIDTH = "1" *) (* C_S_PHASE_TUSER_WIDTH = "1" *) 
(* C_USE_DSP48 = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "dds_compiler_v6_0_18" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module singen_dds_compiler_v6_0_18
   (aclk,
    aclken,
    aresetn,
    s_axis_phase_tvalid,
    s_axis_phase_tready,
    s_axis_phase_tdata,
    s_axis_phase_tlast,
    s_axis_phase_tuser,
    s_axis_config_tvalid,
    s_axis_config_tready,
    s_axis_config_tdata,
    s_axis_config_tlast,
    m_axis_data_tvalid,
    m_axis_data_tready,
    m_axis_data_tdata,
    m_axis_data_tlast,
    m_axis_data_tuser,
    m_axis_phase_tvalid,
    m_axis_phase_tready,
    m_axis_phase_tdata,
    m_axis_phase_tlast,
    m_axis_phase_tuser,
    event_pinc_invalid,
    event_poff_invalid,
    event_phase_in_invalid,
    event_s_phase_tlast_missing,
    event_s_phase_tlast_unexpected,
    event_s_phase_chanid_incorrect,
    event_s_config_tlast_missing,
    event_s_config_tlast_unexpected,
    debug_axi_pinc_in,
    debug_axi_poff_in,
    debug_axi_resync_in,
    debug_axi_chan_in,
    debug_core_nd,
    debug_phase,
    debug_phase_nd);
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_phase_tvalid;
  output s_axis_phase_tready;
  input [0:0]s_axis_phase_tdata;
  input s_axis_phase_tlast;
  input [0:0]s_axis_phase_tuser;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [31:0]s_axis_config_tdata;
  input s_axis_config_tlast;
  output m_axis_data_tvalid;
  input m_axis_data_tready;
  output [15:0]m_axis_data_tdata;
  output m_axis_data_tlast;
  output [0:0]m_axis_data_tuser;
  output m_axis_phase_tvalid;
  input m_axis_phase_tready;
  output [0:0]m_axis_phase_tdata;
  output m_axis_phase_tlast;
  output [0:0]m_axis_phase_tuser;
  output event_pinc_invalid;
  output event_poff_invalid;
  output event_phase_in_invalid;
  output event_s_phase_tlast_missing;
  output event_s_phase_tlast_unexpected;
  output event_s_phase_chanid_incorrect;
  output event_s_config_tlast_missing;
  output event_s_config_tlast_unexpected;
  output [15:0]debug_axi_pinc_in;
  output [15:0]debug_axi_poff_in;
  output debug_axi_resync_in;
  output [0:0]debug_axi_chan_in;
  output debug_core_nd;
  output [15:0]debug_phase;
  output debug_phase_nd;

  wire \<const0> ;
  wire aclk;
  wire aclken;
  wire aresetn;
  wire event_s_config_tlast_missing;
  wire event_s_config_tlast_unexpected;
  wire [10:0]\^m_axis_data_tdata ;
  wire m_axis_data_tvalid;
  wire [31:0]s_axis_config_tdata;
  wire s_axis_config_tlast;
  wire s_axis_config_tready;
  wire s_axis_config_tvalid;
  wire NLW_i_synth_debug_axi_resync_in_UNCONNECTED;
  wire NLW_i_synth_debug_core_nd_UNCONNECTED;
  wire NLW_i_synth_debug_phase_nd_UNCONNECTED;
  wire NLW_i_synth_event_phase_in_invalid_UNCONNECTED;
  wire NLW_i_synth_event_pinc_invalid_UNCONNECTED;
  wire NLW_i_synth_event_poff_invalid_UNCONNECTED;
  wire NLW_i_synth_event_s_phase_chanid_incorrect_UNCONNECTED;
  wire NLW_i_synth_event_s_phase_tlast_missing_UNCONNECTED;
  wire NLW_i_synth_event_s_phase_tlast_unexpected_UNCONNECTED;
  wire NLW_i_synth_m_axis_data_tlast_UNCONNECTED;
  wire NLW_i_synth_m_axis_phase_tlast_UNCONNECTED;
  wire NLW_i_synth_m_axis_phase_tvalid_UNCONNECTED;
  wire NLW_i_synth_s_axis_phase_tready_UNCONNECTED;
  wire [0:0]NLW_i_synth_debug_axi_chan_in_UNCONNECTED;
  wire [15:0]NLW_i_synth_debug_axi_pinc_in_UNCONNECTED;
  wire [15:0]NLW_i_synth_debug_axi_poff_in_UNCONNECTED;
  wire [15:0]NLW_i_synth_debug_phase_UNCONNECTED;
  wire [14:10]NLW_i_synth_m_axis_data_tdata_UNCONNECTED;
  wire [0:0]NLW_i_synth_m_axis_data_tuser_UNCONNECTED;
  wire [0:0]NLW_i_synth_m_axis_phase_tdata_UNCONNECTED;
  wire [0:0]NLW_i_synth_m_axis_phase_tuser_UNCONNECTED;

  assign debug_axi_chan_in[0] = \<const0> ;
  assign debug_axi_pinc_in[15] = \<const0> ;
  assign debug_axi_pinc_in[14] = \<const0> ;
  assign debug_axi_pinc_in[13] = \<const0> ;
  assign debug_axi_pinc_in[12] = \<const0> ;
  assign debug_axi_pinc_in[11] = \<const0> ;
  assign debug_axi_pinc_in[10] = \<const0> ;
  assign debug_axi_pinc_in[9] = \<const0> ;
  assign debug_axi_pinc_in[8] = \<const0> ;
  assign debug_axi_pinc_in[7] = \<const0> ;
  assign debug_axi_pinc_in[6] = \<const0> ;
  assign debug_axi_pinc_in[5] = \<const0> ;
  assign debug_axi_pinc_in[4] = \<const0> ;
  assign debug_axi_pinc_in[3] = \<const0> ;
  assign debug_axi_pinc_in[2] = \<const0> ;
  assign debug_axi_pinc_in[1] = \<const0> ;
  assign debug_axi_pinc_in[0] = \<const0> ;
  assign debug_axi_poff_in[15] = \<const0> ;
  assign debug_axi_poff_in[14] = \<const0> ;
  assign debug_axi_poff_in[13] = \<const0> ;
  assign debug_axi_poff_in[12] = \<const0> ;
  assign debug_axi_poff_in[11] = \<const0> ;
  assign debug_axi_poff_in[10] = \<const0> ;
  assign debug_axi_poff_in[9] = \<const0> ;
  assign debug_axi_poff_in[8] = \<const0> ;
  assign debug_axi_poff_in[7] = \<const0> ;
  assign debug_axi_poff_in[6] = \<const0> ;
  assign debug_axi_poff_in[5] = \<const0> ;
  assign debug_axi_poff_in[4] = \<const0> ;
  assign debug_axi_poff_in[3] = \<const0> ;
  assign debug_axi_poff_in[2] = \<const0> ;
  assign debug_axi_poff_in[1] = \<const0> ;
  assign debug_axi_poff_in[0] = \<const0> ;
  assign debug_axi_resync_in = \<const0> ;
  assign debug_core_nd = \<const0> ;
  assign debug_phase[15] = \<const0> ;
  assign debug_phase[14] = \<const0> ;
  assign debug_phase[13] = \<const0> ;
  assign debug_phase[12] = \<const0> ;
  assign debug_phase[11] = \<const0> ;
  assign debug_phase[10] = \<const0> ;
  assign debug_phase[9] = \<const0> ;
  assign debug_phase[8] = \<const0> ;
  assign debug_phase[7] = \<const0> ;
  assign debug_phase[6] = \<const0> ;
  assign debug_phase[5] = \<const0> ;
  assign debug_phase[4] = \<const0> ;
  assign debug_phase[3] = \<const0> ;
  assign debug_phase[2] = \<const0> ;
  assign debug_phase[1] = \<const0> ;
  assign debug_phase[0] = \<const0> ;
  assign debug_phase_nd = \<const0> ;
  assign event_phase_in_invalid = \<const0> ;
  assign event_pinc_invalid = \<const0> ;
  assign event_poff_invalid = \<const0> ;
  assign event_s_phase_chanid_incorrect = \<const0> ;
  assign event_s_phase_tlast_missing = \<const0> ;
  assign event_s_phase_tlast_unexpected = \<const0> ;
  assign m_axis_data_tdata[15] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[14] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[13] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[12] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[11] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[10:0] = \^m_axis_data_tdata [10:0];
  assign m_axis_data_tlast = \<const0> ;
  assign m_axis_data_tuser[0] = \<const0> ;
  assign m_axis_phase_tdata[0] = \<const0> ;
  assign m_axis_phase_tlast = \<const0> ;
  assign m_axis_phase_tuser[0] = \<const0> ;
  assign m_axis_phase_tvalid = \<const0> ;
  assign s_axis_phase_tready = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ACCUMULATOR_WIDTH = "16" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "2" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "1" *) 
  (* C_HAS_ARESETN = "1" *) 
  (* C_HAS_M_DATA = "1" *) 
  (* C_HAS_M_PHASE = "0" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "0" *) 
  (* C_HAS_SINCOS = "1" *) 
  (* C_HAS_S_CONFIG = "1" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "0" *) 
  (* C_LATENCY = "5" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "16" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "1" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "0" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "11" *) 
  (* C_PHASE_ANGLE_WIDTH = "11" *) 
  (* C_PHASE_INCREMENT = "1" *) 
  (* C_PHASE_INCREMENT_VALUE = "100000000,100000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "1" *) 
  (* C_PHASE_OFFSET_VALUE = "0,100000000000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "32" *) 
  (* C_S_PHASE_HAS_TUSER = "0" *) 
  (* C_S_PHASE_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_TUSER_WIDTH = "1" *) 
  (* C_USE_DSP48 = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  singen_dds_compiler_v6_0_18_viv i_synth
       (.aclk(aclk),
        .aclken(aclken),
        .aresetn(aresetn),
        .debug_axi_chan_in(NLW_i_synth_debug_axi_chan_in_UNCONNECTED[0]),
        .debug_axi_pinc_in(NLW_i_synth_debug_axi_pinc_in_UNCONNECTED[15:0]),
        .debug_axi_poff_in(NLW_i_synth_debug_axi_poff_in_UNCONNECTED[15:0]),
        .debug_axi_resync_in(NLW_i_synth_debug_axi_resync_in_UNCONNECTED),
        .debug_core_nd(NLW_i_synth_debug_core_nd_UNCONNECTED),
        .debug_phase(NLW_i_synth_debug_phase_UNCONNECTED[15:0]),
        .debug_phase_nd(NLW_i_synth_debug_phase_nd_UNCONNECTED),
        .event_phase_in_invalid(NLW_i_synth_event_phase_in_invalid_UNCONNECTED),
        .event_pinc_invalid(NLW_i_synth_event_pinc_invalid_UNCONNECTED),
        .event_poff_invalid(NLW_i_synth_event_poff_invalid_UNCONNECTED),
        .event_s_config_tlast_missing(event_s_config_tlast_missing),
        .event_s_config_tlast_unexpected(event_s_config_tlast_unexpected),
        .event_s_phase_chanid_incorrect(NLW_i_synth_event_s_phase_chanid_incorrect_UNCONNECTED),
        .event_s_phase_tlast_missing(NLW_i_synth_event_s_phase_tlast_missing_UNCONNECTED),
        .event_s_phase_tlast_unexpected(NLW_i_synth_event_s_phase_tlast_unexpected_UNCONNECTED),
        .m_axis_data_tdata({\^m_axis_data_tdata [10],NLW_i_synth_m_axis_data_tdata_UNCONNECTED[14:10],\^m_axis_data_tdata [9:0]}),
        .m_axis_data_tlast(NLW_i_synth_m_axis_data_tlast_UNCONNECTED),
        .m_axis_data_tready(1'b0),
        .m_axis_data_tuser(NLW_i_synth_m_axis_data_tuser_UNCONNECTED[0]),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(NLW_i_synth_m_axis_phase_tdata_UNCONNECTED[0]),
        .m_axis_phase_tlast(NLW_i_synth_m_axis_phase_tlast_UNCONNECTED),
        .m_axis_phase_tready(1'b0),
        .m_axis_phase_tuser(NLW_i_synth_m_axis_phase_tuser_UNCONNECTED[0]),
        .m_axis_phase_tvalid(NLW_i_synth_m_axis_phase_tvalid_UNCONNECTED),
        .s_axis_config_tdata(s_axis_config_tdata),
        .s_axis_config_tlast(s_axis_config_tlast),
        .s_axis_config_tready(s_axis_config_tready),
        .s_axis_config_tvalid(s_axis_config_tvalid),
        .s_axis_phase_tdata(1'b0),
        .s_axis_phase_tlast(1'b0),
        .s_axis_phase_tready(NLW_i_synth_s_axis_phase_tready_UNCONNECTED),
        .s_axis_phase_tuser(1'b0),
        .s_axis_phase_tvalid(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
ag49RSaXLOG4xxULlDyO1h9Bt1tXxD8QSYAdgfsZmsYA2qz7wg+SSUXB8JjzU2owt7o4eSmQVBkv
9kufty+oIQ==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
beER7wF1A3pmXiXm1TFX9IvmAFUcJ13uMC6TseJWrR0JDHD/O3dKRM6PO4Up/CFQ2H37nKClSGcK
Xug89GBtLfoDpFLh+xP2Vy07zuqOy7uywLvaukELsTzPf+0n/Xp60hkmPlC81KPi1DXhJUhJdbqA
yi5TP4w1WPUjCtK/688=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
uJZzBmpzrESHK9uJTBRGbyDZMxFeU9+2SClZZYLsPBAU9V9oQiK75ubhJObpnmwewUOoBxz3zJhu
34asP1BGbunyLgeJYr0OiNow3a8XihoRSYbIdKxKq3vjl4MLatqJEBLCN8Uqf0Pu+E+jWbMFfcxy
YAnzqN8sgF4OZI5wLBzPXafQi1767wu3Wtw/sQe5anCy8TAyLarP9ast1O9Vj15Rk2tLtgm/LZqR
yZd0qKSqmW4A81G6x+ixR2y/IqQ1qALI1NCgPfvH4Ieyq7XPyblqlNyParNLhG2wjr0y4ofNWp/3
h4o2c+vYiIrkx6rmzrp/rUIybZ9A9HDZaA+ciA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MfuZTTml919Hbg0Ib2VBuKuYX6+OjqUB2INt3NN2eutVeJhuMufRcsa0q1J3vztEmpkdGV6+RTfb
HKoQKFD6EwJ10b0AcDFjpD8+L6fGReFnvS0g731shB/OodUdaV8giQpoNHCm2XtoKsv/Lgqn+U27
EV3lJK6Lt+nUx6DUsocHc5RcvRHw58/myY6ZtXqFDMXJfFOVK18LSGHnEg1OXkFqEApSxPVexe3t
s0jVQDZRqkFortHzVNrWx73GPD4RFe+7vmA/hegviTOrtvw99UpoL8yyjZyO3WOlde1quROnWZtl
8BwV/r+EPBUPh50jKc+nVMUwLKYH8/iDFUIpsA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJsfCx8emG9lVb/vjASSH6y78U+06ketn/XvcxXkuwOnvwxs7wpKbvKxuP4Ht/qw/W2x/0Yf02kE
WBxMF+BnpDUX67X5j60mOzT2j0ZYCuFJN9kbpdHjz3Ekw/u9MBVbJppIZsHCWkzk8bOejCc+dey6
uKr6E3w+/K97/Rld2HkJp2oTONv039xGcZEjeSi0lePhlRX0rhSfD0ixFje/nMEadDX5qmjf3+jt
/VeShbed51E8U6v7e1T5QOk3TdFmkYjH+NGfYuQg3iCCVd/1LP9eqPJHZkzv46tJ9yquR6upFVae
N2f7q08udoFP14ZZMSWY0FVcj+R8uc1SpoZ08w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
DD7F0WIA2tCJDGGyuiJBMJ6VkyzlY4wTm+PBxGw32rno1Lc5XJ6R/MdpajSKtZkvW3jP5SII6hW8
/NoKV4ROiGDYzmMIubH+jq3u0TtkWxCL8+cj3SNuMEayY39+8F4sUjaZEFERxcl1JK64XpQCcPdd
qDExjxIvRWRuuTD424M=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Z8r/pZDFkssalgvLpiT5lxxnKwN27AIWvhfsYdefLfSuxYTC5pbsQO/glsRgaQ+pfMXTafAs1c8M
dypCXo6c0EAVYWrPv6LXzncAvpvkgF3equA0GovqWA9u1DpNOwpg1+9zyuK298jIW0FY3V+8XZYP
i9enkYei0sCGexSdPzqATDbRzjzApbpnBZpWe6z4en7Wb9o0cFYVvU0I2D694fRndQa2DDTk5yRa
yG9QYOCPabDGrsr3xHF371LpdUv9XcgOm45jMWa9bZ1oL2S9hL6xUIjS0C8vlmUWEtNohYiiamIC
mjfkGqLNOX02xYC0DG4kzfO01bAlP3sDf4JdCw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XzTpqPV5vrEjo754MH4B3e/moj1cyqKPwY7loaRsShBVdAdSdi6fAcUtdAFLlPvclRTKJtSPrGCI
DBZInY8uvE0NF5KyMJJf0MNv6nv1ZThtRHEfuYyoqZE1B64bUxFcTekT9H+4ebmnft1aaRNLAsQE
U1ldn8kMzSHON6779AuW6Lxesw16zyPtjD39e8z6aa+od3098qlaVimh7CHWWSihKIi0Vq1gCv3H
DMKDZzbwllkcqxaKpXKKH3miFAae75IgPyXg34Q56QhfoWqO0GxcJJw+N+GtiPt8vbI96SC9WDpN
bbYQFmTQHYhrk9XvsEHVTPHMv1LlJGG+6HkUfg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OGiM0+ETa7TdMqa7tbD9rx8l7MKKe/03Zg1Ku8JPKNwuGENifTAu14aRQgmr0ggCH5A9O+pCuYQC
ZekRij8YLBYTbrzf4OtDsTflQa5KrvyKveDTi7fPvsbiz5TbN8gvpMDoy5GTpr4uZ/x70IfVHSvy
h2aRL+DY1RC4JQh/EEAsg192dWT9ybYkeUGDzcR3nGkfs5n+K1G4C88wvWeP5CzTQ10iXjP2prSy
BEHiyPM9g/+BkNgS+YdL1RhDYZP3HxvNgy6aO7MgyPmc//c45gyLq8/kSqkTUdYqqZiwqzyJCt+5
z5lu1u0nfOn2YlFrQHfW7qfiJna04Y8x5MFHRA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 78928)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
