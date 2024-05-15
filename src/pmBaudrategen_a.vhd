architecture pmBaudrategen_a of pmBaudrategen_e is
    signal cnt_is_s : integer range 262143 downto 0; --!range is 2^18
    signal cnt_max_s : integer range 262143 downto 0; ----!range is 2^18
    signal cnt_mid_s : integer range 26143 downto 0; --!range is 2^18
begin
    cnt_max_s <= 13020 when baud_sel_i = '0' else -- is = 125Mhz / 9600baud = 13020.8333
               1085 when baud_sel_i = '1' else -- is 125Mhz / 115200baud = 1085.06944
               12500;

    cnt_mid_s <= cnt_max_s/2;
    
    zaehl : process(clk_i, rst_i)
    begin
        if(rst_i = '0') then
            cnt_is_s <= 0;
        elsif(clk_i 'event and clk_i = '1')then
            if(cnt_is_s >= cnt_max_s or baud_start_i = '1')then
                cnt_is_s <= 0 ;
            else
                cnt_is_s <= cnt_is_s+1;
            end if; --!is count max?
        end if; --!clock
    end process;

    baud_o <= '1' when (cnt_is_s = cnt_max_s) else '0';
    baud_2_o <= '1' when (cnt_is_s = cnt_mid_s) else '0';
    
end pmBaudrategen_a;
