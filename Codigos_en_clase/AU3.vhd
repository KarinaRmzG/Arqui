----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: Sumador-Restador de 4 bits con acarreo en cascada Version 3.0  
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU3 is
    Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
           BINVERT : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           C4 : out STD_LOGIC);
end AU3;

architecture PROGRAMA of AU3 is
begin
	
	PAU3 : PROCESS( A, B, BINVERT )
	VARIABLE EB : std_logic_vector(3 downto 0);
	VARIABLE C : std_logic_vector(4 downto 0);
	BEGIN
		C(0) := BINVERT;
		FOR I IN 0 TO 3 LOOP
			EB(I) := B(I) XOR BINVERT;
			S(I) <= A(I) XOR EB(I) XOR C(I);
			C(I+1) := (A(I) AND C(I)) OR (EB(I) AND C(I)) OR (A(I) AND EB(I));
		END LOOP;
		C4 <= C(4);
	END PROCESS PAU3;

end PROGRAMA;
