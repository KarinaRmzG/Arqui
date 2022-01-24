-------------------------------------------------------------------------
-- @KARY
-- Proyecto: PROGRAMA PRINCIPAL ESCOMIPS
-------------------------------------------------------------------------
library IEEE;
library WORK;                                           --Carpeta donde puse mi proyecto
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MI_PAQUETE.ALL;                                -- Usar todo lo que puse en el paquete "MI_PAQUETE"

entity ESCOMIPS is
-- simulacion OSC_CLK -> CLK
  Port (  CLR, CLK : in STD_LOGIC;
         A: out STD_LOGIC_VECTOR (7 downto 0);
         Di : out STD_LOGIC_VECTOR (7 downto 0)
  );
end ESCOMIPS;

architecture PROCESADOR of ESCOMIPS is

--SIGNAL CLK: STD_LOGIC;  -- simulacion comentar                                  --DISEÑO DE OSCILADOR: Divisor de Frecuencia
--SALIDAS PC
SIGNAL AC : STD_LOGIC_VECTOR( 7 DOWNTO 0 );              --BUS AZUL REY
--SALIDAS DE LOS MUXES
SIGNAL MR1 : STD_LOGIC_VECTOR( 1 DOWNTO 0 );
SIGNAL MWD, MOP, MOP2, MR: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
--SALIDAS DEL ARCHIVO DE REGISTROS
SIGNAL RD1, RD2 : STD_LOGIC_VECTOR( 7 DOWNTO 0 );  
--SALIDA EXTENSOR
SIGNAL ES : STD_LOGIC_VECTOR( 7 DOWNTO 0 ); 
--SALIDA MEMORIA DE DATOS
SIGNAL DO : STD_LOGIC_VECTOR( 7 DOWNTO 0 ); 
--SALIDA MEMORIA DE PROGRAMA
SIGNAL I  : STD_LOGIC_VECTOR( 14 DOWNTO 0 );             --BUS NEGRO
--SALIDA ALU
SIGNAL RALU: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
--DECLARACIONES DE LAS SEÑALES DE LA UNIDAD DE CONTROL            
SIGNAL WPC,SR1,SWD,WR,SOP,SOP2,WD,SR : STD_LOGIC;        --SEÑALES DE LA UNIDAD DE CONTROL
SIGNAL ALUOP : STD_LOGIC_VECTOR( 3 DOWNTO 0 );           --SEÑALES DE LA UNIDAD DE CONTROL
--BANDERAS
SIGNAL Z, C, N, OV : STD_LOGIC;                          

begin

--A   <= I(7 downto 0) WHEN (I(7 downto 0) = "00001010") ELSE "00000000";
--Di  <= RD1 WHEN (I(7 downto 0) = "00001010") ELSE "00000000";
A   <= I(7 downto 0) ;
Di  <= RD1 ;
-- |=================================DIVISOR DE FRECUENCIA===========================================|
--FREC : DIVISOR PORT MAP(
--		OSC_CLK => OSC_CLK,
--        CLK     => CLK,
--        CLR     => CLR
--	 );
-- |===================================MEMORIA DE PROGRAMA===========================================|
--MEM_PROG : PROGRAMA PORT MAP ( AC, I);                  --NOTACION POSICIONAL
MEM_PROG : PROGRAMA PORT MAP (                              
           BUS_DIR      => AC,
           BUS_DATOS    => I
           );
-- |==========================================MUXES==================================================|
MR1  <= I(7 DOWNTO 6) WHEN (SR1 = '0') ELSE I(9 DOWNTO 8);   
MWD  <= I(7 DOWNTO 0) WHEN (SWD = '0') ELSE MR; 
-- |===================================ARCHIVO DE REGISTROS==========================================|
ARCH_REG : REGISTROS PORT MAP (
           RD_REG1  => MR1, 
           RD_REG2  => I ( 5 DOWNTO 4 ),
           WR_REG   => I ( 9 DOWNTO 8 ),
           WR_DATA  => MWD,
           CLK      => CLK,
           WR       => WR,
           RD_DATA1 => RD1, 
           RD_DATA2 => RD2
        );
-- |==================================CONTADOR DE PROGRAMA===========================================|
PILA : PC PORT MAP (
       CLK => CLK,
       CLR => CLR,
       WPC => WPC,
       D   => I ( 7 downto 0 ),
       Q   => AC
       );
-- |====================================EXTENSOR DE SIGNO============================================|
ES <= "00"&I( 5 DOWNTO 0 ) WHEN ( I(5) = '0' ) ELSE "11"&I( 5 DOWNTO 0); --ES <= I(5)&I(5)&I(5 downto 0);
-- |==========================================MUXES==================================================|
MOP  <= ES WHEN (SOP = '0') ELSE I (7 DOWNTO 0);           
MOP2 <= RD2 WHEN (SOP2 = '0') ELSE MOP;
-- |===========================================ALU===================================================|
UAL : ALU PORT MAP (
      A       => RD1,
      B       => MOP2,
      AINVERT => ALUOP(3), 
      BINVERT => ALUOP(2),
      OP      => ALUOP ( 1 DOWNTO 0 ),
      RES     => RALU,
      CN      => C, 
      Z       => Z, 
      OV      => OV, 
      N       => N
    );
-- |=====================================MEMORIA DE DATOS============================================|
MEM_DAT : RAM_DIST PORT MAP (
          ADR   => I (7 DOWNTO 0),
          DIN   => RD1,
          WR_EN => WD,
          CLK   => CLK,
          DOUT  => DO
        );
-- |==========================================MUXES==================================================|  
MR   <= DO WHEN (SR = '0') ELSE RALU;
-- |====================================UNIDAD DE CONTROL============================================|
UNI_CONTROL : CONTROL PORT MAP (
              COD_FUN => I ( 3 DOWNTO 0 ),
              COD_OPC => I ( 14 DOWNTO 10 ),
              Z       => Z, 
              C       => C, 
              N       => N, 
              OV      => OV,
              CLK     => CLK, 
              CLR     => CLR,
              WPC     => WPC, 
              SR1     => SR1, 
              SWD     => SWD, 
              WR      => WR, 
              SOP     => SOP, 
              SOP2    => SOP2, 
              WD      => WD, 
              SR      => SR,
              ALUOP   => ALUOP
            );
    
    
end PROCESADOR;