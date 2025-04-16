library ieee;
use ieee.std_logic_1164.all;

entity Test is port (
 	a : in 	std_logic;
	b : out std_logic);
end Test;

architecture dataflow of Test is
begin
	b <= not a;
end dataflow;
