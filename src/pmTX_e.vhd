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
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity pmTX_e is

    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           baud_i : in  STD_LOGIC;
           tx_data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_data_start_i : in STD_LOGIC;
           tx_o : out  STD_LOGIC);

end pmTX_e;

