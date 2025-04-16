library ieee;
use ieee.std_logic_1164.all;

entity Alu_Testbench is
generic ( n: integer := 32 );
end Alu_Testbench;

architecture Behavonal of Alu_Testbench is
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
	end component;

	--signal 
	signal internal_data1 , internal_data2 , internal_result : std_logic_vector(n-1 downto 0);
	signal internal_sign , internal_cout , internal_zero , internal_overflow : std_logic;
	signal internal_opcode : std_logic_vector(2 downto 0);


begin

	process 
	begin
		-- sum
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '0');
		internal_opcode <= "000";
		wait for 100 ps;
		-- sub
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '1');
		internal_opcode <= "001";
		wait for 100 ps;
		-- and
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '1');
		internal_data2(0) <= '0';
		internal_opcode <= "010";
		wait for 100 ps;
		-- or
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '0');
		internal_opcode <= "011";
		wait for 100 ps;
		-- xor
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '0');
		internal_opcode <= "100";
		wait for 100 ps;
		-- nand
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '0');
		internal_opcode <= "101";
		wait for 100 ps;
		-- nor
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '0');
		internal_opcode <= "110";
		wait for 100 ps;
		-- xnor
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '0');
		internal_opcode <= "111";
		wait for 100 ps;
		-- not
		internal_data1 <= (others => '1');
		internal_data2 <= (others => '1');
		internal_data2(0) <= '0';
		internal_opcode <= "100";
		wait for 100 ps;

	end process;

	ALU1 : ALU generic map ( n => n) port map (
		ALU_data1 => internal_data1 , ALU_data2 => internal_data2 , ALU_result => internal_result ,
		ALU_sign => internal_sign , ALU_opcode => internal_opcode , ALU_cout => internal_cout ,
		ALU_zero => internal_zero , ALU_overflow => internal_overflow );


end Behavonal;







