library ieee;
use ieee.std_logic_1164.all;

entity fixedptALU is
	port( OperationSelect: in std_logic_vector(1 downto 0);
				 OperandA  : in std_logic_vector(3 downto 0);
				 OperandB  : in std_logic_vector(3 downto 0);
				 Gclock : in std_logic;
				 Greset : in std_logic;
				 MuxOut  : out std_logic_vector(7 downto 0);
				 CarryOut : out std_logic;
				 ZeroOut : out std_logic;
				 OverflowOut : out std_logic);

end fixedptALU;


architecture struct of fixedptALU is

	component adder_subtractor is
	port( addsub: in std_logic;
				 A,B  : in std_logic_vector(3 downto 0);
				 R  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);
	end component;

	component multiplier is
	port( 
				 A,B  : in std_logic_vector(3 downto 0);
				 P  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);

	end component;
	
	component divider is
	port( 
				 A,B  : in std_logic_vector(3 downto 0);
				 Q  : out std_logic_vector(7 downto 0);
				 R : out std_logic_vector(3 downto 0);
				 Cout, OVERFLOW : out std_logic);
	end component;
	
	
	
	signal addrez: std_logic_vector(7 downto 0);
	signal subrez: std_logic_vector(7 downto 0);
	signal multrez: std_logic_vector(7 downto 0);
	signal divrez: std_logic_vector(7 downto 0);
	signal divrezrem: std_logic_vector(3 downto 0);
	signal coutadd: std_logic;
	signal coutsub: std_logic;
	signal coutmult: std_logic;
	signal coutdiv: std_logic;
	signal overadd: std_logic;
	signal oversub: std_logic;
	signal overmult: std_logic;
	signal overdiv: std_logic;

	
begin


	addition: adder_subtractor port map ('0',OperandA, OperandB, addrez,coutadd, overadd);
	subtraction: adder_subtractor port map ('1',OperandA, OperandB, subrez,coutsub, oversub);
	multiplication: multiplier port map (OperandA, OperandB, multrez, coutmult, overmult);
	division: divider port map (OperandA, OperandB, divrez, divrezrem, coutdiv, overdiv); 

--results based on selected operation 
	process(OperationSelect,Greset,Gclock)
	begin
		--additon
		if OperationSelect = "00" then
			MuxOut <= addrez;
			CarryOut <= coutadd ;
			OverflowOut <= overadd;
			--check if the result is 0
			if OperandA = "0000" and OperandB = "0000" then
				ZeroOut <= '1';
			else	
				ZeroOut <='0';
			end if;
		end if;
		--subtraction
		if OperationSelect = "01" then
			MuxOut <= subrez;
			CarryOut <= coutsub ;
			OverflowOut <= oversub;
			--check if the result is 0
			if OperandA = OperandB then
				ZeroOut <= '1';
			else	
				ZeroOut <='0';
			end if;
		end if;
		--multiplication
		if OperationSelect = "10" then
			MuxOut <= multrez;
			CarryOut <= coutmult ;
			OverflowOut <= overmult;
			--check if the result is 0
			if OperandA = "0000" or OperandB = "0000" then
				ZeroOut <= '1';
			else	
				ZeroOut <='0';
			end if;
		end if;
		--division
		if OperationSelect = "11" then
			MuxOut(3 downto 0) <= divrez (3 downto 0);
			MuxOut(7 downto 4) <= divrezrem;
			CarryOut <= coutdiv ;
			OverflowOut <= overdiv;
			--check if the result is 0
			if OperandA = "0000" or OperandB = "0000" then
				zeroOut <= '1';
			else	
				ZeroOut <='0';
			end if;
		end if;
		--Greset
		if Greset = '1' then
			MuxOut(7 downto 0) <= "00000000";
		end if;

		
	end process;
	

	


	
	

end struct;