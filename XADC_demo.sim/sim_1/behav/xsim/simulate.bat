@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Fri Jun 12 12:34:21 -0400 2020
REM SW Build 2708876 on Wed Nov  6 21:40:23 MST 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim twelve_bit_Binary_to_BCD_tb_behav -key {Behavioral:sim_1:Functional:twelve_bit_Binary_to_BCD_tb} -tclbatch twelve_bit_Binary_to_BCD_tb.tcl -log simulate.log"
call xsim  twelve_bit_Binary_to_BCD_tb_behav -key {Behavioral:sim_1:Functional:twelve_bit_Binary_to_BCD_tb} -tclbatch twelve_bit_Binary_to_BCD_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
