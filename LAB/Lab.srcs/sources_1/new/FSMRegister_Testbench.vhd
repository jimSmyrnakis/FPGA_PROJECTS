----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2025 13:58:17
-- Design Name: 
-- Module Name: FSMRegister_Testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSMRegister_Testbench is
--  Port ( );
end FSMRegister_Testbench;

architecture Behavioral of FSMRegister_Testbench is
    component FSMRegister is
        port( -- this register takes data in in first circle and output them in the next
            input : in  std_logic_vector(7 downto 0);
            output: out std_logic_vector(7 downto 0);
            clk   : in  std_logic);
    end component;
    signal internal_input : std_logic_vector(7 downto 0) := X"00";
    signal internal_output: std_logic_vector(7 downto 0) ;
    signal internal_clk   : std_logic := '0';
begin

    TEST1: FSMRegister port map ( input => internal_input , output => internal_output , clk => internal_clk );

    process
    begin
        for i in 0 to 255 loop 
            internal_clk <= '0'; -- set clock to zero
            internal_input <= std_logic_vector(to_unsigned(i, 8)); -- input data
            wait for 5 ps; -- wait for 5 ps
            internal_clk <= '1';-- make a pulse 
            wait for 5 ps; -- wait again before you change the output
        end loop;
    end process;

end Behavioral;
