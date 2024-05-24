library ieee;
use ieee.std_logic_1164.all;

entity tb_UARTRXTX_e is
end tb_UARTRXTX_e;

architecture tb of tb_UARTRXTX_e is

    component UARTRXTX_e
        port (m_clk_i           : in std_logic;
              m_rst_i           : in std_logic;
              m_baud_sel_i      : in std_logic;
              m_tx_data_i       : in std_logic_vector (7 downto 0);
              m_tx_start_i      : in std_logic;
              m_tx_data_ready_o : out std_logic;
              m_rx_i            : in std_logic;
              m_tx_o            : out std_logic;
              m_rx_data_ready_o : out std_logic;
              m_rx_data_o       : out std_logic_vector (7 downto 0));
    end component;

    signal m_clk_i_s          : std_logic;
    signal m_rst_i_s           : std_logic;
    signal m_baud_sel_i_s      : std_logic;
    signal m_tx_data_i_s       : std_logic_vector (7 downto 0);
    signal m_tx_start_i_s      : std_logic;
    signal m_tx_data_ready_o_s : std_logic;
    signal m_rx_i_s            : std_logic;
    signal m_tx_o_s            : std_logic;
    signal m_rx_data_ready_o_s : std_logic;
    signal m_rx_data_o_s       : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 8 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : UARTRXTX_e
    port map (m_clk_i           => m_clk_i_s,
              m_rst_i           => m_rst_i_s,
              m_baud_sel_i      => m_baud_sel_i_s,
              m_tx_data_i       => m_tx_data_i_s,
              m_tx_start_i      => m_tx_start_i_s,
              m_tx_data_ready_o => m_tx_data_ready_o_s,
              m_rx_i            => m_rx_i_s,
              m_tx_o            => m_tx_o_s,
              m_rx_data_ready_o => m_rx_data_ready_o_s,
              m_rx_data_o       => m_rx_data_o_s);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that m_clk_i is really your main clock signal
    m_clk_i_s <= TbClock;

stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        m_baud_sel_i_s <= '1';
        m_tx_data_i_s <= (others => '0');
        m_tx_start_i_s <= '0';
        m_rx_i_s <= '1';

        -- Reset generation
        --Testing TX at 115200baud
        m_rst_i_s <= '0';
        wait for 10 ns;
        ASSERT (m_tx_o_s = '1' and m_tx_data_ready_o_s = '0' and m_rx_data_ready_o_s  ='0' and m_rx_data_o_s  = "00000000") REPORT "RST not working" SEVERITY FAILURE;
        m_rst_i_s <= '1';
        wait for 10 ns;
        m_tx_data_i_s <= "01010101";
        wait for 10ns;
        m_tx_start_i_s <= '1';
        wait for 10*(1086*TbPeriod);
        m_tx_start_i_s <= '0';
        m_baud_sel_i_s <= '0';
        --Testing TX at 9600baud
        wait for 3*(12500*TbPeriod);
        m_tx_start_i_s <= '1';
        wait for 10*(13020*TbPeriod);
        m_tx_start_i_s <= '0';
        wait for 10ns;
        
        -- Testing RX at 115200baud
        
        m_rst_i_s <= '0';
        wait for 10 ns;
        m_rst_i_s <= '1';
        m_baud_sel_i_s <= '1';
        wait for 10 ns;
        m_rx_i_s <= '0';          --start bit
        wait for (1086*tbPeriod); --start bit
     
      loop1 : for k in 0 to 8 loop -- databits + stop bit
            m_rx_i_s <= not m_rx_i_s;
            wait for (1086*tbPeriod);
      end loop loop1;
      ASSERT (m_rx_data_o_s = "01010101") REPORT "RX DATA NOT CORRECT" SEVERITY FAILURE;
      
      -- Testing RX at 9600baud
      
      m_rx_i_s <= '1';
      m_rst_i_s <= '0';
      wait for 10 ns;
      m_rst_i_s <= '1';
      m_baud_sel_i_s <= '0';
      wait for 10 ns;
      m_rx_i_s <= '0'; --startbit
      wait for (13020*tbPeriod); --startbit
            loop2 : for k in 0 to 8 loop -- databits + stop bit
            m_rx_i_s <= not m_rx_i_s;
            wait for (13020*tbPeriod);
      end loop loop2;
      ASSERT (m_rx_data_o_s = "01010101") REPORT "RX DATA NOT CORRECT" SEVERITY FAILURE;
      m_rx_i_s <= '1';
      
      wait for 1000*tbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
end process;

end tb;