----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: Sumador-Restador de N bits con acarreo anticipado 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU5 is
	GENERIC (N : INTEGER:= 4);
    Port ( A, B : in STD_LOGIC_VECTOR (N-1 downto 0);
           BINVERT : in STD_LOGIC;
           S : inout STD_LOGIC_VECTOR (N-1 downto 0);
           Z, CN, NE, OV  : out STD_LOGIC);
end AU5;

architecture PROGRAMA of AU5 is
begin
	
	PAU5 : PROCESS( A, B, BINVERT )
	VARIABLE EB,P,G : std_logic_vector(N-1 downto 0);
	VARIABLE PK, T2, PL, T3 : std_logic;
	VARIABLE C : std_logic_vector(N downto 0);
	BEGIN
		C(0) := BINVERT;
		FOR I IN 0 TO N-1 LOOP
			EB(I) := B(I) XOR BINVERT;
			P(I) := A(I) XOR EB(I);
			G(I) := A(I) AND EB(I);	--T1
			S(I) <= P(I) XOR C(I);
			T2 :='0';
			FOR J IN 0 TO I-1 LOOP
					PK :='1';
				FOR K IN J+1 TO I LOOP
					PK := PK AND P(K);
				END LOOP;
				T2 := T2 OR ( G(J) AND PK );	--T2
			END LOOP;
			--CALCULAR TERMINO T3
			PL := '1';
			FOR L IN 0 TO I LOOP
				PL := PL AND P(L);
			END LOOP;
			T3 := C(0) AND PL;	--T3
			
			C(I+1) := G(I) OR T2 OR T3;	-- C(I+1)= T1 + T2 + T3
		END LOOP;
		CN <= C(N);
		OV <= C(N) XOR C(N-1);
	END PROCESS PAU5;
        Z <= NOT (S(N-1) OR S(N-2) OR S(N-3) OR S(N-4));
        NE <= S(N-1);
end PROGRAMA;