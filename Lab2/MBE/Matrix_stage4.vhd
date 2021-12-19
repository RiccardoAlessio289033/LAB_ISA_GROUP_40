LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Matrix_stage4  IS
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
END Matrix_stage4;

ARCHITECTURE  mat1 OF Matrix_stage4 IS


SIGNAL result_tmp: STD_LOGIC_VECTOR (85 DOWNTO 0); 


type MATRIX is array (0 TO 3) of STD_LOGIC_VECTOR (47 DOWNTO 0); --number of rows/columns
SIGNAL MATRIX4X48 : MATRIX := (OTHERS => (OTHERS => '0'));

COMPONENT HA  IS
    PORT(
        A    : IN STD_LOGIC;
        B    : IN STD_LOGIC;
        S    : OUT STD_LOGIC;
        Cout    : OUT STD_LOGIC

    );
END COMPONENT;

COMPONENT FA  IS

    PORT(
        A    : IN STD_LOGIC;
        B    : IN STD_LOGIC;
        Cin  : IN STD_LOGIC;
        S    : OUT STD_LOGIC;
        Cout    : OUT STD_LOGIC
         
    );
END COMPONENT;
							
BEGIN

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------Assign FAs and HAs results including Cout----------------------------------------------------------
																			------Assign internal part--------
PROCESS(Results_from_Matrix_stage3)

	variable z1,z2,z3,z4,z5,z6 : INTEGER;
	BEGIN									
	--0 line assignment intern

	-- DX
	MATRIX4X48(0)(6) <= Results_from_Matrix_stage3(0);
	MATRIX4X48(0)(7) <= Results_from_Matrix_stage3(2);
	MATRIX4X48(0)(8) <= Results_from_Matrix_stage3(4);
	MATRIX4X48(0)(9) <= Results_from_Matrix_stage3(8);
	
	z1 := 12;
	for w in 10 to 41 loop
		MATRIX4X48(0)(w) <= Results_from_Matrix_stage3(z1);
		z1 := z1 + 4;
	end loop;
	
	-- SX
	MATRIX4X48(0)(42) <= Results_from_Matrix_stage3(140);
	MATRIX4X48(0)(43) <= Results_from_Matrix_stage3(144);
	MATRIX4X48(0)(44) <= Results_from_Matrix_stage3(146);

	MATRIX4X48(0)(45) <= IN0_from_Matrix_stage3(6);
	
--------------------------------------------------------
	--1 line assignment intern
	
	-- DX
	MATRIX4X48(1)(7) <= Results_from_Matrix_stage3(1);
	MATRIX4X48(1)(8) <= Results_from_Matrix_stage3(3);
	MATRIX4X48(1)(9) <= Results_from_Matrix_stage3(5);
	MATRIX4X48(1)(10) <= Results_from_Matrix_stage3(9);
	
	z2 := 13;
	for w in 11 to 42 loop
		MATRIX4X48(1)(w) <= Results_from_Matrix_stage3(z2);
		z2 := z2 + 4;
	end loop;

	-- SX
	MATRIX4X48(1)(43) <= Results_from_Matrix_stage3(141);
	MATRIX4X48(1)(44) <= Results_from_Matrix_stage3(145);
	MATRIX4X48(1)(45) <= Results_from_Matrix_stage3(147);
	
	MATRIX4X48(1)(6) <= IN2_from_Matrix_stage3(4);
--------------------------------------------------------
	--2 line assignment intern
	
	-- DX
	MATRIX4X48(2)(8) <= Results_from_Matrix_stage3(6);
	MATRIX4X48(2)(9) <= Results_from_Matrix_stage3(10);
	
	z3 := 14;
	for w in 10 to 41 loop
		MATRIX4X48(2)(w) <= Results_from_Matrix_stage3(z3);
		z3 := z3 + 4;
	end loop;
	
	-- SX
	MATRIX4X48(2)(42) <= Results_from_Matrix_stage3(142);
	
	--DX
	MATRIX4X48(2)(6) <= IN3_from_Matrix_stage3(2);
	MATRIX4X48(2)(7) <= IN2_from_Matrix_stage3(5);
	--SX
	MATRIX4X48(2)(43) <= IN3_from_Matrix_stage3(4);
	MATRIX4X48(2)(44) <= IN2_from_Matrix_stage3(6);
	MATRIX4X48(2)(45) <= IN1_from_Matrix_stage3(6);
	
