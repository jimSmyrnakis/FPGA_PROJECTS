----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2025 19:25:01
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port( 
        fsm_input : in std_logic_vector(7 downto 0);
        fsm_clk   : in std_logic; 
        
        -- current state and state input variables
        fsm_istate: in std_logic_vector(1 downto 0);
        fsm_iincr : in std_logic_vector(3 downto 0);
        fsm_imul  : in std_logic_vector(1 downto 0);
        
        -- output state and state output variables
        fsm_ostate: out std_logic_vector(1 downto 0);
        fsm_oincr : out std_logic_vector(3 downto 0);
        fsm_omul  : out std_logic_vector(1 downto 0);
        
        fsm_output: out std_logic_vector(7 downto 0)
       );
        
--  Port ( );
end FSM;

architecture Behavioral of FSM is

    component Subtruct1 is
    port ( 
        input : in std_logic_vector (4 downto 0);
        output: out std_logic_vector(4 downto 0));
    end component;
    
    component Add1 is
        port( 
        input :  in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0));
    end component;
    
    component Mul2AndClip is
    port(
        input: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0)
        );
    end component;
    
    signal new_incr : std_logic_vector(3 downto 0);
    signal new_mul  : std_logic_vector(1 downto 0);
    signal new_outplus1: std_logic_vector(7 downto 0);
    signal new_outMul2 : std_logic_vector(7 downto 0);
begin

    UTen   : Subtruct1 port map ( input => fsm_iincr , output => new_incr);
    UThree : Subtruct1 port map ( input => fsm_imul , output => new_mul);
    UADD1  : add1      port map ( input => fsm_input , output => new_outPlus1);
    MulClip1 : Mul2AndClip port map ( input => fsm_input , output => new_outMul2);
    process( fsm_clk)
    begin 
        if (fsm_clk'event and fsm_clk = '1') then
            case fsm_istate is
                when "00" => -- started point (nothing happens)
                    fsm_output <= fsm_input ; -- output is the input (for moment)
                    case fsm_input is
                        when "00000000" => -- then go to state 01(increment state) and set variables
                            fsm_ostate <= "01";
                            -- this goes to the increment state , so
                            fsm_oincr <= "1001"; -- wich in tenth element is gone be zero
                        when "11111111" => 
                            fsm_ostate <= "10"; -- then multyply state
                            fsm_omul <= "10"; -- becomes zero for the third element
                        when others     => -- then set this state
                            fsm_ostate <= "00";
                    end case;
                when "01" => -- a zero input has previusly found
                    
                   case fsm_iincr is
                        when "0000" => 
                            fsm_ostate <= "00";
                        when others =>
                            fsm_ostate <= "01";
                    end case;
                    
                    fsm_output <= new_outPlus1;
                when "10" => -- a 255 value has previusly found
                    fsm_omul <= new_mul;
                    case fsm_imul is
                        when "00" => -- if is time for multiply by 2
                            case fsm_input is
                                when "00000000" => -- if is zero next state is 01
                                    fsm_ostate <= "01";
                                when others => -- otherwise is 00
                                    fsm_ostate <= "00";
                            end case;
                            fsm_output <= new_outMul2;
                        when others => -- if still decriments
                            fsm_output <= fsm_input; -- output is input
                            fsm_ostate <= "10"; -- this state remains
                    end case;
                when others => -- in this situation make next circle to point to the start state
                    fsm_ostate <= "00";
                    fsm_output <= fsm_input;
            end case;
        end if;
    end process;

end Behavioral;
