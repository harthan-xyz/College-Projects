-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\lab3_p9\dataplane_ip_src_Right_Channel_Processing.vhd
-- Created: 2020-04-17 18:41:15
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: dataplane_ip_src_Right_Channel_Processing
-- Source Path: lab3_p9/dataplane/Avalon Data Processing/Right Channel Processing
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY dataplane_ip_src_Right_Channel_Processing IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Right_Data_In                     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Right_Gain                        :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Enable                            :   IN    std_logic;
        Right_Data_Out                    :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END dataplane_ip_src_Right_Channel_Processing;


ARCHITECTURE rtl OF dataplane_ip_src_Right_Channel_Processing IS

  -- Component Declarations
  COMPONENT dataplane_ip_src_Sound_Effects_block
    PORT( Data_In                         :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Gain                            :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Data_Out                        :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : dataplane_ip_src_Sound_Effects_block
    USE ENTITY work.dataplane_ip_src_Sound_Effects_block(rtl);

  -- Signals
  SIGNAL enb_gated                        : std_logic;
  SIGNAL Enable_out3                      : std_logic;
  SIGNAL Sound_Effects_out1               : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Sound_Effects_out1_signed        : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Sound_Effects_out1_bypass        : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Sound_Effects_out1_last_value    : signed(31 DOWNTO 0);  -- sfix32_En28

BEGIN
  u_Sound_Effects : dataplane_ip_src_Sound_Effects_block
    PORT MAP( Data_In => Right_Data_In,  -- sfix32_En28
              Gain => Right_Gain,  -- sfix32_En28
              Data_Out => Sound_Effects_out1  -- sfix32_En28
              );

  Enable_out3 <= Enable;

  enb_gated <= Enable_out3 AND enb;

  Sound_Effects_out1_signed <= signed(Sound_Effects_out1);

  Right_Data_Out_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Sound_Effects_out1_last_value <= to_signed(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_gated = '1' THEN
        Sound_Effects_out1_last_value <= Sound_Effects_out1_bypass;
      END IF;
    END IF;
  END PROCESS Right_Data_Out_bypass_process;


  
  Sound_Effects_out1_bypass <= Sound_Effects_out1_last_value WHEN Enable_out3 = '0' ELSE
      Sound_Effects_out1_signed;

  Right_Data_Out <= std_logic_vector(Sound_Effects_out1_bypass);

END rtl;

