LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  MBE  IS
    PORT(
        B_IN    : IN UNSIGNED(31 DOWNTO 0);
        A_IN    : IN UNSIGNED(31 DOWNTO 0);
        Clk	: IN STD_LOGIC;
        Result    : OUT STD_LOGIC_VECTOR(45 DOWNTO 0)
    );
END MBE;

ARCHITECTURE  mat1 OF MBE IS

---SIGNALS
SIGNAL Out_DUT1 : UNSIGNED(22 DOWNTO 0);
SIGNAL Out_DUT1_slv : STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL sign_tmp : STD_LOGIC;
SIGNAL DUT2_out1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL DUT2_out2, DUT2_out3, DUT2_out4 : STD_LOGIC_VECTOR(44 DOWNTO 0);
SIGNAL DUT2_out5 : STD_LOGIC_VECTOR(40 DOWNTO 0);
SIGNAL DUT2_out6 : STD_LOGIC_VECTOR(36 DOWNTO 0);
SIGNAL DUT2_out7 : STD_LOGIC_VECTOR(32 DOWNTO 0);
SIGNAL DUT2_out8 : STD_LOGIC_VECTOR(28 DOWNTO 0);
SIGNAL DUT2_out9 : STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL DUT2_out10 : STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL DUT2_out11 : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAL DUT2_out12 : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL DUT2_out13 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL DUT2_out14 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL DUT2_OUT15 : STD_LOGIC;

SIGNAL DUT3_out1, DUT3_out2, DUT3_out3 : STD_LOGIC_VECTOR(28 DOWNTO 0);
SIGNAL DUT3_out4 : STD_LOGIC_VECTOR(25 DOWNTO 0);
SIGNAL DUT3_out5 : STD_LOGIC_VECTOR(21 DOWNTO 0);
SIGNAL DUT3_out6 : STD_LOGIC_VECTOR(20 DOWNTO 0);
SIGNAL DUT3_out7 : STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL DUT3_out8 : STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL DUT3_out9 : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL DUT3_out10 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL DUT3_out11 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL DUT3_out12 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL DUT3_out13 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL DUT3_out14 : STD_LOGIC_VECTOR(105 DOWNTO 0);

SIGNAL DUT4_out1, DUT4_out2, DUT4_out3 : STD_LOGIC_VECTOR(16 DOWNTO 0);
SIGNAL DUT4_out4 : STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL DUT4_out5 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL DUT4_out6 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL DUT4_out7 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL DUT4_out8 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL DUT4_out9 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL DUT4_out10 : STD_LOGIC_VECTOR(161 DOWNTO 0);

SIGNAL DUT5_out1, DUT5_out2, DUT5_out3 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL DUT5_out4 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL DUT5_out5 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL DUT5_out6 : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL DUT5_out7 : STD_LOGIC_VECTOR(147 DOWNTO 0);

SIGNAL DUT6_out1, DUT6_out2, DUT6_out3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL DUT6_out4 : STD_LOGIC_VECTOR(41 DOWNTO 0);
SIGNAL DUT6_out5 : STD_LOGIC_VECTOR(85 DOWNTO 0);

SIGNAL DUT7_out1, DUT7_out2, DUT7_out3: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL DUT7_out4 : STD_LOGIC_VECTOR(91 DOWNTO 0);

-----------------------------------------------------------------------------------------------------1
COMPONENT PartialProd  IS
    PORT(
        X_IN    : IN UNSIGNED(31 DOWNTO 0);
        A_IN    : IN UNSIGNED(31 DOWNTO 0);
        Clk	: IN STD_LOGIC;
        PP_OUT    : OUT STD_LOGIC_VECTOR(22 DOWNTO 0);
		  Sign : OUT STD_LOGIC
    );
