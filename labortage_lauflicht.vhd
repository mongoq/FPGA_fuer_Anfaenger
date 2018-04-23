library ieee;
use ieee.std_logic_1164.all;

entity labortage_lauflicht is
  port(
    clk25	   : in std_logic; -- 25 MHz Quarzoszillator
    switch     : in std_logic := '0'; -- Ein- / Ausschalter (invertiert)
    led_status : buffer std_logic := '0'; -- grüne LED
    led_1 : out std_logic := '0';  -- rote LEDs
    led_2 : out std_logic := '0';
    led_3 : out std_logic := '0';
    led_4 : out std_logic := '0'
    );
end labortage_lauflicht;

architecture behavior of labortage_lauflicht is

signal clkcnt : integer range 0 to 12500000 := 0; -- 12.500.000 Ticks ==> 1/2 Sekunde bei 25 MHz
signal ledcnt : integer range 0 to 6 := 0;

begin

process (clk25) is
  begin
    if rising_edge(clk25) then
      
		-- Counter halbsekündlich hochzählen und auf Null zurücksetzen
	   if (clkcnt < 12500000) then
        clkcnt <= clkcnt + 1;
	   else 
	     clkcnt <= 0;
      end if;
      
		-- LED Lauflicht Statemachine
	   if (clkcnt = 0) and (not switch = '1') then -- Switch (in Hardware invertiert)
        ledcnt     <= ledcnt + 1; -- LED weiterschalten
        led_status <= not led_status; -- Grüne Status LED blinken lassen
	     led_1 <= '0'; -- Alle roten LEDs ausschalten
        led_2 <= '0';
        led_3 <= '0';
        led_4 <= '0';
	     case ledcnt is
		    when 0 => led_1  <= '1'; -- LED 1 an
		    when 1 => led_2  <= '1'; -- LED 2 an
		    when 2 => led_3  <= '1'; -- LED 3 an
		    when 3 => led_4  <= '1'; -- LED 4 an
		    when 4 => led_3  <= '1'; -- LED 3 an
		    when 5 => led_2  <= '1'; -- LED 2 an
		              ledcnt <= 0;   -- LED 1 an
	     	 when others => null; -- Nichts tun
	     end case;
      end if;  
		
    end if;
  end process;

end behavior;