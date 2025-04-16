library ieee;
use ieee.std_logic_1164.all;


entity DRegister_Testbench is
end DRegister_Testbench;

architecture TestBench of DRegister_Testbench is
	component DRegister is 
	generic (
		n : integer := 8);
	port (
		data_in : in  std_logic_vector(n-1 downto 0);
		data_out: out std_logic_vector(n-1 downto 0);
		rw  	: in  std_logic; -- 1 => for write
		clk	: in  std_logic;
		rst	: in  std_logic);
	end component;

	signal data_in_test , data_out_test : std_logic_vector(7 downto 0);
	signal rw_test , rst_test , clk_test : std_logic ;

begin

	process 
	begin 
		rst_test <= '0';
		rw_test <= '1';
		data_in_test <= "00000101";
		clk_test <= '0';
		wait for 50 ps;
		clk_test <= '1';
		wait for 50 ps;
		data_in_test <= "01010000";
		clk_test <= '0';
		wait for 50 ps;
		clk_test <= '1';
		wait for 50 ps;

		rw_test <= '0';
		data_in_test <= "11111111";
		clk_test <= '0';
		wait for 50 ps;
		clk_test <= '1';
		wait for 50 ps;
		rst_test <= '1';
		data_in_test <= "11110000";
		clk_test <= '0';
		wait for 50 ps;
		clk_test <= '1';
		wait for 50 ps;
		
	end process;

	DR1: DRegister generic map ( n => 8) port map (
		data_in => data_in_test , data_out => data_out_test , rw => rw_test , clk => clk_test , rst => rst_test );


end TestBench;
