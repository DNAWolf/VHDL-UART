architecture pmRX_a of pmRX_e is

type state_type is (idle, reset, baud_rst, start_bit, bit0, bit1, bit2, bit3, bit4, bit5, bit6, bit7, stop_bit, invalid_data);
signal state, next_state : state_type;
signal data_o_reg : STD_LOGIC_VECTOR (7 downto 0);
signal rx_delay : STD_LOGIC_VECTOR (1 downto 0);
signal rx_falling : STD_LOGIC;

begin
-----------------------------------------------------------------------------------------------------------------------------------
-- rx falling edge detection
-----------------------------------------------------------------------------------------------------------------------------------
detect_falling : process(clk_i,rst_i)
begin
    if (rst_i = '0')then
        rx_delay <= (others => '0');
    elsif rising_edge(clk_i) then
        rx_delay(0) <= rx_i;
        rx_delay(1)<= rx_delay(0);
    end if;
end process detect_falling;
-----------------------------------------------------------------------------------------------------------------------------------
-- Input Register Writing
-----------------------------------------------------------------------------------------------------------------------------------
input : process(clk_i,rst_i)
begin
      if(rst_i = '0')then
        data_o_reg <= (others=>'0');
      elsif rising_edge(clk_i) then
        case state is
            when bit0 => 
                if baud_2_i = '1' then
                    data_o_reg(0) <= rx_i;
                end if;
            when bit1 => 
                if baud_2_i = '1' then
                    data_o_reg(1) <= rx_i;
                end if;
            when bit2 => 
                if baud_2_i = '1' then
                    data_o_reg(2) <= rx_i;
                end if;
            when bit3 => 
                if baud_2_i = '1' then
                    data_o_reg(3) <= rx_i;
                end if;
            when bit4 => 
                if baud_2_i = '1' then
                    data_o_reg(4) <= rx_i;
                end if;
            when bit5 => 
                if baud_2_i = '1' then
                    data_o_reg(5) <= rx_i;
                end if;
            when bit6 => 
                if baud_2_i = '1' then
                    data_o_reg(6) <= rx_i;
                end if;
            when bit7 => 
                if baud_2_i = '1' then
                    data_o_reg(7) <= rx_i;
                end if;
            when others =>
        end case;
    end if;
end process input;

------------------------------------------------------------------------------------------------------------------------------------
--State Processing
------------------------------------------------------------------------------------------------------------------------------------
rx_fsm : process(clk_i, rst_i)
begin
    if (rising_edge(clk_i))then
        case state is
             when reset   => next_state <= idle;
             when idle    => if(rx_falling = '1')then
                                next_state <= baud_rst;
                             end if;
            when baud_rst =>  next_state <= start_bit;
            when start_bit => if(baud_i = '1')then
                                next_state <= bit0;
                              end if;
            when bit0 =>     if(baud_i = '1')then
                                next_state <= bit1;
                              end if;
            when bit1 =>     if(baud_i = '1')then
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
            when bit7 => if(baud_i = '1')then
                                next_state <= stop_bit;
                              end if;
            when stop_bit => if(rx_i = '0')then
                                next_state <= invalid_data;
                             elsif(rx_i = '1' and baud_i = '0')then
                                next_state <= stop_bit;
                             elsif(rx_i = '1' and baud_i = '1')then
                                next_state <= idle;
                             end if;
            when invalid_data => next_state <= idle;
        end case;
    end if;
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
                  
rx_falling <= '1' when rx_delay(1) = '1' and rx_delay(0) ='0' else
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