--------------------------------------------------------
	--3 line assignment intern
	
	-- DX
	MATRIX4X48(3)(9) <= Results_from_Matrix_stage3(7);
	MATRIX4X48(3)(10) <= Results_from_Matrix_stage3(11);
	
	z4 := 15;
	for w in 11 to 42 loop
		MATRIX4X48(3)(w) <= Results_from_Matrix_stage3(z4);
		z4 := z4 + 4;
	end loop;
	
	-- SX
	MATRIX4X48(3)(43) <= Results_from_Matrix_stage3(143);
	
	--DX
	MATRIX4X48(3)(6) <= IN4_from_Matrix_stage3(0);
	MATRIX4X48(3)(7) <= IN3_from_Matrix_stage3(3);
	MATRIX4X48(3)(8) <= IN5_from_Matrix_stage3(0);
	--SX
	MATRIX4X48(3)(44) <= IN3_from_Matrix_stage3(5);
	MATRIX4X48(3)(45) <= IN2_from_Matrix_stage3(7);
--------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Assign external part----------------------------------------------------------------------


	MATRIX4X48(0)(5 DOWNTO 0)  <= IN0_from_Matrix_stage3(5 DOWNTO 0);
	MATRIX4X48(0)(47 DOWNTO 46)  <= IN0_from_Matrix_stage3(8 DOWNTO 7);

-------------------------0-------------------------------

	MATRIX4X48(1)(5 DOWNTO 0)  <= IN1_from_Matrix_stage3(5 DOWNTO 0);
	MATRIX4X48(1)(47 DOWNTO 46)  <= IN1_from_Matrix_stage3(8 DOWNTO 7);

---------------------------1-----------------------------

	MATRIX4X48(2)(5 DOWNTO 2)  <= IN2_from_Matrix_stage3(3 DOWNTO 0);
	MATRIX4X48(2)(46)  <= IN2_from_Matrix_stage3(8);
	
----------------------------2----------------------------

	MATRIX4X48(3)(5 DOWNTO 4)  <= IN3_from_Matrix_stage3(1 DOWNTO 0);
----------------------------3----------------------------


END PROCESS;


-----------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Instance FAs HAs--------------------------------------------------------------------------
HA1 : HA PORT MAP (A => MATRIX4X48(0)(4),B => MATRIX4X48(1)(4),S => result_tmp(0),Cout => result_tmp(1));

HA2 : HA PORT MAP (A => MATRIX4X48(0)(5),B => MATRIX4X48(1)(5),S => result_tmp(2),Cout => result_tmp(3));

FA1 : FA PORT MAP (A => MATRIX4X48(0)(6),B => MATRIX4X48(1)(6),Cin => MATRIX4X48(2)(6),S => result_tmp(4),Cout => result_tmp(5));

FA2 : FA PORT MAP (A => MATRIX4X48(0)(7),B => MATRIX4X48(1)(7),Cin => MATRIX4X48(2)(7),S => result_tmp(6),Cout => result_tmp(7));

FA3 : FA PORT MAP (A => MATRIX4X48(0)(8),B => MATRIX4X48(1)(8),Cin => MATRIX4X48(2)(8),S => result_tmp(8),Cout => result_tmp(9));

FA4 : FA PORT MAP (A => MATRIX4X48(0)(9),B => MATRIX4X48(1)(9),Cin => MATRIX4X48(2)(9),S => result_tmp(10),Cout => result_tmp(11));

FA5 : FA PORT MAP (A => MATRIX4X48(0)(10),B => MATRIX4X48(1)(10),Cin => MATRIX4X48(2)(10),S => result_tmp(12),Cout => result_tmp(13));

FA6 : FA PORT MAP (A => MATRIX4X48(0)(11),B => MATRIX4X48(1)(11),Cin => MATRIX4X48(2)(11),S => result_tmp(14),Cout => result_tmp(15));

