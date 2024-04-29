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
use IEEE.numeric_std.all;

entity pmBaudrategen_e is
    Port (
        rst_i : in STD_LOGIC;
        clk_i : in STD_LOGIC; 
        baud_o : out STD_LOGIC
        ); 
           
end pmBaudrategen_e;

architecture pmBaudrategen_a of pmBaudrategen_e is
    signal cnt_is : integer range 262143 downto 0; --!range is 2^18
    signal cnt_max : integer range 262143 downto 0; ----!range is 2^18
begin

    cnt_max <= 12500; --! is = 120Mhz / 9600baud = 12500
    zaehl : process(clk_i, rst_i)
    begin
        if(rst_i = '0') then
            cnt_is <= 0;
        elsif(clk_i 'event and clk_i = '1')then
            if(cnt_is >= cnt_max)then
                cnt_is <= 0 ;
            else
                cnt_is <= cnt_is+1;
            end if; --!is count max?
        end if; --!clock
    end process;
    
    baud_o <= '1' when (cnt_is = 0) else '0';
    
end pmBaudrategen_a;
