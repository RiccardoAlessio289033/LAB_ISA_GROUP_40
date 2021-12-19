LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Parallel_RegnX  IS
    GENERIC ( N : integer:=16);
    PORT(
        Data_in    : IN UNSIGNED(N-1 DOWNTO 0);
        Data_out    : OUT UNSIGNED(N-1 DOWNTO 0);
        Clk    : IN STD_LOGIC;
        Rst_n    : IN STD_LOGIC;
		  Load    : IN STD_LOGIC
    );
END Parallel_RegnX;

ARCHITECTURE  reg OF Parallel_RegnX IS

BEGIN

PROCESS (Clk, Rst_n)
	begin
		if Rst_n = '0' then
			Data_out <= ( others => '0');

		elsif (Clk'event and Clk = '1') then
			if(Load = '1') then
				Data_out <= Data_in;
			end if;
		end if;

end PROCESS;


END ARCHITECTURE;