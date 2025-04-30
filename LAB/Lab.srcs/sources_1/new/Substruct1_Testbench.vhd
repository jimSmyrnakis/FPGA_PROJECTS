----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2025 12:32:41
-- Design Name: 
-- Module Name: Substruct1_Testbench - Behavioral
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

entity Substruct1_Testbench is
--  Port ( );
end Substruct1_Testbench;

architecture Behavioral of Substruct1_Testbench is
    component Subtruct1 is
    port ( 
            input : in std_logic_vector(3 downto 0);
            output: out std_logic_vector(3 downto 0));
    end component;
    
    signal Substruct1_input : std_logic_vector(3 downto 0):= "1111";
    signal Substruct1_output: std_logic_vector(3 downto 0):= "0000";
begin

    process
    begin 
        wait for 10 ps;
        Substruct1_input <= Substruct1_output;
    end process;

    TEST: Subtruct1 port map ( input => Substruct1_input , output => Substruct1_output);

end Behavioral;
