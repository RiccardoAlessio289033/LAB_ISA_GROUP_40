LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  FA  IS

    PORT(
        A    : IN STD_LOGIC;
        B    : IN STD_LOGIC;
        Cin  : IN STD_LOGIC;
        S    : OUT STD_LOGIC;
        Cout    : OUT STD_LOGIC
         
    );
END FA;

ARCHITECTURE  sum OF FA IS

SIGNAL Int1_tmp    : STD_LOGIC;
SIGNAL Int2_tmp    : STD_LOGIC;
SIGNAL Int3_tmp    : STD_LOGIC;

BEGIN

Int1_tmp <= A XOR B;
S <= Int1_tmp XOR Cin;
Int2_tmp <= Int1_tmp AND Cin;
Int3_tmp <= A AND B;
Cout <= Int2_tmp XOR Int3_tmp; 
END ARCHITECTURE;