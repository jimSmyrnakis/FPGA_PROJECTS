library ieee;
use ieee.std_logic_1164.all;

entity synchronus_alu is 
generic ( n : integer := 8 );
port ( 
	data1 : in  std_logic_vector(n-1 downto 0);
	data2 : in  std_logic_vector(n-1 downto 0);
	result: out std_logic_vector(n-1 downto 0);
	opcode: in  std_logic_vector(2   downto 0);
	sign  : out std_logic;
	ovrf  : out std_logic;
	zero  : out std_logic;
	cout  : out std_logic;
	clk   : in  std_logic);
end synchronus_alu;

architecture Behavional of synchronus_alu is
	-- components  
component ALU is
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
end component ;

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

	-- signals
	signal data1_internal , data2_internal , result_internal : std_logic_vector(n-1 downto 0);
	signal opcode_internal : std_logic_vector ( 2 downto 0);
	signal sign_internal , ovrf_internal , zero_internal , cout_internal : std_logic ;
	signal flags_internal : std_logic_vector(3 downto 0);
	signal flags_out : std_logic_vector( 3 downto 0);

begin

	REG1_data1 : DRegister generic map (n => n) port map (
		clk => clk , rw => '1' , rst => '0' , data_in => data1 , data_out => data1_internal );
	REG1_data2 : DRegister generic map (n => n) port map (
		clk => clk , rw => '1' , rst => '0' , data_in => data2 , data_out => data2_internal );
	REG1_opcode: DRegister generic map ( n => 3) port map (
		clk => clk , rw => '1' , rst => '0' , data_in => opcode , data_out => opcode_internal);
	REG2_Result: DRegister generic map ( n => n ) port map (
		clk => clk , rw => '1' , rst => '0' , data_in => result_internal , data_out => result);
	flags_internal <= sign_internal & ovrf_internal & zero_internal & cout_internal;
	REG2_flags : DRegister generic map ( n => 4 ) port map (
		clk => clk , rw => '1' , rst => '0' , 
		data_in => flags_internal , 
		data_out => flags_out );
	sign <= flags_out(0);
	ovrf <= flags_out(1);
	zero <= flags_out(2);
	cout <= flags_out(3);
	MAIN_ALU   : ALU generic map (n => n) port map(
		ALU_data1 => data1_internal , ALU_data2 => data2_internal , ALU_result => result_internal ,
		ALU_opcode => opcode_internal ,
		ALU_sign => flags_internal(0) , ALU_overflow => flags_internal(1) , ALU_zero => flags_internal(2) ,
		ALU_cout => flags_internal(3) );



end Behavional;