----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: RAM Distribuida
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM_DIST is
    GENERIC (
        N_BITS_ADR : INTEGER := 8;
        N_BITS_DIN : INTEGER := 8
    );
    Port (
        ADR : in std_logic_vector (N_BITS_ADR-1 downto 0);
        DIN : in std_logic_vector (N_BITS_DIN-1 downto 0);
        WR_EN : in std_logic;
        CLK : in std_logic;
        DOUT : out std_logic_vector (N_BITS_DIN-1 downto 0)
    );
end RAM_DIST;

architecture PROGRAMA of RAM_DIST is
TYPE MEMORY IS ARRAY (0 TO 2**N_BITS_ADR-1) OF std_logic_vector (DIN'RANGE);
SIGNAL MEM_DIST : MEMORY;
begin
    PRAM : PROCESS ( CLK )
    BEGIN
        IF (rising_edge(CLK)) THEN
            IF (WR_EN = '1') THEN
                MEM_DIST(conv_integer(ADR)) <= DIN;
            END IF;
        END IF;
    END PROCESS PRAM;
    DOUT <= MEM_DIST(conv_integer(ADR));

end PROGRAMA;

