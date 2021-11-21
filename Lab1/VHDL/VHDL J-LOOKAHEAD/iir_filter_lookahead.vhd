LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- IIR filter in lookahead_1 diretct form II(12 bits)
ENTITY iir_filter_lookahead IS
         PORT(
		RST_n, CLK : IN STD_LOGIC; -- reset, clock signal
	
		VIN      : IN STD_LOGIC; -- input validation signal
		DIN      : IN SIGNED(17 DOWNTO 0); -- input sample
		
		
		VOUT     : OUT STD_LOGIC; -- output validation signal
		DOUT     : OUT SIGNED(17 DOWNTO 0)); -- result
END iir_filter_lookahead;

ARCHITECTURE RTL OF iir_filter_lookahead IS
        
          SIGNAL a1, a2, b0, b1, b2 , b3: SIGNED(17 DOWNTO 0);
	   --SIGNAL DIN_ext : SIGNED(11 DOWNTO 0);
          SIGNAL ff1_out, ff2_out: STD_LOGIC; --ff2_out, ff3_out, ff4_out, ff5_out, ff6_out, ff7_out: STD_LOGIC;
          SIGNAL DIN_del : SIGNED(17 DOWNTO 0);
          SIGNAL add1_out, add2_out, add3_out, add4_out, add5_out: SIGNED(17 DOWNTO 0);
          SIGNAL reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out: SIGNED(17 DOWNTO 0);
          SIGNAL add1_out_tmp, add2_out_tmp, add3_out_tmp, add4_out_tmp, add5_out_tmp: SIGNED(18 DOWNTO 0);
	  SIGNAL mul_a1_out, mul_a2_out, mul_b0_out,
				mul_b1_out, mul_b2_out, mul_b3_out : SIGNED(17 DOWNTO 0);
	  SIGNAL mul_a1_out_tmp, mul_a2_out_tmp, mul_b0_out_tmp,
				mul_b1_out_tmp, mul_b2_out_tmp, mul_b3_out_tmp : SIGNED(35 DOWNTO 0);
	  SIGNAL VIN_del: STD_LOGIC;

          COMPONENT ff_asynch IS
		  PORT (
                        D        : IN STD_LOGIC;
			clk, Rst : IN STD_LOGIC;
			Q        : OUT STD_LOGIC);
	  END COMPONENT;
	
          COMPONENT signed_sum_Nbit is
		GENERIC ( N : integer:=18);
		  PORT(
			A            : IN SIGNED (N-1 DOWNTO 0); -- 1st addendum
			B            : IN SIGNED (N-1 DOWNTO 0); -- 2nd addendum
			add_sub      : IN STD_LOGIC; -- operation selector
			
			C	     : OUT SIGNED (N DOWNTO 0)); -- sum   --ricontrollare
	  END COMPONENT;

	  COMPONENT Regn IS
	  GENERIC ( N : integer:=18);
	          PORT (
                        R : IN SIGNED(N-1 DOWNTO 0); -- input
			Clock, Reset, Load : IN STD_LOGIC; -- clock, reset, load signals
			Q : OUT SIGNED(N-1 DOWNTO 0)); -- output
	  END COMPONENT;
	
	  COMPONENT signed_mult_Nbit IS
		GENERIC (N : integer:=18);
		  PORT (
			A	: IN SIGNED (N-1 DOWNTO 0); -- 1st operand
			B	: IN SIGNED (N-1 DOWNTO 0); -- 2nd operand
			C	: OUT SIGNED (2*N-1 DOWNTO 0)); -- product
	  END COMPONENT;
	
