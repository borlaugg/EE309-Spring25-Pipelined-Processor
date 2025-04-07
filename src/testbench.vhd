LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity testbench is 
end testbench;

architecture rtl of testbench is

-- Declaring component to test
	component proc is
		generic (
			 -- 16 bit data
			 RAM_WIDTH : integer := 16;
			 RAM_DEPTH : integer := 32
		  );
		port(
		 clk : in std_logic;
		 rst : in std_logic;
		 
		 -- Write to imem
		 wr_en_IMEM : in std_logic;
		 wr_data_IMEM : in std_logic_vector(RAM_WIDTH - 1 downto 0);
		 
		 -- Read from dmem
		 rd_en_DMEM : in std_logic;
		 rd_valid_DMEM : out std_logic;
		 rd_data_DMEM : out std_logic_vector(RAM_WIDTH - 1 downto 0)
		);
	end component;
	
	-- Signal Declarations
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal wr_en_IMEM : std_logic;
	signal wr_data_IMEM : std_logic_vector(15 downto 0);
	signal rd_en_DMEM : std_logic;
	signal rd_valid_DMEM : std_logic;
	signal rd_data_DMEM : std_logic_vector(15 downto 0);
	
	begin
	processor: proc port map(
		clk => clk,
		rst => rst,
		wr_en_IMEM => wr_en_IMEM,
		wr_data_IMEM => wr_data_IMEM,
		rd_en_DMEM => rd_en_DMEM,
		rd_valid_DMEM => rd_valid_DMEM,
		rd_data_DMEM => rd_data_DMEM
	);
	
	clk <= not clk after 2ns;
	rst <= '1', '0' after 5 ns;
	
	process begin
		wait for 100ns;
		
		wr_en_IMEM <= '1';
		wr_data_IMEM <= std_logic_vector((to_UNSIGNED(1234,16)));
		
		wait for 500ns;
		rd_en_DMEM <= '1';
		assert(to_integer(unsigned(rd_data_DMEM)) = 1234)
			report "wrong value"
			severity ERROR;
	end process;

end architecture;