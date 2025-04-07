library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity proc is
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
end proc;

architecture rtl of proc is
	-- Signals connecting the different pipeline stages
	
	-- Dummy signals to copy entries from IMEM to DMEM
	signal rd_en_IMEM : std_logic;
	signal rd_valid_IMEM : std_logic;
	signal data : std_logic_vector(RAM_WIDTH - 1 downto 0);
	
	signal wr_en_DMEM : std_logic;
	
	-- Components of the processor
	---- 1. Ring buffer that will be our DMEM and IMEM
	component ring_buffer is
	  generic (
		 -- 16 bit data
		 RAM_WIDTH : integer := 16;
		 RAM_DEPTH : integer := 32
	  );
	  port (
		 clk : in std_logic;
		 rst : in std_logic;
	  
		 -- Write port
		 wr_en : in std_logic;
		 wr_data : in std_logic_vector(RAM_WIDTH - 1 downto 0);
	  
		 -- Read port
		 rd_en : in std_logic;
		 rd_valid : out std_logic;
		 rd_data : out std_logic_vector(RAM_WIDTH - 1 downto 0);
	  
		 -- Flags
		 empty : out std_logic;
		 empty_next : out std_logic;
		 full : out std_logic;
		 full_next : out std_logic;
	  
		 -- The number of elements in the FIFO
		 fill_count : out integer range RAM_DEPTH - 1 downto 0
	  );
	end component;
	---- 2. Fetch stage
	---- 3. And so on
	
	begin
	rd_en_IMEM <= '1';
	wr_en_DMEM <= '1';
	
	IMEM: ring_buffer
			port map(
				clk => clk,
				rst => rst,
				wr_en => wr_en_IMEM,
				wr_data => wr_data_IMEM,
				rd_en => rd_en_IMEM,
				rd_valid => rd_valid_IMEM,
				rd_data => data,
				empty => open,
				empty_next => open,
				full => open,
				full_next => open,
				fill_count => open	
			);
			
	DMEM: ring_buffer
		port map(
			clk => clk,
			rst => rst,
			wr_en => wr_en_DMEM,
			wr_data => data,
			rd_en => rd_en_DMEM,
			rd_valid => rd_valid_DMEM,
			rd_data => rd_data_DMEM,
			empty => open,
			empty_next => open,
			full => open,
			full_next => open,
			fill_count => open
		);
		
	
end architecture;
