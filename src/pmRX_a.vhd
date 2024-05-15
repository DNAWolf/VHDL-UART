architecture pmRX_a of pmRX_e is

type state_type is (idle, reset, baud_rst, start_bit, bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7, stop_bit, invalid_data);
signal state, next_state : state_type;
signal data_o_reg : STD_LOGIC_VECTOR (7 downto 0);
signal bit0_s : STD_LOGIC;
signal bit1_s : STD_LOGIC;
signal bit2_s : STD_LOGIC;
signal bit3_s : STD_LOGIC;
signal bit4_s : STD_LOGIC;
signal bit5_s : STD_LOGIC;
signal bit6_s : STD_LOGIC;
signal bit7_s : STD_LOGIC;

begin

------------------------------------------------------------------------------------------------------------------------------------
--State Processing
------------------------------------------------------------------------------------------------------------------------------------
rx_fsm : process(baud_i, baud_2_i, state, rx_i, rst_i)
begin
    next_state <= state;
    case state is
        when reset    => if(rst_i = '0')then
                            next_state <= reset;
                          else
                            next_state <= idle;
                          end if;
         when idle    => if(rx_i 'event and rx_i = '0')then
                            next_state <= baud_rst;
                         end if;
        when baud_rst =>  next_state <= start_bit;
        when start_bit => if(baud_i = '1')then
                            next_state <= bit0;
                          end if;
        when bit0 =>      if(baud_2_i = '1')then
                            data_o_reg(0) <= rx_i;
                          end if;
                          if(baud_i = '1')then
                            next_state <= bit1;
                          end if; 
        when bit1 => if(baud_2_i = '1')then
                            data_o_reg(1) <= rx_i;
                          end if;
                          if(baud_i = '1')then
                            next_state <= bit2;
                          end if;
        when bit2 => if(baud_2_i = '1')then
                            data_o_reg(2) <= rx_i;
                          end if;
                        if(baud_i = '1')then
                            next_state <= bit3;
                          end if; 
        when bit3 => if(baud_2_i = '1')then
                            data_o_reg(3) <= rx_i;
                          end if;
                          if(baud_i = '1')then
                            next_state <= bit4;
                          end if; 
        when bit4 => if(baud_2_i = '1')then
                            data_o_reg(4) <= rx_i;
                          end if;
                          if(baud_i = '1')then
                            next_state <= bit5;
                          end if; 
        when bit5 => if(baud_2_i = '1')then
                            data_o_reg(5) <= rx_i;
                          end if;
                          if(baud_i = '1')then
                            next_state <= bit6;
                          end if; 
        when bit6 => if(baud_2_i = '1')then
                            data_o_reg(6) <= rx_i;
                          end if;
                          if(baud_i = '1')then
                            next_state <= bit7;
                          end if; 
        when bit7 => if(baud_2_i = '1')then
                            data_o_reg(7) <= rx_i;
                          end if;
                          if(baud_i = '1')then
                            next_state <= stop_bit;
                          end if;
        when stop_bit => if(rx_i = '1')then
                            next_state <= idle;
                         else
                            next_state <= invalid_data;
                         end if;          
        when invalid_data => next_state <= idle; 
    end case;                                                                                                                                                                                                                
        
end process rx_fsm;
------------------------------------------------------------------------------------------------------------------------------------
--OUTPUTS
------------------------------------------------------------------------------------------------------------------------------------
data_o <= (others => '0') when (state = invalid_data or state = reset)else
          data_o_reg when(state = stop_bit or state = idle) else
          (others => '0');
    

rx_data_rdy_o <= '1' when (state = stop_bit)else
                 '0';
                                  
start_br_cnt_o <= '1' when (state = baud_rst) else
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
