library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    GENERIC (NUM: INTEGER := 4); 
    Port ( A,B: in std_logic_vector (NUM-1 downto 0);
           AINVERT, BINVERT: in std_logic;
           --S: inout std_logic_vector (NUM-1 downto 0);
           OP: in std_logic_vector (1 downto 0);
           RES: inout std_logic_vector (NUM-1 downto 0);
           CN, Z, OV, N: out std_logic);
end ALU;

architecture PROGRAM of ALU is
begin
    PAU : PROCESS( A, B, AINVERT, BINVERT, OP )
	VARIABLE MUXA, MUXB, P, G: std_logic_vector(NUM-1 downto 0);
	VARIABLE C : std_logic_vector(NUM downto 0);
	VARIABLE PK, T2, PL : std_logic;
	BEGIN
	    C := "00000";
		C(0) := BINVERT;
		FOR I IN 0 TO NUM-1 LOOP
		    MUXA(I) := A(I) XOR AINVERT;
		    MUXB(I) := B(I) XOR BINVERT;
            CASE OP IS
                WHEN "00" =>
                    RES(I) <= MUXA(I) AND MUXB(I);
                WHEN "01" =>
                    RES(I) <= MUXA(I) OR MUXB(I);
                WHEN "10" =>
                    RES(I) <= MUXA(I) XOR MUXB(I);
                WHEN OTHERS =>
                    --EB(I) := B(I) XOR BINVERT;
                    P(I) := A(I) XOR MUXB(I);
                    G(I) := A(I) AND MUXB(I);
                    --S(I) := A(I) XOR EB(I) XOR C(I);
                    RES(I) <= P(I) XOR C(I);
                    T2 := '0';
                    FOR J IN 0 TO I-1 LOOP
                         PK := '1';
                         FOR K IN J+1 TO I LOOP
                             PK := PK AND P(K);
                         END LOOP;
                         T2 := T2 OR (G(J) AND PK);
                    END LOOP;
                    PL := C(0);
                    FOR L IN 0 TO I LOOP
                         PL := PL AND P(L);
                    END LOOP;
                    C(I+1) := G(I) OR T2 OR PL;
			END CASE;
		END LOOP;
		CN <= C(NUM);
		OV <= C(NUM) XOR C(NUM-1);
		--Z <= NOT (S(3) OR S(2) OR S(1) OR S(0));
	END PROCESS PAU;
	N <= RES(NUM-1);
    Z <= '1' WHEN ( RES = 0 ) ELSE '0';
end PROGRAM;