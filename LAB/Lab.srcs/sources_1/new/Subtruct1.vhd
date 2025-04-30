----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2025 20:36:45
-- Design Name: 
-- Module Name: Subtruct1 - Behavioral
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

entity Subtruct1 is
generic (
     n : integer := 4 );
port ( 
        input : in std_logic_vector(n - 1 downto 0);
        output: out std_logic_vector(n - 1 downto 0));
end Subtruct1;

architecture Behavioral of Subtruct1 is
    signal Borrow : std_logic_vector(n downto 0) := (others => '0');
    signal Difference : std_logic_vector(n - 1 downto 0);
    signal OneNum     : std_logic_vector(n - 1 downto 0) := (others => '0');
begin
    
    OneNum(0) <= '1';
    --D = A XOR B XOR Bin
    --Bout = (¬A ∧ B) ∨ (B ∧ Bin) ∨ (¬A ∧ Bin)
    gen_label: for i in 0 to n - 1 generate
    begin
        Borrow(i + 1) <=  (not input(i) and OneNum(i)) or (OneNum(i) and Borrow(i)) or (not input(i) and Borrow(i));
        Difference(i) <= input(i) xor OneNum(i) xor Borrow(i);
    end generate;
    
    output <= Difference;
end Behavioral;