END COMPONENT;
-----------------------------------------------------------------------------------------------------2
COMPONENT  Matrix_PP  IS
    PORT(
			Clk : IN STD_LOGIC;
        IN_PPi    : IN UNSIGNED(22 DOWNTO 0); --Partial product I
		  S	: IN STD_LOGIC; --sign of PP
        Results_FA_HA_Stage1    : OUT STD_LOGIC_VECTOR(5 DOWNTO 0); --store the results of FAs and HAs including their Cout
		  V0 : OUT STD_LOGIC_VECTOR(44 DOWNTO 0);
		  V1 : OUT STD_LOGIC_VECTOR(44 DOWNTO 0);
		  V2 : OUT STD_LOGIC_VECTOR(44 DOWNTO 0);
		  V3 : OUT STD_LOGIC_VECTOR(40 DOWNTO 0);
		  V4 : OUT STD_LOGIC_VECTOR(36 DOWNTO 0);
		  V5 : OUT STD_LOGIC_VECTOR(32 DOWNTO 0);
		  V6 : OUT STD_LOGIC_VECTOR(28 DOWNTO 0);
		  V7 : OUT STD_LOGIC_VECTOR(24 DOWNTO 0);
		  V8 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
		  V9 : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
		  V10 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		  V11 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		  V12 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		  V13 : OUT STD_LOGIC
    );
END COMPONENT;
-----------------------------------------------------------------------------------------------------3
COMPONENT  Matrix_stage1  IS
    PORT(
   Results_from_Matrix_PP    : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	
	IN0_from_Matrix_PP	: IN STD_LOGIC_VECTOR(44 DOWNTO 0); 
	IN1_from_Matrix_PP	: IN STD_LOGIC_VECTOR(44 DOWNTO 0); 
	IN2_from_Matrix_PP	: IN STD_LOGIC_VECTOR(44 DOWNTO 0); 
	IN3_from_Matrix_PP	: IN STD_LOGIC_VECTOR(40 DOWNTO 0); 
	IN4_from_Matrix_PP	: IN STD_LOGIC_VECTOR(36 DOWNTO 0); 
	IN5_from_Matrix_PP	: IN STD_LOGIC_VECTOR(32 DOWNTO 0); 
	IN6_from_Matrix_PP	: IN STD_LOGIC_VECTOR(28 DOWNTO 0); 
	IN7_from_Matrix_PP	: IN STD_LOGIC_VECTOR(24 DOWNTO 0); 
	IN8_from_Matrix_PP	: IN STD_LOGIC_VECTOR(20 DOWNTO 0); 
	IN9_from_Matrix_PP	: IN STD_LOGIC_VECTOR(16 DOWNTO 0); 
	IN10_from_Matrix_PP	: IN STD_LOGIC_VECTOR(12 DOWNTO 0); 
	IN11_from_Matrix_PP	: IN STD_LOGIC_VECTOR(8 DOWNTO 0); 
	IN12_from_Matrix_PP	: IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
	IN13_from_Matrix_PP	: IN STD_LOGIC; 


---------Output vectors that contain remaining values

	V0 : OUT STD_LOGIC_VECTOR(28 DOWNTO 0);
	V1 : OUT STD_LOGIC_VECTOR(28 DOWNTO 0);
	V2 : OUT STD_LOGIC_VECTOR(28 DOWNTO 0);
	V3 : OUT STD_LOGIC_VECTOR(25 DOWNTO 0);  
	V4 : OUT STD_LOGIC_VECTOR(21 DOWNTO 0);
	V5 : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);			
	V6 : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	V7 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
	V8 : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	V9 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);				
	V10 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	V11 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	V12 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);

   Results_FA_HA_Stage2    : OUT STD_LOGIC_VECTOR(105 DOWNTO 0)   
	
    );
END COMPONENT;
-----------------------------------------------------------------------------------------------------4
COMPONENT  Matrix_stage2  IS
    PORT(
   Results_from_Matrix_stage1    : IN STD_LOGIC_VECTOR(105 DOWNTO 0);

	IN0_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(28 DOWNTO 0);
	IN1_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(28 DOWNTO 0);
	IN2_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(28 DOWNTO 0);
	IN3_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(25 DOWNTO 0);  
	IN4_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(21 DOWNTO 0);
	IN5_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
	IN6_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	IN7_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	IN8_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
	IN9_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	IN10_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	IN11_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	IN12_from_Matrix_stage1 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);


---------Output vectors that contain remaining values

	V0 : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
	V1 : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);   
	V2 : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
	V3 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);  
	V4 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);			
	V5 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	V6 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	V7 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	V8 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

   Results_FA_HA_Stage3    : OUT STD_LOGIC_VECTOR(161 DOWNTO 0) 
	
    );
END COMPONENT;
-----------------------------------------------------------------------------------------------------5
COMPONENT  Matrix_stage3  IS
    PORT(
   Results_from_Matrix_stage2    : IN STD_LOGIC_VECTOR(161 DOWNTO 0);

	IN0_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
	IN1_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
	IN2_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
	IN3_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	IN4_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);  
	IN5_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	IN6_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	IN7_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	IN8_from_Matrix_stage2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);


