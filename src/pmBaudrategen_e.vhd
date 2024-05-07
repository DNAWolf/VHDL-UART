----------------------------------------------------------------------------------
-- Company: RWU
-- Engineer: Peter Marschall
-- 
-- Create Date: 04/23/2024 04:35:35 PM
-- Design Name: 
-- Module Name: pmBaudrategen_e - pmBaudrategen_a
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.02 - Added baud_sel_i
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.all;

entity pmBaudrategen_e is
    Port (
        rst_i : in STD_LOGIC;
        clk_i : in STD_LOGIC;
        baud_sel_i : in STD_LOGIC; -- if 0: Baud = 9600, if 1: Baud = 115200
        baud_o : out STD_LOGIC
        ); 
           
end pmBaudrategen_e;


