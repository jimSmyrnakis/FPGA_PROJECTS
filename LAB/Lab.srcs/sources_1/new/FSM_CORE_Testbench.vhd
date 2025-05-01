----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2025 19:03:25
-- Design Name: 
-- Module Name: FSM_CORE_Testbench - Behavioral
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

entity FSM_CORE_Testbench is
--  Port ( );
end FSM_CORE_Testbench;

architecture Behavioral of FSM_CORE_Testbench is
    component FSM is
        Port( 
        fsm_input : in std_logic_vector(7 downto 0);
        fsm_clk   : in std_logic; 
        
        -- current state and state input variables
        fsm_istate: in std_logic_vector(1 downto 0);
        fsm_iincr : in std_logic_vector(3 downto 0); -- counter πρως την 10-αδα (είσοδος )
        fsm_imul  : in std_logic_vector(1 downto 0); -- counter πρως την 3-αδα (είσοδος)
        
        -- output state and state output variables
        fsm_ostate: out std_logic_vector(1 downto 0);
        fsm_oincr : out std_logic_vector(3 downto 0);-- counter πρως την 10-αδα (εξοδος )
        fsm_omul  : out std_logic_vector(1 downto 0);-- counter πρως την 3-αδα (εξοδος)
        
        fsm_output: out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal internal_input : std_logic_vector(7 downto 0);
    signal internal_output: std_logic_vector(7 downto 0);
    signal internal_iincr : std_logic_vector(3 downto 0);
    signal internal_imul  : std_logic_vector(1 downto 0);
    signal internal_omul  : std_logic_vector(1 downto 0);
    signal internal_oincr : std_logic_vector(3 downto 0);
    signal internal_istate: std_logic_vector(1 downto 0);
    signal internal_ostate: std_logic_vector(1 downto 0);
    signal internal_clk   : std_logic := '0';
begin

    TEST1: FSM port map(
        fsm_input  => internal_input,
        fsm_output => internal_output,
        fsm_iincr  => internal_iincr ,
        fsm_imul   => internal_imul  ,
        fsm_istate => internal_istate,
        fsm_oincr  => internal_oincr ,
        fsm_omul   => internal_omul  ,
        fsm_ostate => internal_ostate,
        fsm_clk    => internal_clk
    );
    
    process 
        
    begin 
        -- check if the undefine istate make the next state 00 
        internal_clk <= '0'; -- clk set to zero 
        internal_input <= X"01"; -- set input
        wait for 5 ps; -- wait for 5ps
        internal_clk <= '1'; -- make a pulse 
        wait for 5 ps; -- wait for 5 ps then read output
        internal_clk <= '0';
        internal_istate <= internal_ostate; -- ostate must be 00 , take the output state as input state for the next circle
        internal_iincr  <= internal_oincr ; -- o incr could still be undefined 
        internal_imul   <= internal_omul  ; -- same for umul
        internal_input <= X"00"; -- make it increment the output (after this circle must have ostate 01 )
       
        wait for 5 ps;
        internal_clk <= '1'; -- make a pulse 
        wait for 5 ps;
        internal_clk <= '0'; -- now take output result
        internal_istate <= internal_ostate; -- must ostate be 01
        internal_iincr  <= internal_oincr ;
        internal_imul   <= internal_omul  ;
        
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
            internal_clk <= '0'; -- take the result and make it as input for the next pulse
            internal_istate <= internal_ostate;
            internal_iincr  <= internal_oincr ;
            internal_imul   <= internal_omul  ;
            
        end loop; -- after this loop ostate must again be 00
            
        internal_input <= X"FF"; -- make next circle to have ostate as 10 
        internal_clk <= '0';
        wait for 5 ps;
        internal_clk <= '1'; -- make a pulse
        wait for 5 ps;
        internal_clk <= '0';
        internal_istate <= internal_ostate; -- the ostate must be 10
        internal_iincr  <= internal_oincr ;
        internal_imul   <= internal_omul  ; -- omul must be 2
        
        
        for i2 in 0 to 2 loop
            
            internal_input <= std_logic_vector(to_unsigned(i2, 8));
            
            internal_clk <= '0';
            wait for 5 ps;
            internal_clk <= '1';
            wait for 5 ps;
            internal_clk <= '0';
            internal_istate <= internal_ostate;
            internal_iincr  <= internal_oincr ;
            internal_imul   <= internal_omul  ;
        end loop; -- after this ostate must again be 00 
        
        --now check if state 10 if the last input when imul = 0 is 0 then ostate must be 01
        internal_input <= X"FF"; -- make next circle to have ostate as 10 
        internal_clk <= '0';
        wait for 5 ps;
        internal_clk <= '1'; -- make a pulse
        wait for 5 ps;
        internal_clk <= '0';
        internal_istate <= internal_ostate; -- the ostate must be 10
        internal_iincr  <= internal_oincr ;
        internal_imul   <= internal_omul  ; -- omul must be 2
        
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
            internal_istate <= internal_ostate;
            internal_iincr  <= internal_oincr ;
            internal_imul   <= internal_omul  ;
        end loop; -- after this ostate must be 01
        
        for i4 in 0 to 9 loop
            
            internal_input <= std_logic_vector(to_unsigned(i4, 8)); --
            
            wait for 5 ps;
            internal_clk <= '1'; -- make a pulse
            wait for 5 ps;
            internal_clk <= '0'; -- take the result and make it as input for the next pulse
            internal_istate <= internal_ostate;
            internal_iincr  <= internal_oincr ;
            internal_imul   <= internal_omul  ;
            
        end loop; -- after this loop ostate must again be 00
        
        -- after that the next state must be 00 again
        
    end process;

end Behavioral;
