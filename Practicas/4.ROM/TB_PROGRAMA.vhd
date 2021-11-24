----------------------------------------------------------------------------------
-- @Kary
-- Proyecto: Memoria de Programa (ROM)
-- Memoria de Programa = 256 x 15
-- Bus de direcciones = 8 bits 
-- Bus de datos = 15 bits 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PROGRAMA_tb is
    GENERIC (BITS_BUS_DIR : INTEGER := 8;
             BIT_BUS_DATOS : INTEGER := 15);
end;

architecture bench of PROGRAMA_tb is

  component PROGRAMA
      GENERIC (BITS_BUS_DIR	: INTEGER := 8;
  			 BIT_BUS_DATOS  : INTEGER := 15 );
      Port ( BUS_DIR   : in STD_LOGIC_VECTOR (BITS_BUS_DIR-1 downto 0);
  		   BUS_DATOS : out STD_LOGIC_VECTOR (BIT_BUS_DATOS-1 downto 0)
  		   );
  end component;

  signal BUS_DIR: STD_LOGIC_VECTOR (BITS_BUS_DIR-1 downto 0);
  signal BUS_DATOS: STD_LOGIC_VECTOR (BIT_BUS_DATOS-1 downto 0) ;

begin

  -- Insert values for generic parameters !!
  uut: PROGRAMA generic map ( BITS_BUS_DIR  => 8,
                              BIT_BUS_DATOS => 15)
                   port map ( BUS_DIR       => BUS_DIR,
                              BUS_DATOS     => BUS_DATOS );

  stimulus: process
  begin
    
    BUS_DIR <= X"00";
    wait for 50ns;
    
    BUS_DIR <= X"01";
    wait for 50ns;

    BUS_DIR <= X"02";
    wait for 50ns;
    
    BUS_DIR <= X"03";
    wait for 50ns;
    
    BUS_DIR <= X"04";
    wait for 50ns;
    
    BUS_DIR <= X"02";
    wait for 50ns;
    
    BUS_DIR <= X"03";
    
    wait;
  end process;


end;