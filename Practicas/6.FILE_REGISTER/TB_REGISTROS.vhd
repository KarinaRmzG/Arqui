----------------------------------------------------------------------------------
-- @KARY
-- Proyecto: File Register
----------------------------------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity REGISTROS_tb is
    GENERIC (
          N_BITS_ADR : INTEGER := 2;
          N_BITS_DIN : INTEGER := 8
      );
end;

architecture bench of REGISTROS_tb is

  component REGISTROS
      generic(N_BITS_ADR: INTEGER := 2;
              N_BITS_DIN: INTEGER := 8);
      Port ( WR_REG, RD_REG1, RD_REG2 : in STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0);
             WR_DATA : in STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0);
             WR : in STD_LOGIC;
             CLK : in STD_LOGIC;
             RD_DATA1, RD_DATA2 : out STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0));
  end component;

  signal WR_REG, RD_REG1, RD_REG2: STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0);
  signal WR_DATA: STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0);
  signal WR: STD_LOGIC;
  signal CLK: STD_LOGIC;
  signal RD_DATA1, RD_DATA2: STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: REGISTROS generic map ( N_BITS_ADR => 2,
                               N_BITS_DIN => 8 )
                    port map ( WR_REG     => WR_REG,
                               RD_REG1    => RD_REG1,
                               RD_REG2    => RD_REG2,
                               WR_DATA    => WR_DATA,
                               WR         => WR,
                               CLK        => CLK,
                               RD_DATA1   => RD_DATA1,
                               RD_DATA2   => RD_DATA2 );

  stimulus: process
  begin
  
    RD_REG1     <= "00";
    RD_REG2     <= "00"; 
    WR_REG      <= "00";
    WR_DATA     <= X"45";
    WR          <= '1';
    
    WAIT UNTIL rising_edge(CLK);
    
    RD_REG1     <= "00";
    RD_REG2     <= "00"; 
    WR_REG      <= "01";
    WR_DATA     <= X"23";
    WR          <= '1';
    
    WAIT UNTIL rising_edge(CLK);
    
    RD_REG1     <= "00";
    RD_REG2     <= "01"; 
    WR_REG      <= "10";
    WR_DATA     <= X"76";
    WR          <= '1';
    
    WAIT UNTIL rising_edge(CLK);
    
    RD_REG1     <= "01";
    RD_REG2     <= "10"; 
    WR_REG      <= "11";
    WR_DATA     <= X"18";
    WR          <= '1';
    
    WAIT UNTIL rising_edge(CLK);
    
    RD_REG1     <= "00";
    RD_REG2     <= "01"; 
    WR_REG      <= "00";
    WR_DATA     <= X"00";
    WR          <= '0';
    
    WAIT UNTIL rising_edge(CLK);
    
    RD_REG1     <= "10";
    RD_REG2     <= "11"; 
    WR_REG      <= "00";
    WR_DATA     <= X"00";
    WR          <= '0';
    
    WAIT UNTIL rising_edge(CLK);

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


