library ieee;
use ieee.std_logic_1164.all;

entity adder_subtractor is
	port( addsub: in std_logic; --when = 0 -> addition, when =1 -> subtraction
				 A,B  : in std_logic_vector(3 downto 0);
				 R  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);

end adder_subtractor;


architecture struct of adder_subtractor is
	component fulladder is
	  port( A, B, Cin : in std_logic;
			  sum, Cout : out std_logic);
	end component;
	signal c: std_logic_vector(4 downto 0);
	signal yt: std_logic_vector(3 downto 0);
-- 
begin
	c(0) <= addsub;
	Cout <= c(4);
	OVERFLOW <= c(3) XOR c(4) ;
	
-- for 4 bits	
	yt(0) <= B(0) xor addsub; 
	yt(1) <= B(1) xor addsub;
	yt(2) <= B(2) xor addsub; 
	yt(3) <= B(3) xor addsub;
	
	f0:fulladder port map(A(0),yt(0),c(0), R(0),c(1)); 
	f1:fulladder port map(A(1),yt(1),c(1), R(1),c(2)); 
	f2:fulladder port map(A(2),yt(2),c(2), R(2),c(3)); 
	f3:fulladder port map(A(3),yt(3),c(3), R(3),c(4)); 



end struct;
