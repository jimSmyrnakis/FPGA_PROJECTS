----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2025 13:42:29
-- Design Name: 
-- Module Name: Add1_Testbench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Add1_Testbench is
--  Port ( );
end Add1_Testbench;

architecture Behavioral of Add1_Testbench is
    component Add1 is
        port( 
        input :  in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0));
    end component;
    
    signal Add1_input : std_logic_vector(7 downto 0) := "00000000";
    signal Add1_output: std_logic_vector(7 downto 0);
begin
    TEST1: Add1 port map(input => Add1_input , output => Add1_output);
    
    process
    begin
        wait for 10 ps;
        Add1_input <= Add1_output;
    end process;

end Behavioral;
