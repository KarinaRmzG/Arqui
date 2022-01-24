-------------------------------------------------------------------------
-- @KARY
-- Proyecto: CONTADOR DE PROGRAMA
-- Contador de 8 bits ascendente con carga
-------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity PC is
    GENERIC ( N : INTEGER := 8 );
    port ( D : in std_logic_vector ( N-1 downto 0 );
           Q : inout std_logic_vector ( N-1 downto 0 );
           CLK, CLR : in std_logic;
           WPC : IN std_logic);
end PC;

architecture PROGRAMA of PC is

begin
    PPC : PROCESS ( CLK, CLR ) 
    begin
        IF( CLR = '1')THEN 
            Q <= ( OTHERS => '0' );
        ELSIF(rising_edge(CLK))THEN 
            IF( WPC = '1' )THEN         --CONTROL DE CARGA
                Q <= D;
            ELSE 
                Q <= Q + 1;             -- CONTAR: 0,1,2,3,......
            END IF;
        END IF;
    END PROCESS PPC;
end PROGRAMA;
