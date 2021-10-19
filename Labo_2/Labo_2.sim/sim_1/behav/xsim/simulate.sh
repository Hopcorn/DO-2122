#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Tue Oct 19 14:55:32 CEST 2021
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
#
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim ADD_tb_behav -key {Behavioral:sim_1:Functional:ADD_tb} -tclbatch ADD_tb.tcl -log simulate.log"
xsim ADD_tb_behav -key {Behavioral:sim_1:Functional:ADD_tb} -tclbatch ADD_tb.tcl -log simulate.log

