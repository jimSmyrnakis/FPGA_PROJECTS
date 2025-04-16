library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	generic ( n : integer := 32);
	port (
		ALU_data1  : in  std_logic_vector(n-1 downto 0);
		ALU_data2  : in  std_logic_vector(n-1 downto 0);
		ALU_opcode : in  std_logic_vector(2 downto 0);
		-- 000 = data1 + data2
		-- 001 = data1 - data2
		-- 010 = data1 and  data2
		-- 011 = data1 or   data2
		-- 100 = data1 xor  data2
		-- 101 = data1 nand data2
		-- 110 = data1 nor  data2
		-- 111 = data1 xnor data2
		ALU_result : out std_logic_vector(n-1 downto 0);
		ALU_sign   : out std_logic;
		ALU_zero   : out std_logic;
		ALU_cout   : out std_logic;
		ALU_overflow: out std_logic);
end ALU;

architecture Behavional of ALU is

	-- Components
	component INTEGER_UNIT is 
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
	end component;

	-- signals
	signal int_unit_res , and_res , or_res , xor_res : std_logic_vector(n-1 downto 0);

begin 

		with ALU_opcode select
		ALU_result <= and_res      when "010" ,
			      or_res       when "011" ,
			      xor_res      when "100" ,
			      not and_res  when "101" ,
			      not or_res   when "110" ,
			      not xor_res  when "111" ,
			      int_unit_res when others;

	INT_UNIT1 : INTEGER_UNIT generic map ( n => n ) port map (
			int1 => ALU_data1 , int2=> ALU_data2 , opcode => ALU_opcode(0) ,
			sign => ALU_sign  , overflow => ALU_overflow , zero => ALU_zero ,
			sum => int_unit_res , cout => ALU_cout );
	and_res <= ALU_data1 and ALU_data2;
	or_res  <= ALU_data1 or  ALU_data2;
	xor_res <= ALU_data1 xor ALU_data2;
end Behavional;





