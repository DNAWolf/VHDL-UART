architecture pmTX_a of pmTX_e is
    signal baud_reg :  std_logic;
    signal tx_rdy : std_logic;
    signal data_reg : std_logic_vector (8 downto 1) := (others => '0');
    signal current_bit : std_logic;
    signal data_counter : integer := 0;

begin

baud_reg <= baud_i;
data_reg <= tx_data_i;

tx_process : process(clk_i, rst_i)
begin
if(rst_i = '0') then
    current_bit <= '1';
    data_counter <= 0;
  elsif(rising_edge(clk_i))then
        if(baud_reg = '1') then
            if tx_data_start_i = '0' then
                data_counter <= 0;
                current_bit <= '1';
            end if;
        if(baud_reg = '1' and tx_data_start_i = '1') then
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
    end if;
end if;  
end process tx_process;

tx_o <= current_bit;
end pmTX_a;

