library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity RAM_DIST_tb is
    generic(N_BITS_ADR: INTEGER := 8;
            N_BITS_DIN: INTEGER := 8);
end;

architecture bench of RAM_DIST_tb is

  component RAM_DIST
      generic(N_BITS_ADR: INTEGER := 8;
              N_BITS_DIN: INTEGER := 8);
      Port ( ADR : in STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0);
             DIN : in STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0);
             WR_EN : in STD_LOGIC;
             CLK : in STD_LOGIC;
             DOUT : out STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0));
  end component;

  signal ADR: STD_LOGIC_VECTOR (N_BITS_ADR-1 downto 0);
  signal DIN: STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0);
  signal WR_EN: STD_LOGIC;
  signal CLK: STD_LOGIC;
  signal DOUT: STD_LOGIC_VECTOR (N_BITS_DIN-1 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: RAM_DIST generic map ( N_BITS_ADR => 8,
                              N_BITS_DIN => 8 )
                   port map ( ADR        => ADR,
                              DIN        => DIN,
                              WR_EN         => WR_EN,
                              CLK        => CLK,
                              DOUT       => DOUT );

  stimulus: process
  begin
    DIN     <=X"A2";
    ADR     <=X"23";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"A2";
    ADR     <=X"23";
    WR_EN   <='1';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"13";
    ADR     <=X"24";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"13";
    ADR     <=X"24";
    WR_EN   <='1';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"98";
    ADR     <=X"25";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"98";
    ADR     <=X"25";
    WR_EN   <='1';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"45";
    ADR     <=X"26";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"45";
    ADR     <=X"26";
    WR_EN   <='1';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"32";
    ADR     <=X"23";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"32";
    ADR     <=X"24";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"32";
    ADR     <=X"25";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;
    
    DIN     <=X"32";
    ADR     <=X"26";
    WR_EN   <='0';
    
    WAIT UNTIL RISING_EDGE(CLK) ;

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
