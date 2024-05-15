architecture UARTRXTX_a of UARTRXTX_e is

component pmTX_e is
 Port ( clk_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        baud_i : in  STD_LOGIC;
        tx_data_i : in  STD_LOGIC_VECTOR (7 downto 0);
        tx_data_start_i : in STD_LOGIC;
        tx_o : out  STD_LOGIC;
        tx_data_ready_o : out STD_LOGIC);
end component;

component pmBaudrategen_e is
      Port (
        rst_i : in STD_LOGIC;
        clk_i : in STD_LOGIC;
        baud_sel_i : in STD_LOGIC;
        baud_start_i : in STD_LOGIC;
        baud_2_o : out STD_LOGIC;
        baud_o : out STD_LOGIC
        );
end component;

component pmRX_e is
    Port ( baud_i : in STD_LOGIC;
           baud_2_i : in STD_LOGIC;
           rx_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           clk_i : in STD_LOGIC;
           start_br_cnt_o : out STD_LOGIC;
           rx_data_rdy_o : out STD_LOGIC;
           rx_fin_o : out STD_LOGIC;
           data_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal baud_s : STD_LOGIC;

signal tx_start_i_sig : STD_LOGIC;

signal baud_2_s : STD_LOGIC;
signal baudrate_reset_s : STD_LOGIC;

begin

BAUD : pmBaudrategen_e
PORT MAP(
    baud_o => baud_s,
    baud_2_o => baud_2_s,
    clk_i => m_clk_i,
    rst_i => m_rst_i,
    baud_sel_i => m_baud_sel_i,
    baud_start_i => baudrate_reset_s
    );

TX  : pmTX_e
PORT MAP(
    clk_i => m_clk_i,
    rst_i => m_rst_i,
    baud_i => baud_s,
    tx_data_i => m_tx_data_i,
    tx_data_start_i => m_tx_start_i,
    tx_o => m_tx_o,
    tx_data_ready_o => m_tx_data_ready_o
    );

RX : pmRX_e
PORT MAP(
   baud_i => baud_s,
   baud_2_i => baud_2_s,
   rx_i => m_rx_i,
   rst_i => m_rst_i,
   clk_i => m_clk_i,
   start_br_cnt_o =>baudrate_reset_s,
   rx_data_rdy_o => m_rx_data_ready_o,
   rx_fin_o => m_rx_fin_o,
   data_o => m_rx_data_o
   );


end UARTRXTX_a;
