-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\lab3_p9\dataplane_ip_dut.vhd
-- Created: 2020-04-17 18:41:36
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: dataplane_ip_dut
-- Source Path: dataplane_ip/dataplane_ip_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY dataplane_ip_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        avalon_sink_valid                 :   IN    std_logic;  -- ufix1
        avalon_sink_data                  :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        avalon_sink_channel               :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        avalon_sink_error                 :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        register_control_left_gain        :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        register_control_right_gain       :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        register_control_reset_threshold  :   IN    std_logic_vector(17 DOWNTO 0);  -- ufix18
        register_control_LED_persistence  :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
        ce_out                            :   OUT   std_logic;  -- ufix1
        avalon_source_valid               :   OUT   std_logic;  -- ufix1
        avalon_source_data                :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        avalon_source_channel             :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        avalon_source_error               :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        LED                               :   OUT   std_logic_vector(7 DOWNTO 0)  -- ufix8
        );
END dataplane_ip_dut;


ARCHITECTURE rtl OF dataplane_ip_dut IS

  -- Component Declarations
  COMPONENT dataplane_ip_src_dataplane
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          avalon_sink_valid               :   IN    std_logic;  -- ufix1
          avalon_sink_data                :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          avalon_sink_channel             :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          avalon_sink_error               :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          register_control_left_gain      :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          register_control_right_gain     :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          register_control_reset_threshold :   IN    std_logic_vector(17 DOWNTO 0);  -- ufix18
          register_control_LED_persistence :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          ce_out                          :   OUT   std_logic;  -- ufix1
          avalon_source_valid             :   OUT   std_logic;  -- ufix1
          avalon_source_data              :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
          avalon_source_channel           :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          avalon_source_error             :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          LED                             :   OUT   std_logic_vector(7 DOWNTO 0)  -- ufix8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : dataplane_ip_src_dataplane
    USE ENTITY work.dataplane_ip_src_dataplane(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL avalon_sink_valid_sig            : std_logic;  -- ufix1
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL avalon_source_valid_sig          : std_logic;  -- ufix1
  SIGNAL avalon_source_data_sig           : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL avalon_source_channel_sig        : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL avalon_source_error_sig          : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL LED_sig                          : std_logic_vector(7 DOWNTO 0);  -- ufix8

BEGIN
  u_dataplane_ip_src_dataplane : dataplane_ip_src_dataplane
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              avalon_sink_valid => avalon_sink_valid_sig,  -- ufix1
              avalon_sink_data => avalon_sink_data,  -- sfix32_En28
              avalon_sink_channel => avalon_sink_channel,  -- ufix2
              avalon_sink_error => avalon_sink_error,  -- ufix2
              register_control_left_gain => register_control_left_gain,  -- sfix32_En28
              register_control_right_gain => register_control_right_gain,  -- sfix32_En28
              register_control_reset_threshold => register_control_reset_threshold,  -- ufix18
              register_control_LED_persistence => register_control_LED_persistence,  -- ufix15
              ce_out => ce_out_sig,  -- ufix1
              avalon_source_valid => avalon_source_valid_sig,  -- ufix1
              avalon_source_data => avalon_source_data_sig,  -- sfix32_En28
              avalon_source_channel => avalon_source_channel_sig,  -- ufix2
              avalon_source_error => avalon_source_error_sig,  -- ufix2
              LED => LED_sig  -- ufix8
              );

  avalon_sink_valid_sig <= avalon_sink_valid;

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  avalon_source_valid <= avalon_source_valid_sig;

  avalon_source_data <= avalon_source_data_sig;

  avalon_source_channel <= avalon_source_channel_sig;

  avalon_source_error <= avalon_source_error_sig;

  LED <= LED_sig;

END rtl;

