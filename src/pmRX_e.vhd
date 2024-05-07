----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 02:32:02 PM
-- Design Name: 
-- Module Name: pmRX_e - pmRX_a
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pmRX_e is
    Port ( baud_i : in STD_LOGIC;
           rx_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           data_o : out STD_LOGIC_VECTOR (7 downto 0));
end pmRX_e;

