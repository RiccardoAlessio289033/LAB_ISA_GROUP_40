library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY signed_sum_Nbit is
	GENERIC ( N : integer:=20);
	PORT(
			A            : IN SIGNED (N-1 DOWNTO 0); -- 1st addendum
			B            : IN SIGNED (N-1 DOWNTO 0); -- 2nd addendum
			add_sub      : IN STD_LOGIC; -- operation selector
		
			C			    : OUT SIGNED (N DOWNTO 0)); -- sum/difference
END ENTITY;

ARCHITECTURE rtl OF signed_sum_Nbit IS
	SIGNAL A_ext, B_ext: SIGNED(N DOWNTO 0);
BEGIN
	
	A_ext(N-1 DOWNTO 0) <= A;
	A_ext(N) <= A(N-1);
	B_ext(N-1 DOWNTO 0) <= B;
	B_ext(N) <= A(N-1);

	PROCESS(A_ext, B_ext, add_sub)

	BEGIN
		
		IF (add_sub = '0') THEN -- sum
			C <= A_ext + B_ext;
		ELSE -- subtraction
			C <= A_ext - B_ext;
		END IF;

	END PROCESS;
	
END rtl;
