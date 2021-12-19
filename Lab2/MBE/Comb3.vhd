LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Comb3  IS
    GENERIC ( N : integer:=16);
    PORT(
        Data_IN    : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        S    : IN STD_LOGIC;
        Data_OUT    : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END Comb3;

ARCHITECTURE  comb OF Comb3 IS

SIGNAL Int_tmp    : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN


generate_label : FOR i IN 0 TO N-1 generate
	Int_tmp(i) <= S XOR Data_IN(i);
	
End generate;

Data_OUT <= Int_tmp;


END ARCHITECTURE;