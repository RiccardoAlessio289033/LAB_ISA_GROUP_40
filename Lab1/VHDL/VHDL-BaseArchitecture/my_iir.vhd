LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- black box
ENTITY my_iir IS
	PORT(
		RST_n, CLK : IN STD_LOGIC; -- reset, clock signal
	
		VIN      : IN STD_LOGIC; -- input validation signal
		DIN      : IN STD_LOGIC_VECTOR(11 DOWNTO 0); -- input sample
		
		
		VOUT     : OUT STD_LOGIC; -- output validation signal
		DOUT     : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)); -- result
END my_iir;

ARCHITECTURE rtl OF my_iir IS

	SIGNAL DIN_tmp, DOUT_tmp: SIGNED(11 DOWNTO 0);

	COMPONENT iir_filter_directii IS
	PORT(
		RST_n, CLK : IN STD_LOGIC; -- reset, clock signal
	
		VIN      : IN STD_LOGIC; -- input validation signal
		DIN      : IN SIGNED(11 DOWNTO 0); -- input sample
		
		
		VOUT     : OUT STD_LOGIC; -- output validation signal
		DOUT     : OUT SIGNED(11 DOWNTO 0)); -- result
	END COMPONENT;
	
BEGIN
	filter: iir_filter_directii PORT MAP (RST_n => RST_n, CLK => CLK,
				VIN => VIN, DIN => DIN_tmp, VOUT => VOUT, DOUT => DOUT_tmp);
				
	DIN_tmp <= SIGNED(DIN);
	DOUT <= STD_LOGIC_VECTOR(DOUT_tmp);
END ARCHITECTURE;
