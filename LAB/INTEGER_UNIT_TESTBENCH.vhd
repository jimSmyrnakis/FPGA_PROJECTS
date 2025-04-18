library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 



entity INTEGER_UNIT_TESTBENCH is 
end INTEGER_UNIT_TESTBENCH;



architecture Behavoral of INTEGER_UNIT_TESTBENCH is 

	component INTEGER_UNIT 
	generic ( 
		n : natural := 3);
	port (
		int1 	: in  std_logic_vector(n-1 downto 0);
		int2 	: in  std_logic_vector(n-1 downto 0);
		opcode	: in  std_logic;
		--0 -> add the number in complement 2 
		--1 -> subtruct int1 - int2 = int1 + (-int2)
		sign   	: out std_logic;
		overflow: out std_logic;
		zero	: out std_logic;
		sum	: out std_logic_vector(n-1 downto 0);
		cout	: out std_logic);
	end component INTEGER_UNIT;

	--testing ?? ????? ?????? bits (3 bit) ???? ?????? ??? +3 ??? -3 ?? ?????????? ???? 2
	--???? ?? ???????? ?? ????????? ???? ??? ??????�????? .

	signal int1_in    : std_logic_vector(2 downto 0) := (others => '0');
	signal int2_in 	  : std_logic_vector(2 downto 0) := (others => '0');
	signal opcode_in  : std_logic := '0';
	signal zero_out , sign_out , overflow_out , cout_out : std_logic;
	signal sum_out    : std_logic_vector(2 downto 0) := (others => '0'); 
	signal test_result: std_logic_vector(2 downto 0) := (others => '0');

begin

	process
		variable integ1 : integer := 0;
		variable integ2 : integer := 0;
		
	begin 
		int1_in <= "000";
		int2_in <= "000";
		opcode_in <= '0'; -- add
		wait for 100 ps;

		int1_in <= "001";
		for i in 0 to 7 loop
			integ1 := i;
			for j in 0 to 7 loop
				integ2 := j;
				opcode_in <= '0'; -- add
				int1_in <= std_logic_vector(to_unsigned(integ1, 3));
				int2_in <= std_logic_vector(to_unsigned(integ2, 3));
				wait for 100 ps;
				opcode_in <= '1'; -- sub
				wait for 100 ps;
			end loop;
		end loop;
		
		
	end process;

	INT_UNIT1: INTEGER_UNIT generic map ( n => 3 ) port map (
		int1 => int1_in , int2 => int2_in , opcode => opcode_in , zero => zero_out ,
		overflow => overflow_out , sign => sign_out , cout => cout_out , sum => sum_out );

end Behavoral;
