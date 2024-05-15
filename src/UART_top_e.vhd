----------------------------------------------------------------------------------
-- Company: RWU
-- Engineer: Peter Marschall
-- 
-- Create Date: 04/23/2024 07:23:44 PM
-- Design Name: 
-- Module Name: UARTRXTX_e - UARTRXTX_a
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.3 - Added m_tx_data_ready_o
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity UARTRXTX_e is
    Port ( m_clk_i : in STD_LOGIC;
           m_rst_i : in STD_LOGIC;
           m_baud_sel_i : in STD_LOGIC;
           m_tx_data_i : in STD_LOGIC_VECTOR(7 downto 0);
           m_tx_start_i : in STD_LOGIC;
           m_tx_data_ready_o : out STD_LOGIC;
           m_rx_i : in STD_LOGIC;
           m_tx_o : out STD_LOGIC;
           m_rx_data_ready_o : out std_logic;
           m_rx_data_o : out STD_LOGIC_VECTOR(7 downto 0);
           m_rx_fin_o : out STD_LOGIC
           );
end UARTRXTX_e;
