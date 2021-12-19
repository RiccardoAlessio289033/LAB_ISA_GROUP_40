LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Synchronous reset flip-flop
ENTITY flipflop IS
	PORT (R        : IN STD_LOGIC;
			Clock, Reset : IN STD_LOGIC;
			Q        : OUT STD_LOGIC);
END flipflop;

ARCHITECTURE Behavior OF flipflop IS
BEGIN
	PROCESS (Clock, Reset)
	BEGIN
		IF (Reset = '0') THEN
			Q <= '0';
		ELSIF (Clock'EVENT AND Clock = '1') THEN
			Q <= R;
		END IF;
	END PROCESS;
END Behavior;