LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- IIR filter in direct form II (2nd order, 12 bits)
ENTITY iir_filter_directii IS
	PORT(
		RST_n, CLK : IN STD_LOGIC; -- reset, clock signal
	
		VIN      : IN STD_LOGIC; -- input validation signal
		DIN      : IN SIGNED(11 DOWNTO 0); -- input sample
		
		
		VOUT     : OUT STD_LOGIC; -- output validation signal
		DOUT     : OUT SIGNED(11 DOWNTO 0)); -- result
END iir_filter_directii;

ARCHITECTURE rtl OF iir_filter_directii IS

	SIGNAL a1, a2, b0, b1, b2 : SIGNED(11 DOWNTO 0);
	--SIGNAL DIN_ext : SIGNED(11 DOWNTO 0);
	SIGNAL ff1_out, ff2_out, ff3_out : STD_LOGIC;
	SIGNAL DIN_del : SIGNED(11 DOWNTO 0);
	SIGNAL add1_out, add2_out, add3_out, add4_out: SIGNED(11 DOWNTO 0);
	SIGNAL reg1_out, reg2_out: SIGNED(11 DOWNTO 0);
	SIGNAL add1_out_tmp, add2_out_tmp, add3_out_tmp, add4_out_tmp: SIGNED(12 DOWNTO 0);
	SIGNAL mul_a1_out, mul_a2_out, mul_b0_out,
				mul_b1_out, mul_b2_out : SIGNED(11 DOWNTO 0);
	SIGNAL mul_a1_out_tmp, mul_a2_out_tmp, mul_b0_out_tmp,
				mul_b1_out_tmp, mul_b2_out_tmp : SIGNED(23 DOWNTO 0);
	SIGNAL VIN_del: STD_LOGIC;

	COMPONENT ff_asynch IS
		PORT (D        : IN STD_LOGIC;
			clk, Rst : IN STD_LOGIC;
			Q        : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT signed_sum_Nbit is
		GENERIC ( N : integer:=20);
		PORT(
			A            : IN SIGNED (N-1 DOWNTO 0); -- 1st addendum
			B            : IN SIGNED (N-1 DOWNTO 0); -- 2nd addendum
			add_sub      : IN STD_LOGIC; -- operation selector
			
			C			    : OUT SIGNED (N DOWNTO 0)); -- sum   --ricontrollare
	END COMPONENT;

	COMPONENT Regn IS
	GENERIC ( N : integer:=12);
	PORT (R : IN SIGNED(N-1 DOWNTO 0); -- input
			Clock, Reset, Load : IN STD_LOGIC; -- clock, reset, load signals
			Q : OUT SIGNED(N-1 DOWNTO 0)); -- output
	END COMPONENT;
	
	COMPONENT signed_mult_Nbit IS
		GENERIC (N : integer:=20);
		PORT 
		(
			A	: IN SIGNED (N-1 DOWNTO 0); -- 1st operand
			B	: IN SIGNED (N-1 DOWNTO 0); -- 2nd operand
			C	: OUT SIGNED (2*N-1 DOWNTO 0)); -- product
	END COMPONENT;
	

BEGIN
	-- CONSTANTS (12 bits):
	
	a1 <= "111101101101"; -- a1 = -147
	a2 <= "000000110100"; -- a2 = 52
	b0 <= "000000001000"; -- b0 = 8
	b1 <= "000000010001"; -- b1 = 17
	b2 <= "000000001000"; -- b2 = 8

	
	
	-- VALIDATION SIGNAL GENERATOR:
	
	-- 1st flip-flop:
	ff1: ff_asynch PORT MAP (D => VIN, clk => CLK, Rst => RST_n, Q => ff1_out);
	
	-- 2nd flip-flop:
	ff2: ff_asynch PORT MAP (D => ff1_out, clk => CLK, Rst => RST_n, Q => ff2_out);
	
	-- 3rd flip-flop:
	ff3: ff_asynch PORT MAP (D => ff2_out, clk => CLK, Rst => RST_n, Q => ff3_out);
	
	-- 4rd flip-flop:
	ff4: ff_asynch PORT MAP (D => ff3_out, clk => CLK, Rst => RST_n, Q => VOUT);

	
	
	-- INPUT AND OUTPUT REGISTERS:
	
	-- input register:
	reg_in: Regn GENERIC MAP (N => 12) PORT MAP (R => DIN, Clock => CLK,
				Reset => RST_n, Load => VIN, Q => DIN_del);
	
	-- output register:
	reg_out: Regn GENERIC MAP (N => 12) PORT MAP (R => add3_out(11 DOWNTO 0), Clock => CLK,
				Reset => RST_n, Load => ff3_out, Q => DOUT);
				
				
	-- ADDERS:
				
	--1st adder
	add1: signed_sum_Nbit GENERIC MAP (N => 12) PORT MAP (A => DIN_del,
			B => add2_out, add_sub => '1', C => add1_out_tmp); -- MSB truncation --controllare 11 downto 0
			add1_out <= add1_out_tmp(11 downto 0);
			
	-- 2nd adder:
	add2: signed_sum_Nbit GENERIC MAP (N => 12) PORT MAP (A => mul_a1_out,
			B => mul_a2_out, add_sub => '0', C => add2_out_tmp); -- MSB truncation
			add2_out <= add2_out_tmp(11 downto 0);
			
	-- 3st adder:
	add3: signed_sum_Nbit GENERIC MAP (N => 12) PORT MAP (A => mul_b0_out,
			B => add4_out, add_sub => '0', C => add3_out_tmp); -- MSB truncation
			add3_out <= add3_out_tmp(11 downto 0);
			
	-- 4th adder: 
	add4: signed_sum_Nbit GENERIC MAP (N => 12) PORT MAP (A => mul_b1_out,
			B => mul_b2_out, add_sub => '0', C => add4_out_tmp); -- MSB truncation
			add4_out <= add4_out_tmp(11 downto 0);
	
	
	-- MULTIPLICATORS:
	
	-- b0 moltiplicator
	mul_b0: signed_mult_Nbit GENERIC MAP (N => 12) PORT MAP (A => add1_out,
				B => b0, C => mul_b0_out_tmp); 
	mul_b0_out <= mul_b0_out_tmp(22 DOWNTO 11); -- 12 bits truncation
	
	-- b1 multiplicator:
	mul_b1: signed_mult_Nbit GENERIC MAP (N => 12) PORT MAP (A => reg1_out,
				B => b1, C => mul_b1_out_tmp); 
	mul_b1_out <= mul_b1_out_tmp(22 DOWNTO 11); -- 12 bits truncation
	
	-- b2 multiplicator:
	mul_b2: signed_mult_Nbit GENERIC MAP (N => 12) PORT MAP (A => reg2_out,
				B => b2, C => mul_b2_out_tmp); 
	mul_b2_out <= mul_b2_out_tmp(22 DOWNTO 11); -- 12 bits truncation
	
	-- a1 multiplicator:
	mul_a1: signed_mult_Nbit GENERIC MAP (N => 12) PORT MAP (A => reg1_out,
				B => a1, C => mul_a1_out_tmp); 
	mul_a1_out <= mul_a1_out_tmp(22 DOWNTO 11); -- 12 bits truncation

	-- a2 multiplicator:
	mul_a2: signed_mult_Nbit GENERIC MAP (N => 12) PORT MAP (A => reg2_out,
				B => a2, C => mul_a2_out_tmp); 
	mul_a2_out <= mul_a2_out_tmp(22 DOWNTO 11); -- 12 bits truncation
	
	
	-- INTERNAL REGISTERS:
	
	-- 1st register:
	reg1: Regn GENERIC MAP (N => 12) PORT MAP (R => add1_out, Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg1_out);
			
	-- 2nd register:
	reg2: Regn GENERIC MAP (N => 12) PORT MAP (R => reg1_out, Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg2_out);

	

	
	
END rtl;
	
	
	
	
	