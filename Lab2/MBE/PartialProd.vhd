LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  PartialProd  IS
    PORT(
        X_IN    : IN UNSIGNED(31 DOWNTO 0);
        A_IN    : IN UNSIGNED(31 DOWNTO 0);
        Clk	: IN STD_LOGIC;
        PP_OUT    : OUT STD_LOGIC_VECTOR(22 DOWNTO 0);
	Sign : OUT STD_LOGIC
    );
END PartialProd;

ARCHITECTURE  pro OF PartialProd IS

SIGNAL tmp1    : UNSIGNED (31 DOWNTO 0);
SIGNAL tmp2    : STD_LOGIC_VECTOR (22 DOWNTO 0); --insert N before the simulation
SIGNAL tmp2_unsigned : UNSIGNED(22 DOWNTO 0);
SIGNAL tmp3    : STD_LOGIC_VECTOR (2 DOWNTO 0);
SIGNAL tmp4    : STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL IN_fromDUT2    : UNSIGNED (2 DOWNTO 0);
SIGNAL sign_tmp, ld_tmp	: STD_LOGIC;

COMPONENT Parallel_RegnX  IS
    GENERIC ( N : integer:=16);
    PORT(
        Data_in    : IN UNSIGNED(N-1 DOWNTO 0);
        Data_out    : OUT UNSIGNED(N-1 DOWNTO 0);
        Clk    : IN STD_LOGIC;
        Rst_n    : IN STD_LOGIC;
		  Load    : IN STD_LOGIC);
END COMPONENT;

COMPONENT Regn IS
	GENERIC ( N : integer:=16);
	PORT (R : IN UNSIGNED(N-1 DOWNTO 0); -- input
		Clock, Reset, Load : IN STD_LOGIC; -- clock, reset, load signals
		Q : OUT UNSIGNED(22 DOWNTO 0)); -- output
END COMPONENT;

COMPONENT cmp_cnt_mpx IS
	PORT (CK   : IN STD_LOGIC;
			D_in : IN UNSIGNED(31 DOWNTO 0);
			
			LD    : OUT STD_LOGIC;
			D_out : OUT UNSIGNED(2 DOWNTO 0)
			);
END COMPONENT;

COMPONENT Comb1  IS
    
    PORT(
        Input    : IN UNSIGNED(2 DOWNTO 0);
        Output    : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  S		: OUT STD_LOGIC
            
    );
END COMPONENT;

COMPONENT Comb2  IS
    GENERIC ( N : integer:=16);
    PORT(
        Data_A    : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        From_comb1_IN    : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Output    : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
          
    );
END COMPONENT;

COMPONENT Comb3  IS
    GENERIC ( N : integer:=16);
    PORT(
        Data_IN    : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        S    : IN STD_LOGIC;
        Data_OUT    : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
END COMPONENT;



BEGIN

DUT1 : Parallel_RegnX GENERIC MAP (N => 32) PORT MAP (Data_in => X_IN, Data_out => tmp1, 
					Clk => Clk, Rst_n => '1', Load => ld_tmp);	
DUT2 : cmp_cnt_mpx PORT MAP (CK => Clk, D_in => tmp1, LD => ld_tmp, D_out => IN_fromDUT2);		

DUT3 : Regn GENERIC MAP (N => 32) PORT MAP (R => A_IN, Clock => Clk, Reset => '1', Load => ld_tmp, 
					Q => tmp2_unsigned);
tmp2 <= STD_LOGIC_VECTOR(tmp2_unsigned);

DUT4 : Comb1 PORT MAP (Input => IN_fromDUT2, Output => tmp3, S => sign_tmp); 
DUT5 : Comb2 GENERIC MAP (N => 23) PORT MAP (Data_A => tmp2, From_comb1_IN => tmp3, Output => tmp4);
DUT6 : Comb3 GENERIC MAP (N => 23) PORT MAP (Data_IN => tmp4, S => sign_tmp, Data_OUT => PP_OUT);

Sign <= sign_tmp;

END ARCHITECTURE;