FA7 : FA PORT MAP (A => MATRIX4X48(0)(12),B => MATRIX4X48(1)(12),Cin => MATRIX4X48(2)(12),S => result_tmp(16),Cout => result_tmp(17));

FA8 : FA PORT MAP (A => MATRIX4X48(0)(13),B => MATRIX4X48(1)(13),Cin => MATRIX4X48(2)(13),S => result_tmp(18),Cout => result_tmp(19));

FA9 : FA PORT MAP (A => MATRIX4X48(0)(14),B => MATRIX4X48(1)(14),Cin => MATRIX4X48(2)(14),S => result_tmp(20),Cout => result_tmp(21));

FA10 : FA PORT MAP (A => MATRIX4X48(0)(15),B => MATRIX4X48(1)(15),Cin => MATRIX4X48(2)(15),S => result_tmp(22),Cout => result_tmp(23));

FA11 : FA PORT MAP (A => MATRIX4X48(0)(16),B => MATRIX4X48(1)(16),Cin => MATRIX4X48(2)(16),S => result_tmp(24),Cout => result_tmp(25));

FA12 : FA PORT MAP (A => MATRIX4X48(0)(17),B => MATRIX4X48(1)(17),Cin => MATRIX4X48(2)(17),S => result_tmp(26),Cout => result_tmp(27));

FA13 : FA PORT MAP (A => MATRIX4X48(0)(18),B => MATRIX4X48(1)(18),Cin => MATRIX4X48(2)(18),S => result_tmp(28),Cout => result_tmp(29));

FA14 : FA PORT MAP (A => MATRIX4X48(0)(19),B => MATRIX4X48(1)(19),Cin => MATRIX4X48(2)(19),S => result_tmp(30),Cout => result_tmp(31));

FA15 : FA PORT MAP (A => MATRIX4X48(0)(20),B => MATRIX4X48(1)(20),Cin => MATRIX4X48(2)(20),S => result_tmp(32),Cout => result_tmp(33));

FA16 : FA PORT MAP (A => MATRIX4X48(0)(21),B => MATRIX4X48(1)(21),Cin => MATRIX4X48(2)(21),S => result_tmp(34),Cout => result_tmp(35));

FA17 : FA PORT MAP (A => MATRIX4X48(0)(22),B => MATRIX4X48(1)(22),Cin => MATRIX4X48(2)(22),S => result_tmp(36),Cout => result_tmp(37));

FA18 : FA PORT MAP (A => MATRIX4X48(0)(23),B => MATRIX4X48(1)(23),Cin => MATRIX4X48(2)(23),S => result_tmp(38),Cout => result_tmp(39));

FA19 : FA PORT MAP (A => MATRIX4X48(0)(24),B => MATRIX4X48(1)(24),Cin => MATRIX4X48(2)(24),S => result_tmp(40),Cout => result_tmp(41));

FA20 : FA PORT MAP (A => MATRIX4X48(0)(25),B => MATRIX4X48(1)(25),Cin => MATRIX4X48(2)(25),S => result_tmp(42),Cout => result_tmp(43));

FA21 : FA PORT MAP (A => MATRIX4X48(0)(26),B => MATRIX4X48(1)(26),Cin => MATRIX4X48(2)(26),S => result_tmp(44),Cout => result_tmp(45));

FA22 : FA PORT MAP (A => MATRIX4X48(0)(27),B => MATRIX4X48(1)(27),Cin => MATRIX4X48(2)(27),S => result_tmp(46),Cout => result_tmp(47));

FA23 : FA PORT MAP (A => MATRIX4X48(0)(28),B => MATRIX4X48(1)(28),Cin => MATRIX4X48(2)(28),S => result_tmp(48),Cout => result_tmp(49));

FA24 : FA PORT MAP (A => MATRIX4X48(0)(29),B => MATRIX4X48(1)(29),Cin => MATRIX4X48(2)(29),S => result_tmp(50),Cout => result_tmp(51));

FA25 : FA PORT MAP (A => MATRIX4X48(0)(30),B => MATRIX4X48(1)(30),Cin => MATRIX4X48(2)(30),S => result_tmp(52),Cout => result_tmp(53));

FA26 : FA PORT MAP (A => MATRIX4X48(0)(31),B => MATRIX4X48(1)(31),Cin => MATRIX4X48(2)(31),S => result_tmp(54),Cout => result_tmp(55));

