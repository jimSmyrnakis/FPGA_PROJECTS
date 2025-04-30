----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2025 13:13:14
-- Design Name: 
-- Module Name: Mul2AndClip_Testbench - Behavioral
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

entity Mul2AndClip_Testbench is
--  Port ( );
end Mul2AndClip_Testbench;

architecture Behavioral of Mul2AndClip_Testbench is
    component Mul2AndClip is
    port(
        input: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0));
    end component;
    
    signal Mul2AndClip_input : std_logic_vector(7 downto 0) := "00000001";
    signal Mul2AndClip_output: std_logic_vector(7 downto 0);
begin
    TEST1 : Mul2AndClip port map (input => Mul2AndClip_input , output => Mul2AndClip_output);
    
    process
    begin 
        wait for 10 ps;
        Mul2AndClip_input <= Mul2AndClip_output;
    end process;
end Behavioral;
