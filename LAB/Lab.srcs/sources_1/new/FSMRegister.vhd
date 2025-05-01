----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2025 13:51:38
-- Design Name: 
-- Module Name: FSMRegister - Behavioral
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

entity FSMRegister is
port( -- this register takes data in in first circle and output them in the next
    input : in  std_logic_vector(7 downto 0);
    output: out std_logic_vector(7 downto 0);
    clk   : in  std_logic);
end FSMRegister;

architecture Behavioral of FSMRegister is
    signal internal_data : std_logic_vector(7 downto 0) := X"01"; -- initial value is 1 so the fsm will not go to the increment state 
begin

    process(clk)
    begin 
        if (clk'event and clk='1') then
             -- first output previus value
            --then change internal data
            internal_data <= input;
            output <= internal_data;
        end if;
    end process;

end Behavioral;
