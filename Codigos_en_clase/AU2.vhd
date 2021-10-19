----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: Sumador-Restador de 4 bits con acarreo en cascada Version 2.0  
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU2 is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
           BINVERT : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           C4 : out STD_LOGIC);
end AU2;

architecture PROGRAMA of AU2 is
signal EB : std_logic_vector(3 downto 0);
signal C : std_logic_vector(4 downto 0);
begin
	
    C(0) <= BINVERT;
	
CICLO:FOR I IN 0 TO 3 GENERATE
    EB(I) <= B(I) XOR BINVERT;
    S(I) <= A(I) XOR EB(I) XOR C(I);
    C(I+1) <= (A(I) AND C(I)) OR (EB(I) AND C(I)) OR (A(I) AND EB(I));
END GENERATE;
    
    C4 <= C(4);

end PROGRAMA;
