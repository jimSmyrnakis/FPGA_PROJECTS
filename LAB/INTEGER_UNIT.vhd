library ieee;
use ieee.std_logic_1164.all;

entity INTEGER_UNIT is 
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
end INTEGER_UNIT;

architecture Behavonal of INTEGER_UNIT is
	signal carry_chain : std_logic_vector(n downto 0);
	-- carry_chain bit zero is cin where bit n is cout
	-- if opcode is 0 then cin is zero , if opcode is 1
	-- then cin is 1 for (~int2 + 1).
	signal int2_internal: std_logic_vector(n-1 downto 0);
	-- if opcode is zero then is egual to int2 otherwise
	-- is equal to not int2 . I didn't know how to name it
	-- so i give the internal suffix 
	signal sum_internal: std_logic_vector(n-1 downto 0) ;
	signal AXORB_internal: std_logic_vector(n-1 downto 0);
begin
	AXORB_internal <= int1 xor int2_internal;
    
	int2_internal <= int2 when opcode='0' else (not int2); -- 
	carry_chain(0) <= opcode;
	gen_sum_chain: for i in 0 to n-1 generate 
	begin
		sum_internal(i) <= AXORB_internal(i) xor carry_chain(i);
	end generate;

	gen_carry_chain:for i in 1 to n generate
	begin 
		carry_chain(i) <= ( AXORB_internal(i - 1) and carry_chain(i-1) ) or (int1(i - 1) and int2_internal(i - 1));
	end generate;

	cout <= carry_chain(n);
	zero <= '1' when (sum_internal = (sum_internal'range => '0')) else '0';
	overflow <= carry_chain(n) xor carry_chain(n-1);
	sign <= sum_internal(n-1);
	sum <= sum_internal;

end Behavonal;
	

	










  
