LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Comb1  IS
    
    PORT(
        Input    : IN UNSIGNED(2 DOWNTO 0);
        Output    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  S		: OUT STD_LOGIC
            
    );
END Comb1;

ARCHITECTURE  comb OF Comb1 IS

SIGNAL MSB_tmp    : STD_LOGIC;
SIGNAL INT_tmp    : STD_LOGIC;
SIGNAL LSB_tmp, S1, S2, S3    : STD_LOGIC;

BEGIN

	MSB_tmp <= Input(2);
	INT_tmp <= Input(1);
	LSB_tmp <= Input(0);

	S1 <= MSB_tmp XOR INT_tmp;
	S2 <= NOT(MSB_tmp XOR INT_tmp);
	S3 <= NOT(LSB_tmp XOR INT_tmp);

	Output(0) <= LSB_tmp XOR INT_tmp;
	Output(1) <= S2 AND S3;
	Output(2) <= S1 AND S3;
	S <= MSB_tmp;

END ARCHITECTURE;