FA27 : FA PORT MAP (A => MATRIX4X48(0)(32),B => MATRIX4X48(1)(32),Cin => MATRIX4X48(2)(32),S => result_tmp(56),Cout => result_tmp(57));

FA28 : FA PORT MAP (A => MATRIX4X48(0)(33),B => MATRIX4X48(1)(33),Cin => MATRIX4X48(2)(33),S => result_tmp(58),Cout => result_tmp(59));

FA29 : FA PORT MAP (A => MATRIX4X48(0)(34),B => MATRIX4X48(1)(34),Cin => MATRIX4X48(2)(34),S => result_tmp(60),Cout => result_tmp(61));

FA30 : FA PORT MAP (A => MATRIX4X48(0)(35),B => MATRIX4X48(1)(35),Cin => MATRIX4X48(2)(35),S => result_tmp(62),Cout => result_tmp(63));

FA31 : FA PORT MAP (A => MATRIX4X48(0)(36),B => MATRIX4X48(1)(36),Cin => MATRIX4X48(2)(36),S => result_tmp(64),Cout => result_tmp(65));

FA32 : FA PORT MAP (A => MATRIX4X48(0)(37),B => MATRIX4X48(1)(37),Cin => MATRIX4X48(2)(37),S => result_tmp(66),Cout => result_tmp(67));

FA33 : FA PORT MAP (A => MATRIX4X48(0)(38),B => MATRIX4X48(1)(38),Cin => MATRIX4X48(2)(38),S => result_tmp(68),Cout => result_tmp(69));

FA34 : FA PORT MAP (A => MATRIX4X48(0)(39),B => MATRIX4X48(1)(39),Cin => MATRIX4X48(2)(39),S => result_tmp(70),Cout => result_tmp(71));

FA35 : FA PORT MAP (A => MATRIX4X48(0)(40),B => MATRIX4X48(1)(40),Cin => MATRIX4X48(2)(40),S => result_tmp(72),Cout => result_tmp(73));

FA36 : FA PORT MAP (A => MATRIX4X48(0)(41),B => MATRIX4X48(1)(41),Cin => MATRIX4X48(2)(41),S => result_tmp(74),Cout => result_tmp(75));

FA37 : FA PORT MAP (A => MATRIX4X48(0)(42),B => MATRIX4X48(1)(42),Cin => MATRIX4X48(2)(42),S => result_tmp(76),Cout => result_tmp(77));

FA38 : FA PORT MAP (A => MATRIX4X48(0)(43),B => MATRIX4X48(1)(43),Cin => MATRIX4X48(2)(43),S => result_tmp(78),Cout => result_tmp(79));

FA39 : FA PORT MAP (A => MATRIX4X48(0)(44),B => MATRIX4X48(1)(44),Cin => MATRIX4X48(2)(44),S => result_tmp(80),Cout => result_tmp(81));

FA40 : FA PORT MAP (A => MATRIX4X48(0)(45),B => MATRIX4X48(1)(45),Cin => MATRIX4X48(2)(45),S => result_tmp(82),Cout => result_tmp(83));

HA3 : HA PORT MAP (A => MATRIX4X48(0)(46),B => MATRIX4X48(1)(46),S => result_tmp(84),Cout => result_tmp(85));

---------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------Assignment output vectors--------------------------------------------------------------------------------------------------------

	V0(3 DOWNTO 0) <= IN0_from_Matrix_stage3(3 DOWNTO 0);
	V0(4) <= IN0_from_Matrix_stage3(8);
	
	
	V1(3 DOWNTO 0) <= IN1_from_Matrix_stage3(3 DOWNTO 0);
	V1(4) <= IN1_from_Matrix_stage3(8);
	
	
	V2(3 DOWNTO 0) <= IN2_from_Matrix_stage3(3 DOWNTO 0);
	V2(4) <= IN2_from_Matrix_stage3(8);
	
	
	V3 <= MATRIX4X48(3)(45 DOWNTO 4);


-------------------------------------------------------------------------------------------------------------------------
--output
Results_FA_HA_Stage5 <= result_tmp;



END ARCHITECTURE;