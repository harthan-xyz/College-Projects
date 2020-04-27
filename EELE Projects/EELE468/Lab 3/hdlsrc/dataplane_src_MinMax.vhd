-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\lab3_p9\dataplane_src_MinMax.vhd
-- Created: 2020-04-17 18:44:58
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: dataplane_src_MinMax
-- Source Path: lab3_p9/dataplane/Avalon Data Processing/Left Channel Processing/Signal Energy Monitor/Normalize 
-- Signal/MinMax/MinMa
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.dataplane_src_dataplane_pkg.ALL;

ENTITY dataplane_src_MinMax IS
  PORT( in0                               :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        in1                               :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        out0                              :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END dataplane_src_MinMax;


ARCHITECTURE rtl OF dataplane_src_MinMax IS

  -- Signals
  SIGNAL MinMax_muxout                    : vector_of_signed32(0 TO 1);  -- sfix32_En28 [2]
  SIGNAL MinMax_stage1_val                : signed(31 DOWNTO 0);  -- sfix32_En28

BEGIN
  MinMax_muxout(0) <= signed(in0);
  MinMax_muxout(1) <= signed(in1);

  ---- Tree max implementation ----
  ---- Tree max stage 1 ----
  
  MinMax_stage1_val <= MinMax_muxout(0) WHEN MinMax_muxout(0) >= MinMax_muxout(1) ELSE
      MinMax_muxout(1);

  out0 <= std_logic_vector(MinMax_stage1_val);

END rtl;
