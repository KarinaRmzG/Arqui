library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DIVISOR is
    GENERIC( N : INTEGER := 50000 );
    Port ( OSC_CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           CLK : inout STD_LOGIC);
end DIVISOR;

architecture PROGRAMA of DIVISOR is
SIGNAL CONT : INTEGER RANGE 0 TO (2**10)*N - 1; --1024 (1K) *100000 = 102400000Hz = 100MHz
--FCLK = 100MHz / (2*CONT) = 100MHz / 200MHz = 0.5Hz
--N = 50
--SIGNAL CONT : INTEGER RANGE 0 TO (2**10)*N - 1; --1024(1K) *50 =  = 51200Hz = 5OKHz
--FCLK = 100MHz / (2*CONT) = 100MHz / 100KHz = 1KHz
begin
   PDIV : PROCESS( OSC_CLK, CLR )
    BEGIN
        IF( CLR = '1' )THEN
            CLK <= '0';
            CONT <= 0;
        ELSIF( OSC_CLK'EVENT AND OSC_CLK = '1' )THEN
            CONT <= CONT + 1;
            IF( CONT = 0 )THEN
                CLK <= NOT CLK;
            END IF;    
        END IF;
    END PROCESS PDIV;

end PROGRAMA;
