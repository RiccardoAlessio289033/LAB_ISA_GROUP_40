LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- N-bit register (positive edge triggered)
ENTITY Regn IS
	GENERIC ( N : integer:=18);
	PORT (R : IN SIGNED(N-1 DOWNTO 0); -- input
			Clock, Reset, Load : IN STD_LOGIC; -- clock, reset, load signals
			Q : OUT SIGNED(N-1 DOWNTO 0)); -- output
END Regn;

ARCHITECTURE Behavior OF Regn IS

BEGIN

	PROCESS (Clock, Reset)
	BEGIN
		IF (Reset = '0') THEN -- asynchronous reset
			Q <= (OTHERS => '0');
		ELSIF (Clock'EVENT AND Clock = '1') THEN -- positive edge detection
			IF (Load='1') THEN -- load request
				Q <= R;
			END IF;
		END IF;
	END PROCESS;
	
END Behavior;