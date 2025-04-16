library ieee;

use ieee.std_logic_1164.all;

entity DRegister is 
	generic (
		n : integer := 8);
	port (
		data_in : in  std_logic_vector(n-1 downto 0);
		data_out: out std_logic_vector(n-1 downto 0);
		rw  	: in  std_logic; -- 1 => for write
		clk	: in  std_logic;
		rst	: in  std_logic);
end DRegister;

architecture Behavional of DRegister is 
	signal internal_data : std_logic_vector(n-1 downto 0) := (others => '0');

begin

	process(clk)
	begin
		if (clk'event and clk='1') then
			if (rst='1') then
				internal_data <= (others => '0');
			elsif (rw = '1') then
				internal_data <= data_in;
			end if;
		end if;
	end process;

	data_out <= internal_data;
	

end Behavional;

				