---------Output vectors that contain remaining values

	V0 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
	V1 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);   
	V2 : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);   		 
	V3 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	V4 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	V5 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);

   Results_FA_HA_Stage4    : OUT STD_LOGIC_VECTOR(147 DOWNTO 0) 
	
    );
END COMPONENT;
-----------------------------------------------------------------------------------------------------6
COMPONENT  Matrix_stage4  IS
    PORT(
   Results_from_Matrix_stage3    : IN STD_LOGIC_VECTOR(147 DOWNTO 0);  

	IN0_from_Matrix_stage3 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	IN1_from_Matrix_stage3 : IN STD_LOGIC_VECTOR(8 DOWNTO 0); 		
	IN2_from_Matrix_stage3 : IN STD_LOGIC_VECTOR(8 DOWNTO 0); 
	IN3_from_Matrix_stage3 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	IN4_from_Matrix_stage3 : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
	IN5_from_Matrix_stage3 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);


---------Output vectors that contain remaining values

	V0 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	V1 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);   
	V2 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); 
	V3 : OUT STD_LOGIC_VECTOR(41 DOWNTO 0); 

   Results_FA_HA_Stage5    : OUT STD_LOGIC_VECTOR(85 DOWNTO 0) 
	
    );
END COMPONENT;
-----------------------------------------------------------------------------------------------------7

COMPONENT  Matrix_stage5  IS
    PORT(
   Results_from_Matrix_stage4    : IN STD_LOGIC_VECTOR(85 DOWNTO 0);  

	IN0_from_Matrix_stage4 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	IN1_from_Matrix_stage4 : IN STD_LOGIC_VECTOR(4 DOWNTO 0); 		
	IN2_from_Matrix_stage4 : IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
	IN3_from_Matrix_stage4 : IN STD_LOGIC_VECTOR(41 DOWNTO 0);



---------Output vectors that contain remaining values

	V0 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	V1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);   
	V2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 

   Results_FA_HA_Stage6    : OUT STD_LOGIC_VECTOR(91 DOWNTO 0) 
	
    );
END COMPONENT;


-----------------------------------------------------------------------------------------------------8
COMPONENT  RCA  IS
    PORT(
   Results_from_Matrix_stage5    : IN STD_LOGIC_VECTOR(91 DOWNTO 0);  

	IN0_from_Matrix_stage5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	IN1_from_Matrix_stage5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 		
	IN2_from_Matrix_stage5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

   final_Result    : OUT STD_LOGIC_VECTOR(45 DOWNTO 0) 
	
    );
END COMPONENT;
-----------------------------------------------------------------------------------------------------



BEGIN
DUT1: PartialProd PORT MAP(X_IN => B_IN, A_IN => A_IN, Clk => Clk,PP_OUT => Out_DUT1_slv, Sign => sign_tmp);
Out_DUT1 <= UNSIGNED(Out_DUT1_slv);

DUT2: Matrix_PP PORT MAP(Clk => Clk, IN_PPi => Out_DUT1, S => sign_tmp, Results_FA_HA_Stage1 => DUT2_out1, V0 => DUT2_out2, V1 => DUT2_out3, 
								V2 => DUT2_out4, V3 => DUT2_out5, V4 => DUT2_out6, V5 => DUT2_out7, V6 => DUT2_out8, V7 => DUT2_out9, 
								V8 => DUT2_out10, V9 => DUT2_out11, V10 => DUT2_out12, V11 => DUT2_out13, V12 => DUT2_out14, V13 => DUT2_out15);
								
DUT3: Matrix_stage1 PORT MAP(Results_from_Matrix_PP => DUT2_out1, IN0_from_Matrix_PP => DUT2_out2, IN1_from_Matrix_PP => DUT2_out3, 
								IN2_from_Matrix_PP => DUT2_out4, IN3_from_Matrix_PP => DUT2_out5, IN4_from_Matrix_PP => DUT2_out6, IN5_from_Matrix_PP => DUT2_out7,
								IN6_from_Matrix_PP => DUT2_out8, IN7_from_Matrix_PP => DUT2_out9, IN8_from_Matrix_PP => DUT2_out10, 
								IN9_from_Matrix_PP => DUT2_out11, IN10_from_Matrix_PP => DUT2_out12, IN11_from_Matrix_PP => DUT2_out13, 
								IN12_from_Matrix_PP => DUT2_out14, IN13_from_Matrix_PP => DUT2_out15,
								V0 => DUT3_out1, V1 => DUT3_out2, V2 => DUT3_out3, V3 => DUT3_out4, V4 => DUT3_out5, 
								V5 => DUT3_out6, V6 => DUT3_out7, V7 => DUT3_out8, V8 => DUT3_out9, V9 => DUT3_out10, V10 => DUT3_out11,
								v11 => DUT3_out12, V12 => DUT3_out13, Results_FA_HA_Stage2 => DUT3_out14);
								
