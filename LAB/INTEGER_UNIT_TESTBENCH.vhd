library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 



entity INTEGER_UNIT_TESTBENCH is 
generic ( test_n : natural := 4); -- Small Number of bits for testing every possible scenario of the integer
--unit
end INTEGER_UNIT_TESTBENCH;



architecture Behavoral of INTEGER_UNIT_TESTBENCH is 

	component INTEGER_UNIT 
	generic ( 
		n : natural := 32);
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

	signal int1_in    : std_logic_vector(test_n-1 downto 0) := (others => '0');
	signal int2_in 	  : std_logic_vector(test_n-1 downto 0) := (others => '0');
	signal opcode_in  : std_logic := '0';
	signal zero_out , sign_out , overflow_out , cout_out : std_logic;
	signal sum_out    : std_logic_vector(test_n-1 downto 0) := (others => '0'); 
	signal test_result: std_logic_vector(test_n-1 downto 0) := (others => '0');

begin

	process
		variable number1 : integer := 0;
		variable number2 : integer := 0;
		variable result  : integer := 0;
		variable check   : integer := 0;
		variable do_sum  : boolean := true;
		variable pass    : boolean := true;
	begin 
		
		for i in 0 to power(2 , test_n) - 1 loop 
			for j in 0 to power(2 , test_n) - 1 loop 
				number1 := i;
				number2 := j;

				result := number1 + number2;
				opcode_in <= '0';
				int1_in <= std_logic_vector(to_unsigned(number1,test_n));
				int2_in <= std_logic_vector(to_unsigned(number2,test_n));
				check := to_integer(unsigned(sum_out));
				if (!(check = result)) then
					pass = false;
					assert(pass = true ) report "Failed !!!" severity error;
				end if;
				wait for 100 ps;

				result := number1 - number2;
				opcode_in <= '0';
				int1_in <= std_logic_vector(to_unsigned(number1,test_n));
				int2_in <= std_logic_vector(to_unsigned(number2,test_n));
				check := to_integer(unsigned(sum_out));
				if (check != result) then
					pass = false;
					assert(pass = true ) report "Failed !!!" severity error;
				end if;
				wait for 100 ps;
				
			end loop;
		end loop;

		assert ( pass = true ) report "Failed !!!" severity error;
		if (pass = true) then
			report "Pass !!!";
		end if;
		
	end process;

	INT_UNIT1: INTEGER_UNIT generic map ( n => test_n ) port map (
		int1 => int1_in , int2 => int2_in , opcode => opcode_in , zero => zero_out ,
		overflow => overflow_out , sign => sign_out , cout => cout_out , sum => sum_out );

end Behavoral;
