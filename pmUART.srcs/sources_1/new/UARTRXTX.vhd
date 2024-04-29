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
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UARTRXTX_e is
    Port ( m_clk_i : in STD_LOGIC;
           m_rst_i : in STD_LOGIC;
           m_tx_data_i : in STD_LOGIC_VECTOR(7 downto 0);
           m_tx_start_i : in STD_LOGIC;
           m_tx_o : out STD_LOGIC;
           m_tx_data_rdy : out std_logic
           );
end UARTRXTX_e;

architecture UARTRXTX_a of UARTRXTX_e is

component pmTX_e is 
 Port ( clk_i : in STD_LOGIC;
        baud_i : in  STD_LOGIC;
        tx_data_i : in  STD_LOGIC_VECTOR (7 downto 0);
        tx_data_start_i : in STD_LOGIC;
        tx_o : out  STD_LOGIC); 
end component;   
    
component pmBaudrategen_e is
      Port (
        rst_i : in STD_LOGIC;
        clk_i : in STD_LOGIC; 
        baud_o : out STD_LOGIC
        ); 
end component;


signal baudrate : STD_LOGIC;
signal tx_o_sig : STD_LOGIC;
signal tx_start_i_sig : STD_LOGIC;

     
begin

tx_start_i_sig <= m_tx_start_i;

BAUD : pmBaudrategen_e 
PORT MAP(
    baud_o => baudrate,
    clk_i => m_clk_i,
    rst_i => m_rst_i
    );

TX  : pmTX_e
PORT MAP(
    clk_i => m_clk_i,
    baud_i => baudrate,
    tx_data_i => m_tx_data_i,
    tx_data_start_i => tx_start_i_sig,
    tx_o => tx_o_sig
    );

m_tx_o <= tx_o_sig;

end UARTRXTX_a;
