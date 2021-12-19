LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Comb2  IS
    GENERIC ( N : integer:=16);
    PORT(
        Data_A    : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        From_comb1_IN    : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Output    : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
          
    );
END Comb2;

ARCHITECTURE  comb OF Comb2 IS

SIGNAL A_tmp    : STD_LOGIC_VECTOR(22 DOWNTO 0);

BEGIN

A_tmp <= Data_A(21 DOWNTO 0) & '0';

PROCESS (From_comb1_IN)
	BEGIN
	CASE From_comb1_IN IS
	 when "100" => Output <= A_tmp;
	 when "010" => Output <= ( OTHERS => '0');
	 when "001" => Output <=  Data_A(22 DOWNTO 0);
	 when others => Output <= ( OTHERS => '0');
	end case;
End process;

END ARCHITECTURE;