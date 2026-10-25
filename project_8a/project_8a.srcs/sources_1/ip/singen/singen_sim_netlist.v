// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sun Oct 25 21:47:01 2026
// Host        : HP running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Vivado/project_8a/project_8a.srcs/sources_1/ip/singen/singen_sim_netlist.v
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
    m_axis_phase_tvalid,
    m_axis_phase_tdata,
    event_s_config_tlast_missing,
    event_s_config_tlast_unexpected);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF M_AXIS_PHASE:S_AXIS_CONFIG:M_AXIS_DATA:S_AXIS_PHASE, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input aclk;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 aclken_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME aclken_intf, POLARITY ACTIVE_LOW" *) input aclken;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 aresetn_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME aresetn_intf, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input aresetn;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXIS_CONFIG, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) input s_axis_config_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TDATA" *) input [15:0]s_axis_config_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_CONFIG TLAST" *) input s_axis_config_tlast;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_DATA, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_data_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TDATA" *) output [31:0]m_axis_data_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_PHASE, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.000, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_phase_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TDATA" *) output [15:0]m_axis_phase_tdata;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_s_config_tlast_missing_intf INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME event_s_config_tlast_missing_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_s_config_tlast_missing;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 event_s_config_tlast_unexpected_intf INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME event_s_config_tlast_unexpected_intf, SENSITIVITY EDGE_RISING, PortWidth 1" *) output event_s_config_tlast_unexpected;

  wire aclk;
  wire aclken;
  wire aresetn;
  wire event_s_config_tlast_missing;
  wire event_s_config_tlast_unexpected;
  wire [31:0]m_axis_data_tdata;
  wire m_axis_data_tvalid;
  wire [15:0]m_axis_phase_tdata;
  wire m_axis_phase_tvalid;
  wire [15:0]s_axis_config_tdata;
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
  wire NLW_U0_s_axis_config_tready_UNCONNECTED;
  wire NLW_U0_s_axis_phase_tready_UNCONNECTED;
  wire [0:0]NLW_U0_debug_axi_chan_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_pinc_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_axi_poff_in_UNCONNECTED;
  wire [15:0]NLW_U0_debug_phase_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_data_tuser_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_phase_tuser_UNCONNECTED;

  (* C_ACCUMULATOR_WIDTH = "16" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "2" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "1" *) 
  (* C_HAS_ARESETN = "1" *) 
  (* C_HAS_M_DATA = "1" *) 
  (* C_HAS_M_PHASE = "1" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "1" *) 
  (* C_HAS_SINCOS = "1" *) 
  (* C_HAS_S_CONFIG = "1" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "0" *) 
  (* C_LATENCY = "4" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "32" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "16" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "2" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "11" *) 
  (* C_PHASE_ANGLE_WIDTH = "11" *) 
  (* C_PHASE_INCREMENT = "1" *) 
  (* C_PHASE_INCREMENT_VALUE = "100000000,100000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "0" *) 
  (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "16" *) 
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
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tlast(NLW_U0_m_axis_phase_tlast_UNCONNECTED),
        .m_axis_phase_tready(1'b0),
        .m_axis_phase_tuser(NLW_U0_m_axis_phase_tuser_UNCONNECTED[0]),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
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
(* C_HAS_ARESETN = "1" *) (* C_HAS_M_DATA = "1" *) (* C_HAS_M_PHASE = "1" *) 
(* C_HAS_PHASEGEN = "1" *) (* C_HAS_PHASE_OUT = "1" *) (* C_HAS_SINCOS = "1" *) 
(* C_HAS_S_CONFIG = "1" *) (* C_HAS_S_PHASE = "0" *) (* C_HAS_TLAST = "0" *) 
(* C_HAS_TREADY = "0" *) (* C_LATENCY = "4" *) (* C_MEM_TYPE = "1" *) 
(* C_MODE_OF_OPERATION = "0" *) (* C_MODULUS = "9" *) (* C_M_DATA_HAS_TUSER = "0" *) 
(* C_M_DATA_TDATA_WIDTH = "32" *) (* C_M_DATA_TUSER_WIDTH = "1" *) (* C_M_PHASE_HAS_TUSER = "0" *) 
(* C_M_PHASE_TDATA_WIDTH = "16" *) (* C_M_PHASE_TUSER_WIDTH = "1" *) (* C_NEGATIVE_COSINE = "0" *) 
(* C_NEGATIVE_SINE = "0" *) (* C_NOISE_SHAPING = "0" *) (* C_OPTIMISE_GOAL = "0" *) 
(* C_OUTPUTS_REQUIRED = "2" *) (* C_OUTPUT_FORM = "0" *) (* C_OUTPUT_WIDTH = "11" *) 
(* C_PHASE_ANGLE_WIDTH = "11" *) (* C_PHASE_INCREMENT = "1" *) (* C_PHASE_INCREMENT_VALUE = "100000000,100000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
(* C_PHASE_OFFSET = "0" *) (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) (* C_POR_MODE = "0" *) 
(* C_RESYNC = "0" *) (* C_S_CONFIG_SYNC_MODE = "0" *) (* C_S_CONFIG_TDATA_WIDTH = "16" *) 
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
  input [15:0]s_axis_config_tdata;
  input s_axis_config_tlast;
  output m_axis_data_tvalid;
  input m_axis_data_tready;
  output [31:0]m_axis_data_tdata;
  output m_axis_data_tlast;
  output [0:0]m_axis_data_tuser;
  output m_axis_phase_tvalid;
  input m_axis_phase_tready;
  output [15:0]m_axis_phase_tdata;
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
  wire [26:0]\^m_axis_data_tdata ;
  wire [15:0]m_axis_phase_tdata;
  wire m_axis_phase_tvalid;
  wire [15:0]s_axis_config_tdata;
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
  wire [30:10]NLW_i_synth_m_axis_data_tdata_UNCONNECTED;
  wire [0:0]NLW_i_synth_m_axis_data_tuser_UNCONNECTED;
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
  assign m_axis_data_tdata[31] = \^m_axis_data_tdata [26];
  assign m_axis_data_tdata[30] = \^m_axis_data_tdata [26];
  assign m_axis_data_tdata[29] = \^m_axis_data_tdata [26];
  assign m_axis_data_tdata[28] = \^m_axis_data_tdata [26];
  assign m_axis_data_tdata[27] = \^m_axis_data_tdata [26];
  assign m_axis_data_tdata[26:16] = \^m_axis_data_tdata [26:16];
  assign m_axis_data_tdata[15] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[14] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[13] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[12] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[11] = \^m_axis_data_tdata [10];
  assign m_axis_data_tdata[10:0] = \^m_axis_data_tdata [10:0];
  assign m_axis_data_tlast = \<const0> ;
  assign m_axis_data_tuser[0] = \<const0> ;
  assign m_axis_data_tvalid = m_axis_phase_tvalid;
  assign m_axis_phase_tlast = \<const0> ;
  assign m_axis_phase_tuser[0] = \<const0> ;
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
  (* C_HAS_M_PHASE = "1" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "1" *) 
  (* C_HAS_SINCOS = "1" *) 
  (* C_HAS_S_CONFIG = "1" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "0" *) 
  (* C_LATENCY = "4" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "32" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "16" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "2" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "11" *) 
  (* C_PHASE_ANGLE_WIDTH = "11" *) 
  (* C_PHASE_INCREMENT = "1" *) 
  (* C_PHASE_INCREMENT_VALUE = "100000000,100000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "0" *) 
  (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "16" *) 
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
        .m_axis_data_tdata({\^m_axis_data_tdata [26],NLW_i_synth_m_axis_data_tdata_UNCONNECTED[30:26],\^m_axis_data_tdata [25:16],\^m_axis_data_tdata [10],NLW_i_synth_m_axis_data_tdata_UNCONNECTED[14:10],\^m_axis_data_tdata [9:0]}),
        .m_axis_data_tlast(NLW_i_synth_m_axis_data_tlast_UNCONNECTED),
        .m_axis_data_tready(1'b0),
        .m_axis_data_tuser(NLW_i_synth_m_axis_data_tuser_UNCONNECTED[0]),
        .m_axis_data_tvalid(m_axis_phase_tvalid),
        .m_axis_phase_tdata(m_axis_phase_tdata),
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
mE4w5YEba3ZHzUSbTNR+98kiHmbjt56PxfE3wKGImmtzJSL1Ww5HcGfYsK0VIsTrZ1R8+XPmWi5k
cdPMgKxyp5jBigZBkG8dWgu7h1otYP0TKoCgIotksfBz3K2hUxqGS7ITypv5OfM3kTO7Fhhw2dDP
cBgo8Zumr+D0r1v87SkywtsmW03MgCcbBgzwMxgQvfF0vNmPqTFxSHf8rbXEkHujHGqVlRzrNkTp
/RugAkj35fs8tQnZl0/p5RZiUQ/9AWi/tZZlKGZB5wvod8BylYOYOLcR+A5M4qTaVDQI7TsAEYPK
wbBOg+Z8kKINokukTb9GT69p3FiqoBsG5ydMJw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
3h75jBptP0Icx6wPgLZqP5544SG5i8jbO0A/q7uEEZHqEGMOWWu3QAByp+hVh7bjBGjGJpbMAD2I
mRHv84BUJ5a1Ajszc9/5msQvnobpnJsLjQpeo/0eQcrnF3f/vd+t+SM2ZaQTMB/mn6c7vrK3QX6I
IsfA5Id8Ab7VQqWznf86Z6uqH6RftcbCTExUjZnKDCS42eD3zfvKahfcex9eWWaGeLtGbRvKoZPb
zVhqwXGFpyD7/Wt+q71iN6P/Ih/CfjyY8Cud2hgbX4s/38a0EYZdffCde3ugu6FOai2O+4XkwYbe
vqyLh/2HAUZiIy0mOyrhZtAJt0hMEymKsQJxZw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 71264)
`pragma protect data_block
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
BN2IyF62dv65JN0SS60=
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
