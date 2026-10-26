// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Oct 26 14:56:34 2026
// Host        : fpgalab210 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/lab1/Desktop/butkotoczynski/fpga_Nexys-A7/project_8a/project_8a.srcs/sources_1/ip/singen/singen_sim_netlist.v
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
rD5gL8lQGx0XrovV4G8F8d2i5YjfEU3fpie+RL3CeebwSJB+e8B60WuI5Ly407TrvQxS3vwAZRcz
NqsWKtJTQWkHgea9cgCLrY54rPtKXfPZyaeBqKIaqZFa/nO9SyUKOvf/ztCXuO9LbK/dwxCyIYoM
7UO/PKgFevoiiqe33gGb6WPDTUCR6qcCOfxJ90FZ4Wb+16yqPEg9QS0mJo9gtcoBplo+tdUt09/E
jJVA5xQZGSEBoSf0RGf2l1AvOtNmAjdy/hNJdHQm+Gn8PZwXJbW5aNFa4baxz52CAK57uk72pSGm
y6X4G5O6DKrxR7jtYS8fnCTf3InUrG8ht6d5bA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
pCvNnJastg6Qa5ioiKsvTunZ4t+zFHv09a3rZtFexIqTo5+6YhGta3ZKCXv+IIiRsnp/en3uGqaP
BSTDx0UEGs+CwAWY7yULYbn7FGW7N5hcV0yTfIwV5FOhx2JqXhZVSkkiPdsAGJKJ0TLrgwn6UUnd
6I4se0KOllqbmE3c05iFBlYtsNTFCMvoLAgtwzqgSRF2QkCmEuxUOCG0lJ0+BRg6zkZanFjBkdZt
Ia7Ha80Vj4D/6BMPTFxAHn7VcSAk6yVJgtXPQ4Ofbs0rWFsnFo09Q9NIQU3DyypEaJzjC9H3Bcc8
UG5cbdn+ROyRSJweYr4jdacuKPT0loHYO2Pi/g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 71264)
`pragma protect data_block
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
qgT8y+6cqSQ4ImvefwE=
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
