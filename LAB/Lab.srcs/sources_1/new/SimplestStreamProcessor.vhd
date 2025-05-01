----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2025 13:39:23
-- Design Name: 
-- Module Name: SimplestStreamProcessor - Behavioral
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

entity SimplestStreamProcessor is
port (
    clk   : in  std_logic;
    input : in  std_logic_vector(7 downto 0);
    output: out std_logic_vector(7 downto 0));
end SimplestStreamProcessor;

architecture Behavioral of SimplestStreamProcessor is
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

    component FSMRegister is
        port( -- this register takes data in in first circle and output them in the next
            input : in  std_logic_vector(7 downto 0);
            output: out std_logic_vector(7 downto 0);
            clk   : in  std_logic);
    end component;
    
    
    signal output_register_input : std_logic_vector(7 downto 0);

    signal fsm_core_incr : std_logic_vector(3 downto 0);
    signal fsm_core_state: std_logic_vector(1 downto 0);
    signal fsm_core_mul  : std_logic_vector(1 downto 0);
begin
    
    OUTPUT_REGISTER: FSMRegister port map ( clk => clk , input => output_register_input , output => output);
    FSM_CORE       : FSM port map(
                fsm_clk => clk , -- make it work on negative edges
                fsm_input => input ,
                fsm_output => output_register_input,
                fsm_istate => fsm_core_state ,
                fsm_ostate => fsm_core_state ,
                fsm_iincr  => fsm_core_incr  ,
                fsm_oincr  => fsm_core_incr ,
                fsm_imul   => fsm_core_mul  ,
                fsm_omul   => fsm_core_mul  
    );
                

end Behavioral;
