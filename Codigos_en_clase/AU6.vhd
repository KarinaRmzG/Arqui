----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: ALU de N bits v1.0
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AU5 is
	GENERIC (N : INTEGER:= 4);
    Port ( A, B : in STD_LOGIC_VECTOR (N-1 downto 0);
           BINVERT, AINVERT : in STD_LOGIC;
           OP : in STD_LOGIC_VECTOR (1 downto 0);
		   RES : inout STD_LOGIC_VECTOR(N-1 downto 0);
           Z, CN, NE, OV  : out STD_LOGIC);
end AU5;

architecture PROGRAMA of AU5 is
begin
	
	PAU5 : PROCESS( A, B, AINVERT, BINVERT, OP )
	VARIABLE MUXA, MUXB,P,G : std_logic_vector(N-1 downto 0);
	VARIABLE PK, T2, PL, T3 : std_logic;
	VARIABLE C : std_logic_vector(N downto 0);
	BEGIN
		C := (OTHERS => '0');
		C(0) := BINVERT;
		FOR I IN 0 TO N-1 LOOP
			MUXA(I) := A(I) XOR AINVERT;
			MUXB(I) := B(I) XOR BINVERT;	--EB(I) := B(I) XOR BINVERT;
			CASE OP IS 
				WHEN "00" => 
						RES(I) <= MUXA(I) AND MUXB(I)
				WHEN "01" =>
						RES(I) <= MUXA(I) OR MUXB(I);
				WHEN "10" =>
						RES(I) <= MUXA(I) XOR MUXB(I);
				WHEN OTHERS =>
					P(I) := MUXA(I) XOR MUXB(I);
					G(I) := MUXA(I) AND MUXB(I);	--T1
					RES(I) <= P(I) XOR C(I);
					--C(I + 1) := G(I);
					T2 :='0';
					FOR J IN 0 TO I-1 LOOP
						PK :='1';
					FOR K IN J+1 TO I LOOP
						PK := PK AND P(K);
					END LOOP;
						T2 := T2 OR ( G(J) AND PK );	--T2
					END LOOP;
					PL := '1';
					FOR L IN 0 TO I LOOP
						PL := PL AND P(L);
					END LOOP;
					T3 := C(0) AND PL;	--T3
			
					C(I+1) := G(I) OR T2 OR T3;	-- C(I+1)= T1 + T2 + T3
			END CASE;
		END LOOP;
		CN <= C(N);
		OV <= C(N) XOR C(N-1);
	END PROCESS PAU5;
        Z <= NOT (RES(N-1) OR RES(N-2) OR RES(N-3) OR RES(N-4));
        NE <= RES(N-1);
end PROGRAMA;

