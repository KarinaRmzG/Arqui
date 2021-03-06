----------------------------------------------------------------------------------
-- @Kary
-- Proyecto: Memoria de Programa (ROM)
-- Memoria de Programa = 256 x 15
-- Bus de direcciones = 8 bits 
-- Bus de datos = 15 bits 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PROGRAMA is
    GENERIC (BITS_BUS_DIR	: INTEGER := 8;
			 BIT_BUS_DATOS  : INTEGER := 15 );
    Port ( BUS_DIR   : in STD_LOGIC_VECTOR (BITS_BUS_DIR-1 downto 0);
		   BUS_DATOS : out STD_LOGIC_VECTOR (BIT_BUS_DATOS-1 downto 0)
		   );
end PROGRAMA;

architecture MEMORIA of PROGRAMA is
----------------------CODIGOS DE OPERACION------------------------------
-- El codigo de operacion de las instrucciones tipo R siempre es '0'
CONSTANT OP_TR  : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";  --OPCODE 00
-- Intrucciones tipo I
CONSTANT OP_LI  : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";  --OPCODE 01
CONSTANT OP_LWI : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00010";  --OPCODE 02
CONSTANT OP_SWI : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00011";  --OPCODE 03
CONSTANT OP_ADDI: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00100";  --OPCODE 04
CONSTANT OP_SUBI: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00101";  --OPCODE 05
CONSTANT OP_CPI : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00111";  --OPCODE 07
-- Instrucciones tipo J
CONSTANT OP_B   : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00110";  --OPCODE 06
CONSTANT OP_BEQ : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01000";  --OPCODE 08 
CONSTANT OP_BNEQ: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01001";  --OPCODE 09
CONSTANT OP_BLT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01010";  --OPCODE 10
CONSTANT OP_BLET: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01011";  --OPCODE 11
CONSTANT OP_BGT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";  --OPCODE 12
CONSTANT OP_BGET: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01101";  --OPCODE 13
CONSTANT OP_NOP : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01110";  --OPCODE 14
----------------------CODIGOS DE FUNCION--------------------------------
-- Instrucciones tipo R
CONSTANT FUN_ADD : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";  --FUNCODE 00
CONSTANT FUN_SUB : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";  --FUNCODE 01
CONSTANT FUN_AND : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";  --FUNCODE 02
CONSTANT FUN_OR  : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";  --FUNCODE 03
CONSTANT FUN_XOR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";  --FUNCODE 04
CONSTANT FUN_NAND: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";  --FUNCODE 05
CONSTANT FUN_NOR : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";  --FUNCODE 06
CONSTANT FUN_XNOR: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";  --FUNCODE 07
CONSTANT FUN_CP  : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1000";  --FUNCODE 08
--Sin Uso S/U
CONSTANT SU : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
--------------------------REGISTROS---------------------------------------
CONSTANT R0 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
CONSTANT R1 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
CONSTANT R2 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "10";
CONSTANT R3 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";
TYPE MEM_ROM IS ARRAY( 0 TO 2**BITS_BUS_DIR-1 ) OF STD_LOGIC_VECTOR( BUS_DATOS'RANGE );
	CONSTANT MEM_PROG : MEM_ROM := (
	--CONCATENACION:
	OP_LI&R0&X"01",         --LI R0, #1
        OP_LI&R1&X"07",         --LI R1, #7
        OP_TR&R1&R1&R0&FUN_ADD, --ADD R1, R1, R0
        OP_SWI&R1&X"05",        --SWI R1, 5
        OP_B&SU&X"02",          --B CICLO
        OTHERS => ( OTHERS => '0' )
        --OTHERS => "00000000000000"
        --OTHERS => "000"&X"000"
	);
begin
    BUS_DATOS <= MEM_PROG( conv_integer(BUS_DIR) );

end MEMORIA;
