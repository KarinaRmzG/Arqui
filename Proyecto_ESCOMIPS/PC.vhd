-------------------------------------------------------------------------
-- @KARY
-- Proyecto: CONTADOR DE PROGRAMA
-- Contador de 8 bits ascendente con carga
-------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
  GENERIC ( N: INTEGER := 8 );
  Port ( D: in std_logic_vector (N-1 downto 0);
         Q: inout std_logic_vector (N-1 downto 0);
         CLK, CLR: in std_logic;
         WPC: in std_logic
   );
end PC;

architecture CONTADOR of PC is

begin
    PPC: PROCESS (CLK, CLR)
    BEGIN
        IF (CLR = '1') THEN
            Q <= (OTHERS => '0');
        ELSIF (rising_edge(CLK)) THEN
            IF (WPC = '1') THEN
                Q <= D;
            ELSE
                Q <= Q + 1;
            END IF;
        END IF;
    END PROCESS;

end CONTADOR;