BEGIN
          -- CONSTANTS (18 bits):
        
          a1 <= "000101010001001001"; --a1=a1(o)*a1(o)-a2(o)=21557  o--original
          a2 <= "111110001000100100"; --a2=a1(o)*a2(o)=-7644
          b0 <= "000000000000001000"; --b0=b0(o)=8
          b1 <= "000000010010101001"; --b1=b1(o)-a1(o)*b0(o)=1193
          b2 <= "000000100111001011"; --b2=b2(o)-a1(o)*b1(o)=2507
          b3 <= "111111101101101000"; --b3=a1(o)*b2(o)=-1176


          -- VALIDATION SIGNAL GENERATOR

          -- 1st flip-flop:
          ff1: ff_asynch PORT MAP (D => VIN, clk => CLK, Rst => RST_n, Q => ff1_out);


          -- 2nd flip-flop:
	  ff2: ff_asynch PORT MAP (D => ff1_out, clk => CLK, Rst => RST_n, Q => ff2_out);


          -- 3rd flip-flop:
	  ff3: ff_asynch PORT MAP (D => ff2_out, clk => CLK, Rst => RST_n, Q => VOUT);
	
             
	  -- INPUT AND OUTPUT REGISTERS:
	
	  -- input register:
	  reg_in: Regn GENERIC MAP (N => 18) PORT MAP (R => DIN, Clock => CLK,
				Reset => RST_n, Load => VIN, Q => DIN_del);
	
	  -- output register:
	  reg_out: Regn GENERIC MAP (N => 18) PORT MAP (R => add3_out(17 DOWNTO 0), Clock => CLK,
				Reset => RST_n, Load => ff2_out, Q => DOUT);

          
	  -- ADDERS:
				
	  -- 1st adder
	  add1: signed_sum_Nbit GENERIC MAP (N => 18) PORT MAP (A => DIN_del,
			B => reg1_out, add_sub => '0', C => add1_out_tmp); -- MSB truncation --controllare 11 downto 0
			add1_out <= add1_out_tmp(17 downto 0);
			
	  -- 2nd adder:
	  add2: signed_sum_Nbit GENERIC MAP (N => 18) PORT MAP (A => mul_a1_out,
			B => mul_a2_out, add_sub => '0', C => add2_out_tmp); -- MSB truncation
			add2_out <= add2_out_tmp(17 downto 0);
			
	  -- 3rd adder:
	  add3: signed_sum_Nbit GENERIC MAP (N => 18) PORT MAP (A => reg4_out,
			B => reg7_out, add_sub => '0', C => add3_out_tmp); -- MSB truncation
			add3_out <= add3_out_tmp(17 downto 0);
			
	  -- 4th adder: 
	  add4: signed_sum_Nbit GENERIC MAP (N => 18) PORT MAP (A => mul_b1_out,
			B => add5_out, add_sub => '0', C => add4_out_tmp); -- MSB truncation
			add4_out <= add4_out_tmp(17 downto 0);			
	  -- 5th adder: 
	  add5: signed_sum_Nbit GENERIC MAP (N => 18) PORT MAP (A => reg5_out,
			B => reg6_out, add_sub => '1', C => add5_out_tmp); -- MSB truncation
			add5_out <= add5_out_tmp(17 downto 0);		


	  -- MULTIPLICATORS:
	
	  -- b0 moltiplicator
	  mul_b0: signed_mult_Nbit GENERIC MAP (N => 18) PORT MAP (A => add1_out,
				B => b0, C => mul_b0_out_tmp); 
	  mul_b0_out <= mul_b0_out_tmp(35 DOWNTO 18); -- 16 bits truncation
	
	  -- b1 multiplicator:
	  mul_b1: signed_mult_Nbit GENERIC MAP (N => 18) PORT MAP (A => reg2_out,
				B => b1, C => mul_b1_out_tmp); 
	  mul_b1_out <= mul_b1_out_tmp(35 DOWNTO 18); -- 16 bits truncation
	
	  -- b2 multiplicator:
	  mul_b2: signed_mult_Nbit GENERIC MAP (N => 18) PORT MAP (A => reg2_out,
				B => b2, C => mul_b2_out_tmp); 
	  mul_b2_out <= mul_b2_out_tmp(35 DOWNTO 18); -- 16 bits truncation

          -- b3 multiplicator:
	  mul_b3: signed_mult_Nbit GENERIC MAP (N => 18) PORT MAP (A => reg3_out,
				B => b3, C => mul_b3_out_tmp); 
	  mul_b3_out <= mul_b3_out_tmp(35 DOWNTO 18); -- 16 bits truncation

	  -- a1 multiplicator:
	  mul_a1: signed_mult_Nbit GENERIC MAP (N => 18) PORT MAP (A => reg2_out,
				B => a1, C => mul_a1_out_tmp); 
	  mul_a1_out <= mul_a1_out_tmp(35 DOWNTO 18); -- 16 bits truncation

	  -- a2 multiplicator:
	  mul_a2: signed_mult_Nbit GENERIC MAP (N => 18) PORT MAP (A => reg3_out,
				B => a2, C => mul_a2_out_tmp); 
	  mul_a2_out <= mul_a2_out_tmp(35 DOWNTO 18); -- 16 bits truncation
	
	
	  -- INTERNAL REGISTERS:
	
          -- 1st register:
	  reg1: Regn GENERIC MAP (N => 18) PORT MAP (R => add2_out,   Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg1_out);
			
	  -- 2nd register:
	  reg2: Regn GENERIC MAP (N => 18) PORT MAP (R => add1_out,   Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg2_out);
			
	  -- 3rd register:
	  reg3: Regn GENERIC MAP (N => 18) PORT MAP (R => reg2_out, Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg3_out);

	  -- 4th register:
	  reg4: Regn GENERIC MAP (N => 18) PORT MAP (R => mul_b0_out, Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg4_out);
			
	  -- 5th register:
	  reg5: Regn GENERIC MAP (N => 18) PORT MAP (R => mul_b2_out, Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg5_out);

	  -- 6th register:
	  reg6: Regn GENERIC MAP (N => 18) PORT MAP (R => mul_b3_out, Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg6_out);
	
	  -- 7th register:
	  reg7: Regn GENERIC MAP (N => 18) PORT MAP (R => add4_out, Clock => CLK,
			Reset => RST_n, Load => '1', Q => reg7_out);



END rtl;
