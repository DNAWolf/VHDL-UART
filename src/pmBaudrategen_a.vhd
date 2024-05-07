architecture pmBaudrategen_a of pmBaudrategen_e is
    signal cnt_is : integer range 262143 downto 0; --!range is 2^18
    signal cnt_max : integer range 262143 downto 0; ----!range is 2^18
begin
    cnt_max <= 12500 when baud_sel_i = '0' else -- is = 120Mhz / 9600baud = 12500
               1042 when baud_sel_i = '1' else -- is 120Mhz / 115200baud = 1041.666667
               12500;

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
