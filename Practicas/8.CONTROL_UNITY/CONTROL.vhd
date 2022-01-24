----------------------------------------------------------------------------------
--@KARY
-- Proyecto: Unidad de Control 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONTROL is
    Port ( COD_FUN : in STD_LOGIC_VECTOR (3 downto 0);
           COD_OPC : in STD_LOGIC_VECTOR (4 downto 0);
           Z, C, N, OV : in STD_LOGIC;
           CLK, CLR : in STD_LOGIC;
           WPC, SR1, SWD, WR, SOP, SOP2, WD, SR : out STD_LOGIC;
           ALUOP : out STD_LOGIC_VECTOR (3 downto 0));
end CONTROL;

architecture UNIDAD of CONTROL is
SIGNAL LF, RZ, RN, RC, ROV : STD_LOGIC;
SIGNAL EQ, NEQ, LT, LET, GT, GET : STD_LOGIC;
SIGNAL BEQ, BNEQ, BLT, BLET, BGT, BGET, TIPOR : STD_LOGIC;
SIGNAL SDOPC, SM : STD_LOGIC;
SIGNAL A : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL M : STD_LOGIC_VECTOR(12 DOWNTO 0);

TYPE ESTADOS IS (EDO_A); --Estados del automata
SIGNAL EDO_ACT, EDO_SGTE : ESTADOS; --Hacer transicion de un estado a otro

TYPE MEMF IS ARRAY (0 TO 15) of STD_LOGIC_VECTOR(12 DOWNTO 0);
TYPE MEMO IS ARRAY (0 TO 31) of STD_LOGIC_VECTOR(12 DOWNTO 0);

--MEMORIAS
CONSTANT MEM_FUN : MEMF := (
    "0011000011101", -- ADD
    "0011000111101", -- SUB
    "0011000000101", -- AND 
    "0011000001101", -- OR 
    "0011000010101", -- XOR 
    "0011001101101", -- NAND 
    "0011001100101", -- NOR 
    "0011000110101", -- XNOR 
    "0000000111100", -- CP
    OTHERS=>(OTHERS => '0') --poner lo demas en 0's
);
CONSTANT MEM_OPC : MEMO := (
    "0000000000000", --condicion de NO SALTO va primero (Bcond)
    "0001000000000", -- LI
    "0011000000000", -- LWI 
    "0100000000010", -- SWI 
    "0011010011101", -- ADDI 
    "0011010111101", -- SUBI 
    "1000000000000", -- B
    "0100110111100", -- CPI 
    "1000000000000", -- BEQ
    "1000000000000", -- BNEQ
    "1000000000000", -- BLT
    "1000000000000", -- BLET 
    "1000000000000", -- BGT 
    "1000000000000", -- BGET 
    "0000000000000", -- NOP 
    OTHERS=>(OTHERS => '0') --poner lo demas en 0's
);  
begin
    
    WPC     <= M(12);           -- D12 
    SR1     <= M(11);           -- D11 
    SWD     <= M(10);           -- D10 
    WR      <= M(9);            -- D9 
    SOP     <= M(8);            -- D8 
    SOP2    <= M(7);            -- D7 
    ALUOP   <= M(6 DOWNTO 3);   -- D6,D5,D4,D3 
    LF      <= M(2);            -- D2  
    WD      <= M(1);            -- D1 
    SR      <= M(0);            -- D0 

    --AUTOMATA DE CONTROL
    AUTOMATA : PROCESS( EDO_ACT, BEQ, BNEQ, BLT, BLET, BGT, BGET, TIPOR, EQ, NEQ, LT, LET, GT, GET )
    BEGIN
    	SDOPC <= '0';
		SM <= '0';
		case EDO_ACT is
			when EDO_A =>
				if TIPOR = '0' then
					if BEQ = '1' then
						if EQ = '1' then
							SDOPC <= '1';
							SM <= '1';
						else
							SDOPC <= '0';
							SM <= '1';
						end if;
					elsif BNEQ = '1' then
						if NEQ = '1' then
							SDOPC <= '1';
							SM <= '1';
						else
							SDOPC <= '0';
							SM <= '1';
						end if;
					elsif BLT = '1' then
						if LT = '1' then
							SDOPC <= '1';
							SM <= '1';
						else
							SDOPC <= '0';
							SM <= '1';
						end if;
					elsif BLET = '1' then
						if LET = '1' then
							SDOPC <= '1';
							SM <= '1';
						else
							SDOPC <= '0';
							SM <= '1';
						end if;
					elsif BGT = '1' then
						if GT = '1' then
							SDOPC <= '1';
							SM <= '1';
						else
							SDOPC <= '0';
							SM <= '1';
						end if;
					elsif BGET = '1' then
						if GET = '1' then
							SDOPC <= '1';
							SM <= '1';
						else
							SDOPC <= '0';
							SM <= '1';
						end if;
					else
						SDOPC <= '1';
						SM <= '1';
					end if;
				end if;
				EDO_SGTE <= EDO_A; 
		end case;
    END PROCESS AUTOMATA;

    TRANSICION : PROCESS( CLK, CLR )
    BEGIN
        IF( CLR = '1' )THEN
            EDO_ACT <= EDO_A;
        ELSIF( rising_edge(CLK) )THEN
            EDO_ACT <= EDO_SGTE;    
        END IF;
    END PROCESS TRANSICION;
    
    --BLOQUE REGISTRO DE ESTADO
    REG_EDO : PROCESS(CLK, CLR) --CLK, Asíncronas de control
    BEGIN
        IF( CLR = '1' )THEN
            RZ  <= '0';
            RN  <= '0';
            RC  <= '0';
            ROV <= '0';
        ELSIF( CLK'EVENT AND CLK = '1' )THEN
            IF( LF = '1' )THEN
                RZ  <= Z;
                RN  <= N;
                RC  <= C;
                ROV <= OV;            
            END IF;
        END IF;
    END PROCESS REG_EDO;
    
    --BLOQUE DE CONDICION
    EQ  <= RZ;                             -- A = B
    NEQ <= NOT RZ;                         -- A != B
    GT  <= (NOT RZ) AND NOT(RN XOR ROV);   -- A > B
    GET <= RZ OR NOT (RN XOR ROV);         -- A >= B 
    LT  <= (NOT RZ) AND (RN XOR ROV);      -- A < B 
    LET <= RZ OR (RN XOR ROV);             -- A >= B 
      
    --DECODIFICADOR DE INSTRUCCION
    TIPOR  <= '1' WHEN( COD_OPC = "00000" ) ELSE '0';
    BEQ    <= '1' WHEN( COD_OPC = "01000" ) ELSE '0';   -- OPCODE = 8 
    BNEQ   <= '1' WHEN( COD_OPC = "01001" ) ELSE '0';   -- OPCODE = 9 
    BLT    <= '1' WHEN( COD_OPC = "01010" ) ELSE '0';   -- OPCODE = 10 
    BLET   <= '1' WHEN( COD_OPC = "01011" ) ELSE '0';   -- OPCODE = 11 
    BGT    <= '1' WHEN( COD_OPC = "01100" ) ELSE '0';   -- OPCODE = 12 
    BGET   <= '1' WHEN( COD_OPC = "01101" ) ELSE '0';   -- OPCODE = 13 

    --MULTIPLEXORES
    A <= "00000" WHEN( SDOPC = '0' )ELSE COD_OPC;
    M <= MEM_FUN( conv_integer( COD_FUN ) ) WHEN ( SM = '0' )ELSE MEM_OPC( conv_integer( A ) );

end UNIDAD;

