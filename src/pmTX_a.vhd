architecture pmTX_a of pmTX_e is
    signal data_reg : std_logic_vector (7 downto 0);
    signal data_counter : integer;
    type state_type is (idle, reset, start_bit, bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7, stop_bit);
    signal state, next_state : state_type;

begin
data_reg <= tx_data_i;

------------------------------------------------------------------------------------------------------------------------------------
--State Processing
------------------------------------------------------------------------------------------------------------------------------------
tx_fsm : process(baud_i, tx_data_start_i, state, rst_i)
begin
    next_state <= state;
    case state is
        when reset => if(rst_i = '0')then
                        next_state <= reset;
                      else
                        next_state <= idle;
                      end if;  
        when idle => if(tx_data_start_i = '1' and baud_i = '1')then
                        next_state <= start_bit;
                     end if;
        when start_bit => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit0;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;
        when bit0 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit1;                          
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;
        when bit1 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit2;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;                          
        when bit2 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit3;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;                          
        when bit3 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit4;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;                          
        when bit4 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit5;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;                          
        when bit5 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit6;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;                          
        when bit6 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= bit7;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;                               
        when bit7 => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= stop_bit;
                          end if;
                          if(tx_data_start_i = '0')then
                            next_state <= idle;
                          end if;                          
        when stop_bit => if(baud_i = '1' and tx_data_start_i = '1')then
                            next_state <= start_bit;
                          else
                            next_state <= idle;
                          end if;
        when others => next_state <= idle;  
    end case;
end process tx_fsm;
------------------------------------------------------------------------------------------------------------------------------------
--OUTPUTS
------------------------------------------------------------------------------------------------------------------------------------

tx_o <= '1' when state = idle or state = stop_bit or state = reset else
        data_reg(0) when state = bit0 else
        data_reg(1) when state = bit1 else
        data_reg(2) when state = bit2 else
        data_reg(3) when state = bit3 else
        data_reg(4) when state = bit4 else
        data_reg(5) when state = bit5 else
        data_reg(6) when state = bit6 else
        data_reg(7) when state = bit7 else
        '0' when state = start_bit else
        '0';
tx_data_ready_o <= '1' when state = stop_bit else 
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
end pmTX_a;