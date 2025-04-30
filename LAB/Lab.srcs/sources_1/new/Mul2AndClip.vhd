----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2025 20:52:21
-- Design Name: 
-- Module Name: Mul2AndClip - Behavioral
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

entity Mul2AndClip is
port(
    input: in std_logic_vector(7 downto 0);
    output: out std_logic_vector(7 downto 0));
end Mul2AndClip;

architecture Behavioral of Mul2AndClip is 
    signal Carry : std_logic_vector(8 downto 0) := "000000000";
    signal Summary : std_logic_vector(7 downto 0);
begin
    
    --Cᵢ₊₁ = (Aᵢ AND Bᵢ) OR (Aᵢ AND Cᵢ) OR (Bᵢ AND Cᵢ)
    -- if A= B
    -- Ci+1 = A or (A and Ci) => (A or A) and (A or Ci) => Ci+1 =A and ( A or Ci)
    gen_label: for i in 0 to 7 generate
    begin
        Carry(i + 1) <= input(i) and (  input(i) or Carry(i));
        -- S = A xor B xor Ci so if A = B => A xor B = 0 so S = 0 xor Ci so S = Ci
        Summary(i) <= Carry(i);
    end generate;
    
    process (input , Summary , Carry)
    begin 
        if (input(7) = '1') then
            output <= "11111111";
        else
            output <= Summary;
        end if;
    end process;
end Behavioral;
