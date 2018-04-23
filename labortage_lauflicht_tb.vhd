library ieee;
use ieee.std_logic_1164.all;

-- leere Entity
entity labortage_lauflicht_tb is
end entity labortage_lauflicht_tb;

architecture behavior of labortage_lauflicht_tb is

  -- Moduldeklaration
  component labortage_lauflicht is
  port(
    clk25	 : in std_logic;
    switch       : in std_logic := '0';
    led_status   : buffer std_logic := '0';
    led_1   : out std_logic := '0';
    led_2   : out std_logic := '0';
    led_3   : out std_logic := '0';
    led_4   : out std_logic := '0'
    );
  end component;

  -- input
  signal clk25  : std_logic := '0';
  signal switch : std_logic := '0';

  -- output
  signal led_status : std_logic := '0';
  signal led_1   : std_logic := '0';
  signal led_2   : std_logic := '0'; 
  signal led_3   : std_logic := '0';
  signal led_4   : std_logic := '0';
 
 begin
  -- 25 MHz Clock "in Software" statt per Hardwarequarz
  clk25 <= not clk25 after 20 ns;

  -- Stimuli
  -- https://www.csee.umbc.edu/portal/help/VHDL/types.html
  switch <= not switch after 4000 ms;
  -- switch <= '0';
	
  -- Modulinstanziierung
  dut : labortage_lauflicht
    port map (
     clk25        => clk25,
     switch       => switch,
     led_status   => led_status,
     led_1        => led_1,
     led_2        => led_2,
     led_3        => led_3,
     led_4        => led_4
    );
end architecture;