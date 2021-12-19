LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- MBE multiplier component: triplete selector
ENTITY cmp_cnt_mpx IS
	PORT (CK   : IN STD_LOGIC;
			D_in : IN UNSIGNED(31 DOWNTO 0);
			
			LD    : OUT STD_LOGIC;
			D_out : OUT UNSIGNED(2 DOWNTO 0)
			);
END cmp_cnt_mpx;

ARCHITECTURE structure OF cmp_cnt_mpx IS

	SIGNAL Data : UNSIGNED(26 DOWNTO 0);
	SIGNAL sel : UNSIGNED(3 DOWNTO 0);
	SIGNAL out_mpx : UNSIGNED(2 DOWNTO 0);
	SIGNAL out_cnt : UNSIGNED(3 DOWNTO 0);
	SIGNAL rst : STD_LOGIC;
	SIGNAL out_cmp12, out_cmp0 : STD_LOGIC;
	
BEGIN
	Data(26) <= '0';
	Data(25) <= '0';
	Data(24) <= '0';
	Data(23 DOWNTO 1) <= D_in(22 DOWNTO 0);
	Data(0) <= '0';

	-- Multiplexer (16 inputs, 3 bits):
	mpx: PROCESS (sel, Data)
	BEGIN
		CASE sel IS
			WHEN "0000" => out_mpx <= Data(24 DOWNTO 22); --0
			WHEN "0001" => out_mpx <= Data(26	DOWNTO 24);
			WHEN "0010" => out_mpx <= Data(2 DOWNTO 0); --2
			WHEN "0011" => out_mpx <= Data(4 DOWNTO 2);
			WHEN "0100" => out_mpx <= Data(6 DOWNTO 4); --4
			WHEN "0101" => out_mpx <= Data(8 DOWNTO 6);
			WHEN "0110" => out_mpx <= Data(10 DOWNTO 8);
			WHEN "0111" => out_mpx <= Data(12 DOWNTO 10);
			WHEN "1000" => out_mpx <= Data(14 DOWNTO 12); --8
			WHEN "1001" => out_mpx <= Data(16 DOWNTO 14);
			WHEN "1010" => out_mpx <= Data(18 DOWNTO 16);
			WHEN "1011" => out_mpx <= Data(20 DOWNTO 18);
			WHEN "1100" => out_mpx <= Data(22 DOWNTO 20); --12
			WHEN OTHERS => out_mpx <= "000";
		END CASE;
	END PROCESS;
	
	D_out <= out_mpx;
	
	-- Counter:
	cnt: PROCESS (CK)
		VARIABLE out_cnt_tmp : INTEGER := 0;
	BEGIN
		IF (CK'EVENT AND CK = '1') THEN
			IF rst = '1' THEN -- synchronous reset
				out_cnt_tmp := 0;
			ELSE
				out_cnt_tmp := out_cnt_tmp + 1;
			END IF;
		END IF;
		
		out_cnt <= TO_UNSIGNED(out_cnt_tmp, out_cnt'LENGTH);
	END PROCESS;
	
	sel <= out_cnt;
	
	-- Comparator (IN = 12):
	cmp12: PROCESS (out_cnt)
	BEGIN
		IF out_cnt = "1100" THEN
			out_cmp12 <= '1';
		ELSE
			out_cmp12 <= '0';
		END IF;
	END PROCESS;
	
	-- Comparator (IN = 0):
	
	cmp0: PROCESS (out_cnt)
	BEGIN
		IF out_cnt = "0000" THEN
			out_cmp0 <= '1';
		ELSE
			out_cmp0 <= '0';
		END IF;
		LD <= out_cmp0 AFTER 1 ns;
	END PROCESS;
	
	rst <= out_cmp12;
	--LD <= out_cmp0;
	
END structure;