LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Synchronous reset flip-flop
ENTITY ff_asynch IS
	PORT (D        : IN STD_LOGIC;
			clk, Rst : IN STD_LOGIC;
			Q        : OUT STD_LOGIC);
END ff_asynch;

ARCHITECTURE Behavior OF ff_asynch IS
BEGIN
	PROCESS (clk, Rst)
	BEGIN
		IF (Rst = '0') THEN
			Q <= '0';
		ELSIF (clk'EVENT AND clk = '1') THEN
			Q <= D;
		END IF;
	END PROCESS;
END Behavior;