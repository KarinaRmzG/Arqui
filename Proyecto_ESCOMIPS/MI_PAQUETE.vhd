-------------------------------------------------------------------------
-- @KARY
-- Proyecto: PAQUETE PARA EL ESCOMIPS
-------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package MI_PAQUETE is

-- alu
component ALU is
    GENERIC (NUM: INTEGER := 8); 
    Port ( A,B: in std_logic_vector (NUM-1 downto 0);
           AINVERT, BINVERT: in std_logic;
           OP: in std_logic_vector (1 downto 0);
           RES: inout std_logic_vector (NUM-1 downto 0);
           CN, Z, OV, N: out std_logic);
end component;

-- unidad de control
component CONTROL is
    Port ( COD_FUN : in STD_LOGIC_VECTOR (3 downto 0);
           COD_OPC : in STD_LOGIC_VECTOR (4 downto 0);
           Z, C, N, OV : in STD_LOGIC;
           CLK, CLR : in STD_LOGIC;
           WPC, SR1, SWD, WR, SOP, SOP2, WD, SR : out STD_LOGIC;
           ALUOP : out STD_LOGIC_VECTOR (3 downto 0));
end component;

-- memoria de datos
component RAM_DIST is
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
end component;

-- contador de programa
component PC is
  GENERIC ( N: INTEGER := 8 );
  Port ( D: in std_logic_vector (N-1 downto 0);
         Q: inout std_logic_vector (N-1 downto 0);
         CLK, CLR: in std_logic;
         WPC: in std_logic
   );
end component;

-- memoria de programa
component PROGRAMA is
    GENERIC (BITS_BUS_DIR	: INTEGER := 8;
			 BIT_BUS_DATOS  : INTEGER := 15 );
    Port ( BUS_DIR   : in STD_LOGIC_VECTOR (BITS_BUS_DIR-1 downto 0);
		   BUS_DATOS : out STD_LOGIC_VECTOR (BIT_BUS_DATOS-1 downto 0)
		   );
end component;

-- archivo de registros
component REGISTROS is
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
end component;

-- divisor de frecuencia
component DIVISOR is
    GENERIC( N : INTEGER := 50000 );
    Port ( OSC_CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           CLK : inout STD_LOGIC);
end component;


end MI_PAQUETE;

package body MI_PAQUETE is

end MI_PAQUETE;