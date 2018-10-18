#!/bin/bash -e



$PWD/../../../yosys-min/yosys -p "read_verilog -sv svinterface1.sv ; hierarchy -check -top TopModule ; synth ; write_verilog svinterface1_syn.v"
$PWD/../../../yosys-min/yosys -p "read_verilog -sv svinterface1_ref.v ; hierarchy -check -top TopModule ; synth ; write_verilog svinterface1_ref_syn.v"

iverilog -g2012 svinterface1_syn.v
iverilog -g2012 svinterface1_ref_syn.v
