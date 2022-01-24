----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: File Register
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity REGISTROS is
    GENERIC ( 
        N_BITS_ADR : INTEGER := 2;
        N_BITS_DIN : INTEGER := 8
    );
    Port (
        WR_REG, RD_REG1, RD_REG2 : in std_logic_vector (N_BITS_ADR-1 downto 0);
        WR_DATA : in std_logic_vector (N_BITS_DIN-1 downto 0);
        WR : in std_logic;
        CLK : in std_logic;
        RD_DATA1, RD_DATA2 : out std_logic_vector (N_BITS_DIN-1 downto 0)
    );
end REGISTROS;

architecture ARCHIVO of REGISTROS is
TYPE MEMORY IS ARRAY (0 TO 2**N_BITS_ADR-1) OF std_logic_vector (WR_DATA'RANGE);
SIGNAL MEM_DIST : MEMORY;
begin
    PRAM : PROCESS (CLK)
    BEGIN
        IF (rising_edge(CLK)) THEN
            IF (WR = '1') THEN
                MEM_DIST (conv_integer(WR_REG)) <= WR_DATA;
            END IF;
        END IF;
    END PROCESS PRAM;
    
    -- read information
    RD_DATA1 <= MEM_DIST (conv_integer(RD_REG1));
    RD_DATA2 <= MEM_DIST (conv_integer(RD_REG2));
end ARCHIVO;



