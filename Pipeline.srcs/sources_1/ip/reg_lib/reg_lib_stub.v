// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue May  2 12:57:09 2023
// Host        : MSI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Studying/Academic/HCMUT/222/ComputerArchitecture/Assignments/ThayBinh/Mips_Pipeline/Pipeline.srcs/sources_1/ip/reg_lib/reg_lib_stub.v
// Design      : reg_lib
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module reg_lib(clka, rsta, wea, addra, dina, douta, clkb, rstb, enb, web, 
  addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,rsta,wea[3:0],addra[4:0],dina[31:0],douta[31:0],clkb,rstb,enb,web[3:0],addrb[4:0],dinb[31:0],doutb[31:0]" */;
  input clka;
  input rsta;
  input [3:0]wea;
  input [4:0]addra;
  input [31:0]dina;
  output [31:0]douta;
  input clkb;
  input rstb;
  input enb;
  input [3:0]web;
  input [4:0]addrb;
  input [31:0]dinb;
  output [31:0]doutb;
endmodule