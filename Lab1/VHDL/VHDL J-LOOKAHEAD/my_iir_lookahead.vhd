LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- black box
ENTITY my_iir_lookahead IS
	PORT(
		RST_n, CLK : IN STD_LOGIC; -- reset, clock signal
	
		VIN      : IN STD_LOGIC; -- input validation signal
		DIN      : IN STD_LOGIC_VECTOR(17 DOWNTO 0); -- input sample
		
		
		VOUT     : OUT STD_LOGIC; -- output validation signal
		DOUT     : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)); -- result
END my_iir_lookahead;

ARCHITECTURE rtl OF my_iir_lookahead IS

	SIGNAL DIN_tmp, DOUT_tmp: SIGNED(17 DOWNTO 0);

	COMPONENT iir_filter_lookahead IS
	PORT(
		RST_n, CLK : IN STD_LOGIC; -- reset, clock signal
	
		VIN      : IN STD_LOGIC; -- input validation signal
		DIN      : IN SIGNED(17 DOWNTO 0); -- input sample
		
		
		VOUT     : OUT STD_LOGIC; -- output validation signal
		DOUT     : OUT SIGNED(17 DOWNTO 0)); -- result
	END COMPONENT;
	
BEGIN
	filter: iir_filter_lookahead PORT MAP (RST_n => RST_n, CLK => CLK,
				VIN => VIN, DIN => DIN_tmp, VOUT => VOUT, DOUT => DOUT_tmp);
				
	DIN_tmp <= SIGNED(DIN);
	DOUT <= STD_LOGIC_VECTOR(DOUT_tmp);
END ARCHITECTURE;
