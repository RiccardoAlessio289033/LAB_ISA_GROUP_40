LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY signed_mult_Nbit IS
	GENERIC (N : integer:=20);
	PORT 
	(
		A	: IN SIGNED (N-1 DOWNTO 0); -- 1st operand
		B	: IN SIGNED (N-1 DOWNTO 0); -- 2nd operand
		C	: OUT SIGNED (2*N-1 DOWNTO 0) -- product
	);

END ENTITY;

ARCHITECTURE behaviour OF signed_mult_Nbit IS
BEGIN
	C <= A * B;
	
END behaviour;
