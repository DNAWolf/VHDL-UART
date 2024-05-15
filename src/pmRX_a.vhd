architecture pmRX_a of pmRX_e is
signal internal_signal: std_logic;
begin

-- Process for clock and reset handling
    process(clk_i, rst_i)
    begin
        if (rst_i = '0') then
            -- Reset condition, initialize or reset any necessary signals or registers here
            start_br_cnt_o <= '0';
            rx_data_rdy_o <= '0';
            rx_fin_o <= '0';
            data_o <= (others => '0');
    
        elsif rising_edge(clk_i) then

            if baud_i = '1' and baud_2_i = '1' then
                internal_signal <= '1'; -- Some processing based on baud rate inputs
            else
                internal_signal <= '0';
            end if;
            start_br_cnt_o <= internal_signal;
            rx_data_rdy_o <= internal_signal;
            rx_fin_o <= internal_signal;
            data_o <= "00000000"; 
        end if;
    end process;

end pmRX_a;
