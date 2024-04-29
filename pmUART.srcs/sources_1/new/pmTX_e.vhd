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

entity pmTX_e is

    Port ( clk_i : in STD_LOGIC;
           baud_i : in  STD_LOGIC;
           tx_data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_data_start_i : in STD_LOGIC;
           tx_o : out  STD_LOGIC);

end pmTX_e;

architecture pmTX_a of pmTX_e is
    signal baud_reg :  std_logic;
    signal tx_rdy : std_logic;
    signal data_reg : std_logic_vector (8 downto 1) := (others => '0');
    signal current_bit : std_logic;
    signal data_counter : integer := 0;         

begin

baud_reg <= baud_i;
data_reg <= tx_data_i;

data_process : process(baud_reg, clk_i)
begin
if(rising_edge(baud_reg) and tx_data_start_i = '0') then
    data_counter <= 0;
    current_bit <= '1';
end if;
if(rising_edge(baud_reg) and tx_data_start_i = '1') then
    if(data_counter = 0 and tx_data_start_i = '1')then
        current_bit <= '0'; --start bit
        data_counter <= data_counter + 1;
     elsif(data_counter > 8 and tx_data_start_i = '1')then
        current_bit <= '1'; --stop bit
        data_counter <= 0;
    elsif(data_counter >= 1 and tx_data_start_i = '1') then
        current_bit <= data_reg(data_counter);
        data_counter <= data_counter +1;

    end if;
end if;
tx_o <= current_bit;
end process data_process;

end pmTX_a;
