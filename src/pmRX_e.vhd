----------------------------------------------------------------------------------
-- Company: RWU
-- Engineer: Peter Marschall
-- 
-- Create Date: 04/30/2024 02:32:02 PM
-- Design Name: 
-- Module Name: pmRX_e - pmRX_a
-- Project Name: Schaltungsentwurf 2
-- Target Devices: Zybo Board
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.5 - added data_rdy signal
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;


entity pmRX_e is
    Port ( baud_i : in STD_LOGIC;
           baud_2_i : in STD_LOGIC;
           rx_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           clk_i : in STD_LOGIC;
           start_br_cnt_o : out STD_LOGIC;
           rx_data_rdy_o : out STD_LOGIC;
           data_o : out STD_LOGIC_VECTOR (7 downto 0));
end pmRX_e;

