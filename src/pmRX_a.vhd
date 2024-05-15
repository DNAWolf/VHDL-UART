architecture pmRX_a of pmRX_e is

type state_type is (idle, reset, baud_rst, bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7, stop_bit, invalid_data);
signal state, next_state : state_type;

begin

------------------------------------------------------------------------------------------------------------------------------------
--State Processing
------------------------------------------------------------------------------------------------------------------------------------
rx_fsm : process(baud_i, state, rx_i)
begin
    next_state <= state;
    case state is
        when reset    => if(rst_i = '1')then
                            next_state <= reset;
                          else
                            next_state <= idle;
                          end if;
         when idle    => if(falling_edge(rx_i))then
                            next_state <= baud_rst;
                         end if;
        when baud_rst => if(baud_i = '1')then
                            next_state <= bit0;
                          end if;
        when bit0 => if(baud_i = '1')then
                            next_state <= bit1;
                          end if; 
        when bit1 => if(baud_i = '1')then
                            next_state <= bit2;
                          end if;
        when bit2 => if(baud_i = '1')then
                            next_state <= bit3;
                          end if; 
        when bit3 => if(baud_i = '1')then
                            next_state <= bit4;
                          end if; 
        when bit4 => if(baud_i = '1')then
                            next_state <= bit5;
                          end if; 
        when bit5 => if(baud_i = '1')then
                            next_state <= bit6;
                          end if; 
        when bit6 => if(baud_i = '1')then
                            next_state <= bit7;
                          end if; 
        when bit7 => if(baud_i = '1' and rx_i = '1')then
                            next_state <= stop_bit;
                     else
                            next_state <= invalid_data;
                          end if;  
        when stop_bit => next_state <= idle;
        when invalid_data => next_state <= idle; 
    end case;                                                                                                                                                                                                                
        
end process rx_fsm;
------------------------------------------------------------------------------------------------------------------------------------
--OUTPUTS
------------------------------------------------------------------------------------------------------------------------------------
data_o(0) <= rx_i when (state = bit0 and baud_2_i = '1');
data_o(1) <= rx_i when (state = bit1 and baud_2_i = '1');
data_o(2) <= rx_i when (state = bit2 and baud_2_i = '1');
data_o(3) <= rx_i when (state = bit3 and baud_2_i = '1');
data_o(4) <= rx_i when (state = bit4 and baud_2_i = '1');
data_o(5) <= rx_i when (state = bit5 and baud_2_i = '1');
data_o(6) <= rx_i when (state = bit6 and baud_2_i = '1');
data_o(7) <= rx_i when (state = bit7 and baud_2_i = '1');
data_o <= (others => '0') when state = invalid_data;

rx_data_rdy_o <= '1' when (state = stop_bit)else
                 '0';
                 
start_br_cnt_o <= '1' when (state = baud_rst)else
                  '0';
                  
------------------------------------------------------------------------------------------------------------------------------------
-- Clocked states and asynchronous restet
------------------------------------------------------------------------------------------------------------------------------------
process(clk_i, rst_i)
begin
    if(rst_i = '0') then
        state <= reset;
    elsif(rising_edge(clk_i)) then
        state <= next_state;
    end if;
end process;

end pmRX_a;
