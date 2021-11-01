library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith;

entity multiplier is
	port( 
				 A,B  : in std_logic_vector(3 downto 0);
				 P  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);

end multiplier;

architecture struct of multiplier is

	component shiftleft is
	port( A  : in std_logic_vector(3 downto 0);
				 shiftedA  : out std_logic_vector(7 downto 0));
	end component;

	component adder_subtractor is
	port( addsub: in std_logic;
				 A,B  : in std_logic_vector(3 downto 0);
				 R  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);
	end component;
	component twoscomp is
		port( A  : in std_logic_vector(3 downto 0);
				 twosA  : out std_logic_vector(7 downto 0);
				 Cout, OVERFLOW : out std_logic);
	end component;
	
	

	
begin

--algorithm using our components (structural)
-- 2's complement of A nd B

	--if A is negative
		--CALL COMPONENT twoscomp for (A, A, Cout, Overflow)
	--if B is negative
		--CALL COMPONENT twoscomp for (B, B, Cout, Overflow)

--multiplication
	--P = 0
	--for loop 0 to n-1 
		--if B[i] = 1 then 
				--do P = P + A  : CALL COMPONENT Adder_subtractor for ('0',P,A,P,Cout,OVERFLOW)
		--end if
		--left shift A : CALL COMPONENT shift_left for (A,A)
		
	--end for loop
			

--2's complement 

	--if A or B is negative then
		--do 2's of P : CALL COMPONENT twoscomp for (P,P,Cout,OVERFLOW)
	--end if;
	
	
	
	process(A,B)
	
	variable negative : integer;
	variable pv,bp: std_logic_vector(7 downto 0);
	variable twosA: std_logic_vector(3 downto 0);
	variable twosB: std_logic_vector(3 downto 0);
	begin
	
--2's comp of A and B if they're negative		
		if A(3)='1'  then
			for i in 0 to 3 loop
					if A(i) = '1' then
						twosA(i) := '0';
					else
						twosA(i) := '1';
					end if;
				end loop;
				twosA := twosA + 00000001;
		else 
			twosA := A;	
		end if;
		
		if B(3)='1'  then
			for i in 0 to 3 loop
					if B(i) = '1' then
						twosB(i) := '0';
					else
						twosB(i) := '1';
					end if;
				end loop;
				twosB := twosB + 00000001;
		else 
			twosB := B;
		end if;
	
--multiplier algorithm	
		pv := "00000000";
		bp := "0000" & twosB;
		for i in 0 to 3 loop
			if twosA(i) = '1' then
				pv:= pv + bp;
			end if;
				bp:= bp(6 downto 0) & '0';
		end loop;
		
--2's comp of P if either A or B is negative
		if A(3)='1' and B(3)='1' then
			P<=pv;
		elsif A(3)='0' and B(3)='0' then
			P<=pv;
		else
			for i in 0 to 7 loop
				if pv(i) = '1' then
					pv(i) := '0';
				else
					pv(i) := '1';
				end if;
			end loop;
			pv := pv + 00000001;
			P<=pv;
		end if;	
		
		
		
		
	end process;
			

end struct;