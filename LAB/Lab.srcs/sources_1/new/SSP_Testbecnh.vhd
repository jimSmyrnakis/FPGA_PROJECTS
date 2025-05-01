----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2025 14:29:18
-- Design Name: 
-- Module Name: SSP_Testbecnh - Behavioral
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

entity SSP_Testbecnh is
--  Port ( );
end SSP_Testbecnh;

architecture Behavioral of SSP_Testbecnh is
component SimplestStreamProcessor is
port (
    clk   : in  std_logic;
    input : in  std_logic_vector(7 downto 0);
    output: out std_logic_vector(7 downto 0));
end component;

    signal internal_clk : std_logic := '0';
    signal internal_input: std_logic_vector(7 downto 0) := X"01";
    signal internal_output: std_logic_vector(7 downto 0);
begin

    TEST1: SimplestStreamProcessor port map (
        input => internal_input ,
        clk => internal_clk ,
        output => internal_output );

    process 
    begin 
        -- check if the undefine istate make the next state 00 
        internal_clk <= '0'; -- clk set to zero 
        internal_input <= X"01"; -- set input
        wait for 5 ps; -- wait for 5ps
        internal_clk <= '1'; -- make a pulse 
        wait for 5 ps; -- wait for 5 ps then read output
        internal_clk <= '0';
        internal_input <= X"00"; -- make it increment the output (after this circle must have ostate 01 )
       
        wait for 5 ps;
        internal_clk <= '1'; -- make a pulse 
        wait for 5 ps;
        internal_clk <= '0';
        
        -- for increment the output and test that doeasn't listen anything else (X"FFFF" must not listened)
        for i1 in 0 to 9 loop
            if (i1 = 5 ) then 
                internal_input <= X"FF"; -- this must not effect this state 
            else 
                internal_input <= std_logic_vector(to_unsigned(i1, 8)); -- 
            end if;
            
            wait for 5 ps;
            internal_clk <= '1'; -- make a pulse
            wait for 5 ps;
            internal_clk <= '0'; 
            
        end loop; -- after this loop ostate must again be 00
            
        internal_input <= X"FF"; -- make next circle to have ostate as 10 
        internal_clk <= '0';
        wait for 5 ps;
        internal_clk <= '1'; -- make a pulse
        wait for 5 ps;
        internal_clk <= '0';
        
        
        for i2 in 0 to 2 loop
            
            internal_input <= std_logic_vector(to_unsigned(i2, 8));
            
            internal_clk <= '0';
            wait for 5 ps;
            internal_clk <= '1';
            wait for 5 ps;
            internal_clk <= '0';
        end loop; -- after this ostate must again be 00 
        
        --now check if state 10 if the last input when imul = 0 is 0 then ostate must be 01
        internal_input <= X"FF"; -- make next circle to have ostate as 10 
        internal_clk <= '0';
        wait for 5 ps;
        internal_clk <= '1'; -- make a pulse
        wait for 5 ps;
        internal_clk <= '0';
        
        for i3 in 0 to 2 loop
            
            if ( i3 = 2 ) then 
                internal_input <= X"00"; -- this must force next state to 01
            else
                internal_input <= std_logic_vector(to_unsigned(i3, 8));
            end if;
            
            internal_clk <= '0';
            wait for 5 ps;
            internal_clk <= '1';
            wait for 5 ps;
            internal_clk <= '0';
        end loop; -- after this ostate must be 01
        
        for i4 in 0 to 9 loop
            
            internal_input <= std_logic_vector(to_unsigned(i4, 8)); --
            
            wait for 5 ps;
            internal_clk <= '1'; -- make a pulse
            wait for 5 ps;
            internal_clk <= '0'; 
            
        end loop; -- after this loop ostate must again be 00
    end process;

end Behavioral;
