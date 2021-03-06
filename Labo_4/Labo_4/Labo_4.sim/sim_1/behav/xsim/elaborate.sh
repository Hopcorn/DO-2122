#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Nov 23 14:55:13 CET 2021
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
#
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 82f1a03f0da045649e4b9a65d25dfbc2 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot data_path_tb_behav xil_defaultlib.data_path_tb -log elaborate.log"
xelab -wto 82f1a03f0da045649e4b9a65d25dfbc2 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot data_path_tb_behav xil_defaultlib.data_path_tb -log elaborate.log

