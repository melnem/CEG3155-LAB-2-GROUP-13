library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity comparator is
	port( 
				 A,B  : in std_logic_vector(3 downto 0);
				 trueorfalse : out std_logic); -- 1 = true (R>=B), 0 = false (R!>=B)

end comparator;


architecture struct of comparator is



begin

	process(A,B)
	begin 
	if A>=B then
		trueorfalse <= '1';
	else	
		trueorfalse <= '0';
	end if;
	
	end process;

end struct;