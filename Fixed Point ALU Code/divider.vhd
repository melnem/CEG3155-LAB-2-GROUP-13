library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divider is
	port( 
				 A,B  : in std_logic_vector(3 downto 0);
				 Q  : out std_logic_vector(7 downto 0); --note : Q is always gonna be 4 bits since a division operation can only give you a number < or = to A/B (which are 4 bits)
				 R  : out std_logic_vector(3 downto 0);
				 Cout, OVERFLOW : out std_logic);

end divider;

architecture struct of divider is

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
	component comparator is
	port(  A,B  : in std_logic_vector(3 downto 0);
				 trueorfalse : out std_logic);
	end component;
	

	
--algorithm using our components (structural)
-- 2's complement of A nd B

	--if A is negative
		--CALL COMPONENT twoscomp for (A, A, Cout, Overflow)
	--if B is negative
		--CALL COMPONENT twoscomp for (B, B, Cout, Overflow)

--division
--		for i in 0 to 3 loop
--			CALL LEFTSHIFTER COMPONENT to shift ra;
--			if CALL COMPARATOR TO COMPARE R AND B then
--				quot(3-i):='1';
--				CALL ADDER/SUB COMPONENT do do ra-B;
--			else
--				quot(3-i):='0';
--			end if;
--			rema := ra(7 downto 4);
--		end loop;
			

--2's complement 

	--if A or B is negative then
		--do 2's of Q : CALL COMPONENT twoscomp for (Q,Q,Cout,OVERFLOW)
		--do 2's of R : CALL COMPONENT twoscomp for (R,R,Cout,OVERFLOW)
	--end if;
	
	

begin

	process(A,B)
	
	variable ra: std_logic_vector (7 downto 0);
	variable quot: std_logic_vector (7 downto 0);
	variable rema: std_logic_vector (3 downto 0);
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
		
--divider algorithm		
		ra := "0000" & twosA;

		for i in 0 to 3 loop
			ra := ra(6 downto 0) & '0';
			if ra(7 downto 4)>= B then
				quot(3-i):='1';
				ra(7 downto 4) := ra(7 downto 4) - twosB;
			else
				quot(3-i):='0';
			end if;
			rema := ra(7 downto 4);
		end loop;
				
--2's comp of Q and R if either A or B is negative		
		if A(3)='1' and B(3)='1' then
			Q<=quot;
			R<=rema;
		elsif A(3)='0' and B(3)='0' then
			Q<=quot;
			R<=rema;
		else
			for i in 0 to 7 loop
				if quot(i) = '1' then
					quot(i) := '0';
				else
					quot(i) := '1';
				end if;
			end loop;
			quot := quot + 00000001;
			Q<=quot;
			for i in 0 to 3 loop
				if rema(i) = '1' then
					rema(i) := '0';
				else
					rema(i) := '1';
				end if;
			end loop;
			rema := rema + 00000001;
			R<=rema;
		end if;	
		
		
	end process;

	 
	
		
	

end struct;