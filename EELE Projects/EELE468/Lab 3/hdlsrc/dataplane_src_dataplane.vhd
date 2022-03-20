-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\lab3_p9\dataplane_src_dataplane.vhd
-- Created: 2020-04-17 18:48:36
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 1.01725e-08
-- Target subsystem base rate: 1.01725e-08
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1.01725e-08
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- avalon_source_valid           ce_out        1.01725e-08
-- avalon_source_data            ce_out        1.01725e-08
-- avalon_source_channel         ce_out        1.01725e-08
-- avalon_source_error           ce_out        1.01725e-08
-- LED                           ce_out        1.01725e-08
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: dataplane_src_dataplane
-- Source Path: lab3_p9/dataplane
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY dataplane_src_dataplane IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        avalon_sink_valid                 :   IN    std_logic;
        avalon_sink_data                  :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        avalon_sink_channel               :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        avalon_sink_error                 :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        register_control_left_gain        :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        register_control_right_gain       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        register_control_reset_threshold  :   IN    std_logic_vector(17 DOWNTO 0);  -- ufix18
        register_control_LED_persistence  :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
        ce_out                            :   OUT   std_logic;
        avalon_source_valid               :   OUT   std_logic;
        avalon_source_data                :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        avalon_source_channel             :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        avalon_source_error               :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        LED                               :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END dataplane_src_dataplane;


ARCHITECTURE rtl OF dataplane_src_dataplane IS

  -- Component Declarations
  COMPONENT dataplane_src_Avalon_Data_Processing
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Sink_Data                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Sink_Channel                    :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          Left_Gain                       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Right_Gain                      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Max_Reset_Threshold             :   IN    std_logic_vector(17 DOWNTO 0);  -- ufix18
          LED_persistence                 :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          Enable                          :   IN    std_logic;
          Source_Data                     :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          Source_Channel                  :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          LED                             :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : dataplane_src_Avalon_Data_Processing
    USE ENTITY work.dataplane_src_Avalon_Data_Processing(rtl);

  -- Signals
  SIGNAL Avalon_Data_Processing_out1      : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Avalon_Data_Processing_out2      : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL Avalon_Data_Processing_out3      : std_logic_vector(7 DOWNTO 0);  -- ufix8

BEGIN
  u_Avalon_Data_Processing : dataplane_src_Avalon_Data_Processing
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              Sink_Data => avalon_sink_data,  -- sfix32_En28
              Sink_Channel => avalon_sink_channel,  -- ufix2
              Left_Gain => register_control_left_gain,  -- sfix32_En28
              Right_Gain => register_control_right_gain,  -- sfix32_En28
              Max_Reset_Threshold => register_control_reset_threshold,  -- ufix18
              LED_persistence => register_control_LED_persistence,  -- ufix15
              Enable => avalon_sink_valid,
              Source_Data => Avalon_Data_Processing_out1,  -- sfix32_En28
              Source_Channel => Avalon_Data_Processing_out2,  -- ufix2
              LED => Avalon_Data_Processing_out3  -- uint8
              );

  ce_out <= clk_enable;

  avalon_source_valid <= avalon_sink_valid;

  avalon_source_data <= Avalon_Data_Processing_out1;

  avalon_source_channel <= Avalon_Data_Processing_out2;

  avalon_source_error <= avalon_sink_error;

  LED <= Avalon_Data_Processing_out3;

END rtl;

