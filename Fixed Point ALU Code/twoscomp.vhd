library ieee;
use ieee.std_logic_1164.all;

entity twoscomp is
	port( 
				 A  : in std_logic_vector(3 downto 0);
				 twosA  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);

end twoscomp;

architecture struct of twoscomp is
 signal temp : std_logic_vector(3 downto 0);
 signal one : std_logic_vector(3 downto 0);
 
 	component adder_subtractor is
	port( addsub: in std_logic;
				 A,B  : in std_logic_vector(3 downto 0);
				 R  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);
	end component;
 
 
 
begin
	temp <= not A;
	one (0) <= '1';
	one (1) <= '0';
	one (2) <= '0';
	one (3) <= '0';
	
	try:adder_subtractor port map('0',temp,one,twosA,Cout,OVERFLOW);
	
	
end struct;