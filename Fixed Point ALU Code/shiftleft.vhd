library ieee;
use ieee.std_logic_1164.all;

entity shiftleft is
	port(
				 A  : in std_logic_vector(3 downto 0);
				 shiftedA  : out std_logic_vector(7 downto 0));
				 

end shiftleft;

architecture struct of shiftleft is

	signal output: std_logic_vector(7 downto 0);

begin

	output(0) <= '0';
	output(1) <= A(0);
	output(2) <= A(1);
	output(3) <= A(2);
	output(4) <= A(3);
	output(5) <= A(4);
	output(6) <= A(5);
	output(7) <= A(6);
	
	shiftedA <= output;
end struct;