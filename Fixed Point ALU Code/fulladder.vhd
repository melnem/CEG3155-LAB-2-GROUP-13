library ieee;
use ieee.std_logic_1164.all;

entity fulladder is
   port( A, B, Cin : in std_logic;
         sum, Cout : out std_logic);
end fulladder;
 
architecture struc of fulladder is
begin
   sum <= A xor B xor Cin;
   Cout <= (A and (B or Cin)) or (Cin and B);
end struc;
