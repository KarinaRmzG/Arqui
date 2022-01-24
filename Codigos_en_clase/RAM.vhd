----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: RAM Distribuida de 2 puertos
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM_DIST is
    generic(N_BITS_ADR: INTEGER := 8;
            N_BITS_DIN: INTEGER := 8);
    Port ( ADR_R, ADR_W : in STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0);
           DIN : in STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0);
           WD : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0));
end RAM_DIST;

architecture PROGRAMA of RAM_DIST is
TYPE MEMORIA IS ARRAY ( 0 TO 2**N_BITS_ADR-1 ) OF STD_LOGIC_VECTOR( DIN'RANGE );
SIGNAL MEM_DIST : MEMORIA;
begin
    PRAM : PROCESS(CLK)
    BEGIN  
        IF( RISING_EDGE( CLK ) ) THEN
			IF( WD = '1' ) THEN                       --ESCRITURA SINCRONA
				MEM_DIST( CONV_INTEGER(ADR_W) ) <= DIN;
			END IF;
		END IF;
    END PROCESS PRAM;

	DOUT <= MEM_DIST( CONV_INTEGER(ADR_R) );               --LECTURA ASINCRONA

end PROGRAMA;
