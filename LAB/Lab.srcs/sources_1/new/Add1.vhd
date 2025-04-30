----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2025 20:44:31
-- Design Name: 
-- Module Name: Add1 - Behavioral
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

entity Add1 is
    port( 
    input :  in std_logic_vector(7 downto 0);
    output: out std_logic_vector(7 downto 0));
end Add1;

architecture Behavioral of Add1 is
    signal Carry : std_logic_vector(8 downto 0) := "000000001";
    signal Summary : std_logic_vector(7 downto 0);
begin
    
    
    gen_label: for i in 0 to 7 generate
    begin
        Carry(i + 1) <=   Carry(i) and input(i);
        Summary(i) <= input(i) xor Carry(i);
    end generate;
    
    output <= Summary;
end Behavioral;
