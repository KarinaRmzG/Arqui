----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: Sumador-Restador de N bits con acarreo en cascada
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU is
    GENERIC (N: INTEGER := 4); 
    Port ( A,B: in std_logic_vector (N-1 downto 0);
           BINVERT: in std_logic;
           S: inout std_logic_vector (N-1 downto 0);
           CN, Z, OV, NE: out std_logic);
end AU;

architecture PROGRAM of AU is
begin
    PAU : PROCESS( A, B, BINVERT )	-- SECUENCIAL
	VARIABLE EB : std_logic_vector(N-1 downto 0) := "0000";
	VARIABLE C : std_logic_vector(N downto 0) := "00000";
	BEGIN
		C(0) := BINVERT;
		FOR I IN 0 TO N-1 LOOP
			EB(I) := B(I) XOR BINVERT;
			S(I) <= A(I) XOR EB(I) XOR C(I);
			C(I+1) := (A(I) AND C(I)) OR (EB(I) AND C(I)) OR (A(I) AND EB(I));
		END LOOP;
		--C4 <= C(N);
		CN <= C(N);
		NE <= S(N-1);
		OV <= C(N) XOR C(N-1);
		Z <= NOT (S(N-1) OR S(N-2) OR S(N-3) OR S(N-4));
	END PROCESS PAU;

end PROGRAM;
