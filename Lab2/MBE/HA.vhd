LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  HA  IS

    PORT(
        A    : IN STD_LOGIC;
        B    : IN STD_LOGIC;
        S    : OUT STD_LOGIC;
        Cout    : OUT STD_LOGIC

    );
END HA;

ARCHITECTURE  sum OF HA IS


BEGIN
Cout <= A AND B;
S <= A XOR B;

END ARCHITECTURE;