----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: File Register
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity REGISTROS is
    generic(N_BITS_ADR: INTEGER := 2;
            N_BITS_DIN: INTEGER := 8);
    Port ( WR_REG, RD_REG1, RD_REG2 : in STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0);
           WR_DATA : in STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0);
           WR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RD_DATA1, RD_DATA2 : out STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0));
end REGISTROS;

architecture ARCHIVO of REGISTROS is
TYPE MEMORIA IS ARRAY ( 0 TO 2**N_BITS_ADR-1 ) OF STD_LOGIC_VECTOR( WR_DATA'RANGE );
SIGNAL MEM_DIST : MEMORIA;
begin
    PRAM : PROCESS(CLK)
    BEGIN  
        IF( RISING_EDGE( CLK ) ) THEN
			IF( WR = '1' ) THEN                                  --ESCRITURA SINCRONA
				MEM_DIST( CONV_INTEGER(WR_REG) ) <= WR_DATA;
			END IF;
		END IF;
    END PROCESS PRAM;

	RD_DATA1 <= MEM_DIST( CONV_INTEGER(RD_REG1) );               --LECTURA ASINCRONA
	RD_DATA2 <= MEM_DIST( CONV_INTEGER(RD_REG2) );               --LECTURA ASINCRONA

end ARCHIVO;



