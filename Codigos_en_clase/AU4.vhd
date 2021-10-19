----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: Sumador-Restador de N bits con acarreo en cascada Version 3.0  
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU4 is
	GENERIC (N : INTEGER := 4 );
    Port ( A,B : in STD_LOGIC_VECTOR (N-1 downto 0);
           BINVERT : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (N-1 downto 0);
           CN : out STD_LOGIC);
end AU4;

architecture PROGRAMA of AU3 is
begin
	
	PAU4 : PROCESS( A, B, BINVERT )	-- SECUENCIAL
	VARIABLE EB : std_logic_vector(N-1 downto 0) := "0000";
	VARIABLE C : std_logic_vector(N downto 0) := "00000";
	BEGIN
		C(0) := BINVERT;
		FOR I IN 0 TO N-1 LOOP
			EB(I) := B(I) XOR BINVERT;
			S(I) <= A(I) XOR EB(I) XOR C(I);
			C(I+1) := (A(I) AND C(I)) OR (EB(I) AND C(I)) OR (A(I) AND EB(I));
		END LOOP;
		CN <= C(N);
	END PROCESS PAU4;

end PROGRAMA;

