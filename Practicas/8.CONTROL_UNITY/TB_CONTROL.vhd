----------------------------------------------------------------------------------
--@KARY
-- Proyecto: Unidad de Control 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CONTROL_tb is
end;

architecture bench of CONTROL_tb is

  component CONTROL
      Port ( COD_FUN : in STD_LOGIC_VECTOR (3 downto 0);
             COD_OPC : in STD_LOGIC_VECTOR (4 downto 0);
             Z, N, C, OV : in STD_LOGIC;
             CLK, CLR : in STD_LOGIC;
             WPC, SR1, SWD, WR, SOP, SOP2, WD, SR : out STD_LOGIC;
             ALUOP : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal COD_FUN: STD_LOGIC_VECTOR (3 downto 0);
  signal COD_OPC: STD_LOGIC_VECTOR (4 downto 0);
  signal Z, N, C, OV: STD_LOGIC;
  signal CLK, CLR: STD_LOGIC;
  signal WPC, SR1, SWD, WR, SOP, SOP2, WD, SR: STD_LOGIC;
  signal ALUOP: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: CONTROL port map ( COD_FUN => COD_FUN,
                          COD_OPC => COD_OPC,
                          Z       => Z,
                          N       => N,
                          C       => C,
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
                          ALUOP   => ALUOP );

  stimulus: process
  begin
    --PRIMER CASO RESET 
    CLR <= '1';     --Todo debe estar el 0's 
    wait for 10ns;
    
    ------------------------------------------INSTRUCCIONES TIPO R------------------------------------------------------
    CLR <= '0';
    --------ADD-----------
    COD_OPC <= "00000";
    COD_FUN <= "0000";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------SUB-----------
    COD_FUN <= "0001";
    Z       <= '0';
    C       <= '1';
    N       <= '0';
    OV      <= '1';
    wait for 10ns;
    --------AND-----------
    COD_FUN <= "0010";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    --------OR-----------
    COD_FUN <= "0011";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------XOR-----------
    COD_FUN <= "0100";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    --------NAND-----------
    COD_FUN <= "0101";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------NOR-----------
    COD_FUN <= "0110";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------XNOR-----------
    COD_FUN <= "0111";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    ------------------------------------------INSTRUCCIONES TIPO I Y B------------------------------------------------------
    --------LI-----------
    COD_OPC <= "00001";
    COD_FUN <= "0111";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------LWI-----------
    COD_OPC <= "00010";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------SWI-----------
    COD_OPC <= "00011";
    COD_FUN <= "0000";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    --------ADDI-----------
    COD_OPC <= "00100";
    COD_FUN <= "0110";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '1';
    wait for 10ns;
    --------SUBI-----------
    COD_OPC <= "00101";
    COD_FUN <= "1010";
    Z       <= '1';
    C       <= '1';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------B-----------
    COD_OPC <= "00110";
    COD_FUN <= "0011";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '1';
    wait for 10ns;
    --------CPI-----------
    COD_OPC <= "00111";
    COD_FUN <= "1100";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    ------------------------------------------INSTRUCCIONES DE BRINCO CONDICIONAL----------------------------------------------
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '1';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------BEQ (NO SALTO)-----------
    COD_OPC <= "01000";
    COD_FUN <= "1111";
    Z       <= '0';
    C       <= '1';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------BEQ (SALTO)-----------
    COD_OPC <= "01000";
    COD_FUN <= "1111";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    
    
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------BNEQ (NO SALTO)-----------
    COD_OPC <= "01001";
    COD_FUN <= "1011";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    --------BNEQ (SALTO)-----------
    COD_OPC <= "01001";
    COD_FUN <= "1101";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    
    
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '1';
    wait for 10ns;
    --------BLT (NO SALTO)-----------
    COD_OPC <= "01010";
    COD_FUN <= "1110";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '1';
    wait for 10ns;
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    --------BLT (SALTO)-----------
    COD_OPC <= "01010";
    COD_FUN <= "1100";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '0';
    wait for 10ns;
    
    
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '1';
    wait for 10ns;
    --------BLET (NO SALTO)-----------
    COD_OPC <= "01011";
    COD_FUN <= "0011";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '1';
    wait for 10ns;
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '1';
    wait for 10ns;
    --------BLET (SALTO)-----------
    COD_OPC <= "01011";
    COD_FUN <= "0011";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '1';
    wait for 10ns;
    
    
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '1';
    wait for 10ns;
    --------BGT (NO SALTO)-----------
    COD_OPC <= "01100";
    COD_FUN <= "0001";
    Z       <= '1';
    C       <= '0';
    N       <= '0';
    OV      <= '1';
    wait for 10ns;
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '1';
    wait for 10ns;
    --------BGT (SALTO)-----------
    COD_OPC <= "01100";
    COD_FUN <= "0000";
    Z       <= '0';
    C       <= '0';
    N       <= '1';
    OV      <= '1';
    wait for 10ns;
    
    
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------BGET (NO SALTO)-----------
    COD_OPC <= "01101";
    COD_FUN <= "0010";
    Z       <= '0';
    C       <= '0';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------CP-----------
    COD_OPC <= "00000";
    COD_FUN <= "1000";
    Z       <= '1';
    C       <= '1';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;
    --------BGET (SALTO)-----------
    COD_OPC <= "01101";
    COD_FUN <= "0010";
    Z       <= '1';
    C       <= '1';
    N       <= '0';
    OV      <= '0';
    wait for 10ns;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  