DUT4: Matrix_stage2 PORT MAP(Results_from_Matrix_stage1 => DUT3_out14, IN0_from_Matrix_stage1 => DUT3_out1, IN1_from_Matrix_stage1 => DUT3_out2, 
								IN2_from_Matrix_stage1 => DUT3_out3, IN3_from_Matrix_stage1 => DUT3_out4, IN4_from_Matrix_stage1 => DUT3_out5,
								IN5_from_Matrix_stage1 => DUT3_out6, IN6_from_Matrix_stage1 => DUT3_out7, IN7_from_Matrix_stage1 => DUT3_out8,
								IN8_from_Matrix_stage1 => DUT3_out9, IN9_from_Matrix_stage1 => DUT3_out10, IN10_from_Matrix_stage1 => DUT3_out11,
								IN11_from_Matrix_stage1 => DUT3_out12, IN12_from_Matrix_stage1 => DUT3_out13,
								V0 => DUT4_out1, V1 => DUT4_out2, V2 => DUT4_out3, V3 => DUT4_out4, V4 => DUT4_out5, V5 => DUT4_out6, 
								V6 => DUT4_out7, V7 => DUT4_out8, V8 => DUT4_out9, Results_FA_HA_Stage3 => DUT4_out10);
								
DUT5: Matrix_stage3 PORT MAP(Results_from_Matrix_stage2 => DUT4_out10, IN0_from_Matrix_stage2 => DUT4_out1, IN1_from_Matrix_stage2 => DUT4_out2,
									IN2_from_Matrix_stage2 => DUT4_out3, IN3_from_Matrix_stage2 => DUT4_out4, IN4_from_Matrix_stage2 => DUT4_out5,
									IN5_from_Matrix_stage2 => DUT4_out6, IN6_from_Matrix_stage2 => DUT4_out7, IN7_from_Matrix_stage2 => DUT4_out8,
									IN8_from_Matrix_stage2 => DUT4_out9,
									V0 => DUT5_out1, V1 => DUT5_out2, V2 => DUT5_out3, V3 => DUT5_out4, V4 => DUT5_out5,
									V5 => DUT5_out6, Results_FA_HA_Stage4 => DUT5_out7);
									
DUT6: Matrix_stage4 PORT MAP(Results_from_Matrix_stage3 => DUT5_out7, IN0_from_Matrix_stage3 => DUT5_out1, IN1_from_Matrix_stage3 => DUT5_out2,
									IN2_from_Matrix_stage3 => DUT5_out3, IN3_from_Matrix_stage3 => DUT5_out4, IN4_from_Matrix_stage3 => DUT5_out5,
									IN5_from_Matrix_stage3 => DUT5_out6,
									V0 => DUT6_out1, V1 => DUT6_out2, V2 => DUT6_out3, V3 => DUT6_out4,
									Results_FA_HA_Stage5 => DUT6_out5);
									
DUT7: Matrix_stage5 PORT MAP(Results_from_Matrix_stage4 => DUT6_out5, IN0_from_Matrix_stage4 => DUT6_out1, IN1_from_Matrix_stage4 => DUT6_out2,
										IN2_from_Matrix_stage4 => DUT6_out3, IN3_from_Matrix_stage4 => DUT6_out4,
										V0 => DUT7_out1, V1 => DUT7_out2, V2 => DUT7_out3,
										Results_FA_HA_Stage6 => DUT7_out4);
									
DUT8: RCA PORT MAP(Results_from_Matrix_stage5 => DUT7_out4, IN0_from_Matrix_stage5 => DUT7_out1, IN1_from_Matrix_stage5 => DUT7_out2,
						IN2_from_Matrix_stage5 => DUT7_out3, final_Result => Result);

END ARCHITECTURE;