-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj_final\hdlsrc\lab3_p12\dataplane_src_Sound_Effects.vhd
-- Created: 2020-05-07 13:40:35
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: dataplane_src_Sound_Effects
-- Source Path: lab3_p12/dataplane/Avalon Data Processing/Left Channel Processing/Sound Effects
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY dataplane_src_Sound_Effects IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Data_In                           :   IN    std_logic_vector(31 DOWNTO 0);  -- sfix32_En28
        Enable_out4                       :   IN    std_logic;
        Data_Out                          :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
        );
END dataplane_src_Sound_Effects;


ARCHITECTURE rtl OF dataplane_src_Sound_Effects IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT dataplane_src_Sine_Wave1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          Sine_Wave_out1                  :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En28
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : dataplane_src_Sine_Wave1
    USE ENTITY work.dataplane_src_Sine_Wave1(rtl);

  -- Signals
  SIGNAL enb_gated                        : std_logic;
  SIGNAL Sine_Wave1_out1                  : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Sine_Wave1_out1_signed           : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Gain1_out1                       : signed(63 DOWNTO 0);  -- sfix64_En58
  SIGNAL Data_In_signed                   : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Constant_out1                    : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product2_out1                    : signed(95 DOWNTO 0);  -- sfix96_En86
  SIGNAL Data_Type_Conversion1_out1       : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Add_out1                         : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product1_out1                    : signed(63 DOWNTO 0);  -- sfix64_En56
  SIGNAL Data_Type_Conversion_out1        : signed(31 DOWNTO 0);  -- sfix32_En28

BEGIN
  u_Sine_Wave1 : dataplane_src_Sine_Wave1
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb_gated,
              Sine_Wave_out1 => Sine_Wave1_out1  -- sfix32_En28
              );

  enb_gated <= Enable_out4 AND enb;

  Sine_Wave1_out1_signed <= signed(Sine_Wave1_out1);

  Gain1_out1 <= resize(Sine_Wave1_out1_signed & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 64);

  Data_In_signed <= signed(Data_In);

  Constant_out1 <= to_signed(268435456, 32);

  Product2_out1 <= Gain1_out1 * Sine_Wave1_out1_signed;

  Data_Type_Conversion1_out1 <= Product2_out1(89 DOWNTO 58) + ('0' & Product2_out1(57));

  Add_out1 <= Constant_out1 + Data_Type_Conversion1_out1;

  Product1_out1 <= Data_In_signed * Add_out1;

  Data_Type_Conversion_out1 <= Product1_out1(59 DOWNTO 28) + ('0' & Product1_out1(27));

  Data_Out <= std_logic_vector(Data_Type_Conversion_out1);

END rtl;

