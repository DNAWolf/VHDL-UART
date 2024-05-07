architecture UARTRXTX_a of UARTRXTX_e is

component pmTX_e is
 Port ( clk_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        baud_i : in  STD_LOGIC;
        tx_data_i : in  STD_LOGIC_VECTOR (7 downto 0);
        tx_data_start_i : in STD_LOGIC;
        tx_o : out  STD_LOGIC);
end component;

component pmBaudrategen_e is
      Port (
        rst_i : in STD_LOGIC;
        clk_i : in STD_LOGIC;
        baud_sel_i : in STD_LOGIC;
        baud_o : out STD_LOGIC
        );
end component;


signal baudrate : STD_LOGIC;
signal tx_o_sig : STD_LOGIC;
signal tx_start_i_sig : STD_LOGIC;


begin

tx_start_i_sig <= m_tx_start_i;

BAUD : pmBaudrategen_e
PORT MAP(
    baud_o => baudrate,
    clk_i => m_clk_i,
    rst_i => m_rst_i,
    baud_sel_i => m_baud_sel_i
    );

TX  : pmTX_e
PORT MAP(
    clk_i => m_clk_i,
    rst_i => m_rst_i,
    baud_i => baudrate,
    tx_data_i => m_tx_data_i,
    tx_data_start_i => tx_start_i_sig,
    tx_o => tx_o_sig
    );

m_tx_o <= tx_o_sig;

end UARTRXTX_a;
