LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Matrix_stage5  IS
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
END Matrix_stage5;

ARCHITECTURE  mat1 OF Matrix_stage5 IS


SIGNAL result_tmp: STD_LOGIC_VECTOR (91 DOWNTO 0);


type MATRIX is array (0 TO 2) of STD_LOGIC_VECTOR (47 DOWNTO 0); --number of rows/columns
SIGNAL MATRIX3X48 : MATRIX := (OTHERS => (OTHERS => '0'));

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
PROCESS(Results_from_Matrix_stage4)

	variable z1,z2 : INTEGER;
	BEGIN
	
	--0 line assignment intern
	
	z1 := 0;
	for w in 4 to 46 loop
		MATRIX3X48(0)(w) <= Results_from_Matrix_stage4(z1);
		z1 := z1 + 2;
	end loop;

	--SX
	MATRIX3X48(0)(47) <= IN0_from_Matrix_stage4(4);
	
	--DX
	MATRIX3X48(0)(3 DOWNTO 0) <= IN0_from_Matrix_stage4(3 DOWNTO 0);
--------------------------------------------------------
	--1 line assignment intern
	
	--DX
	MATRIX3X48(1)(4) <= IN2_from_Matrix_stage4(2);
	MATRIX3X48(1)(3 DOWNTO 0) <= IN1_from_Matrix_stage4(3 DOWNTO 0);
	
	z2 := 1;
	for w in 5 to 47 loop
		MATRIX3X48(1)(w) <= Results_from_Matrix_stage4(z2);
		z2 := z2 + 2;
	end loop;

--------------------------------------------------------
	--2 line assignment intern
	
	MATRIX3X48(2)(45 DOWNTO 6) <= IN3_from_Matrix_stage4(41 DOWNTO 2);
	
	-- SX
	MATRIX3X48(2)(46) <= IN2_from_Matrix_stage4(4);
	MATRIX3X48(2)(47) <= IN1_from_Matrix_stage4(4);
	
	-- DX
	MATRIX3X48(2)(2) <= IN2_from_Matrix_stage4(0);
	MATRIX3X48(2)(4) <= IN3_from_Matrix_stage4(0);
	MATRIX3X48(2)(5) <= IN2_from_Matrix_stage4(3);


END PROCESS;


-----------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Instance FAs HAs--------------------------------------------------------------------------
HA1 : HA PORT MAP (A => MATRIX3X48(0)(2),B => MATRIX3X48(1)(2),S => result_tmp(0),Cout => result_tmp(1));

HA2 : HA PORT MAP (A => MATRIX3X48(0)(3),B => MATRIX3X48(1)(3),S => result_tmp(2),Cout => result_tmp(3));

FA1 : FA PORT MAP (A => MATRIX3X48(0)(4),B => MATRIX3X48(1)(4),Cin => MATRIX3X48(2)(4),S => result_tmp(4),Cout => result_tmp(5));

FA2 : FA PORT MAP (A => MATRIX3X48(0)(5),B => MATRIX3X48(1)(5),Cin => MATRIX3X48(2)(5),S => result_tmp(6),Cout => result_tmp(7));

FA3 : FA PORT MAP (A => MATRIX3X48(0)(6),B => MATRIX3X48(1)(6),Cin => MATRIX3X48(2)(6),S => result_tmp(8),Cout => result_tmp(9));

FA4 : FA PORT MAP (A => MATRIX3X48(0)(7),B => MATRIX3X48(1)(7),Cin => MATRIX3X48(2)(7),S => result_tmp(10),Cout => result_tmp(11));

FA5 : FA PORT MAP (A => MATRIX3X48(0)(8),B => MATRIX3X48(1)(8),Cin => MATRIX3X48(2)(8),S => result_tmp(12),Cout => result_tmp(13));

FA6 : FA PORT MAP (A => MATRIX3X48(0)(9),B => MATRIX3X48(1)(9),Cin => MATRIX3X48(2)(9),S => result_tmp(14),Cout => result_tmp(15));

FA7 : FA PORT MAP (A => MATRIX3X48(0)(10),B => MATRIX3X48(1)(10),Cin => MATRIX3X48(2)(10),S => result_tmp(16),Cout => result_tmp(17));

FA8 : FA PORT MAP (A => MATRIX3X48(0)(11),B => MATRIX3X48(1)(11),Cin => MATRIX3X48(2)(11),S => result_tmp(18),Cout => result_tmp(19));

FA9 : FA PORT MAP (A => MATRIX3X48(0)(12),B => MATRIX3X48(1)(12),Cin => MATRIX3X48(2)(12),S => result_tmp(20),Cout => result_tmp(21));

FA10 : FA PORT MAP (A => MATRIX3X48(0)(13),B => MATRIX3X48(1)(13),Cin => MATRIX3X48(2)(13),S => result_tmp(22),Cout => result_tmp(23));

FA11 : FA PORT MAP (A => MATRIX3X48(0)(14),B => MATRIX3X48(1)(14),Cin => MATRIX3X48(2)(14),S => result_tmp(24),Cout => result_tmp(25));

FA12 : FA PORT MAP (A => MATRIX3X48(0)(15),B => MATRIX3X48(1)(15),Cin => MATRIX3X48(2)(15),S => result_tmp(26),Cout => result_tmp(27));

FA13 : FA PORT MAP (A => MATRIX3X48(0)(16),B => MATRIX3X48(1)(16),Cin => MATRIX3X48(2)(16),S => result_tmp(28),Cout => result_tmp(29));

FA14 : FA PORT MAP (A => MATRIX3X48(0)(17),B => MATRIX3X48(1)(17),Cin => MATRIX3X48(2)(17),S => result_tmp(30),Cout => result_tmp(31));

FA15 : FA PORT MAP (A => MATRIX3X48(0)(18),B => MATRIX3X48(1)(18),Cin => MATRIX3X48(2)(18),S => result_tmp(32),Cout => result_tmp(33));

FA16 : FA PORT MAP (A => MATRIX3X48(0)(19),B => MATRIX3X48(1)(19),Cin => MATRIX3X48(2)(19),S => result_tmp(34),Cout => result_tmp(35));

FA17 : FA PORT MAP (A => MATRIX3X48(0)(20),B => MATRIX3X48(1)(20),Cin => MATRIX3X48(2)(20),S => result_tmp(36),Cout => result_tmp(37));

FA18 : FA PORT MAP (A => MATRIX3X48(0)(21),B => MATRIX3X48(1)(21),Cin => MATRIX3X48(2)(21),S => result_tmp(38),Cout => result_tmp(39));

FA19 : FA PORT MAP (A => MATRIX3X48(0)(22),B => MATRIX3X48(1)(22),Cin => MATRIX3X48(2)(22),S => result_tmp(40),Cout => result_tmp(41));

FA20 : FA PORT MAP (A => MATRIX3X48(0)(23),B => MATRIX3X48(1)(23),Cin => MATRIX3X48(2)(23),S => result_tmp(42),Cout => result_tmp(43));

FA21 : FA PORT MAP (A => MATRIX3X48(0)(24),B => MATRIX3X48(1)(24),Cin => MATRIX3X48(2)(24),S => result_tmp(44),Cout => result_tmp(45));

FA22 : FA PORT MAP (A => MATRIX3X48(0)(25),B => MATRIX3X48(1)(25),Cin => MATRIX3X48(2)(25),S => result_tmp(46),Cout => result_tmp(47));

FA23 : FA PORT MAP (A => MATRIX3X48(0)(26),B => MATRIX3X48(1)(26),Cin => MATRIX3X48(2)(26),S => result_tmp(48),Cout => result_tmp(49));

FA24 : FA PORT MAP (A => MATRIX3X48(0)(27),B => MATRIX3X48(1)(27),Cin => MATRIX3X48(2)(27),S => result_tmp(50),Cout => result_tmp(51));

FA25 : FA PORT MAP (A => MATRIX3X48(0)(28),B => MATRIX3X48(1)(28),Cin => MATRIX3X48(2)(28),S => result_tmp(52),Cout => result_tmp(53));

FA26 : FA PORT MAP (A => MATRIX3X48(0)(29),B => MATRIX3X48(1)(29),Cin => MATRIX3X48(2)(29),S => result_tmp(54),Cout => result_tmp(55));

FA27 : FA PORT MAP (A => MATRIX3X48(0)(30),B => MATRIX3X48(1)(30),Cin => MATRIX3X48(2)(30),S => result_tmp(56),Cout => result_tmp(57));

FA28 : FA PORT MAP (A => MATRIX3X48(0)(31),B => MATRIX3X48(1)(31),Cin => MATRIX3X48(2)(31),S => result_tmp(58),Cout => result_tmp(59));

FA29 : FA PORT MAP (A => MATRIX3X48(0)(32),B => MATRIX3X48(1)(32),Cin => MATRIX3X48(2)(32),S => result_tmp(60),Cout => result_tmp(61));

FA30 : FA PORT MAP (A => MATRIX3X48(0)(33),B => MATRIX3X48(1)(33),Cin => MATRIX3X48(2)(33),S => result_tmp(62),Cout => result_tmp(63));

FA31 : FA PORT MAP (A => MATRIX3X48(0)(34),B => MATRIX3X48(1)(34),Cin => MATRIX3X48(2)(34),S => result_tmp(64),Cout => result_tmp(65));

FA32 : FA PORT MAP (A => MATRIX3X48(0)(35),B => MATRIX3X48(1)(35),Cin => MATRIX3X48(2)(35),S => result_tmp(66),Cout => result_tmp(67));

FA33 : FA PORT MAP (A => MATRIX3X48(0)(36),B => MATRIX3X48(1)(36),Cin => MATRIX3X48(2)(36),S => result_tmp(68),Cout => result_tmp(69));

FA34 : FA PORT MAP (A => MATRIX3X48(0)(37),B => MATRIX3X48(1)(37),Cin => MATRIX3X48(2)(37),S => result_tmp(70),Cout => result_tmp(71));

FA35 : FA PORT MAP (A => MATRIX3X48(0)(38),B => MATRIX3X48(1)(38),Cin => MATRIX3X48(2)(38),S => result_tmp(72),Cout => result_tmp(73));

FA36 : FA PORT MAP (A => MATRIX3X48(0)(39),B => MATRIX3X48(1)(39),Cin => MATRIX3X48(2)(39),S => result_tmp(74),Cout => result_tmp(75));

FA37 : FA PORT MAP (A => MATRIX3X48(0)(40),B => MATRIX3X48(1)(40),Cin => MATRIX3X48(2)(40),S => result_tmp(76),Cout => result_tmp(77));

FA38 : FA PORT MAP (A => MATRIX3X48(0)(41),B => MATRIX3X48(1)(41),Cin => MATRIX3X48(2)(41),S => result_tmp(78),Cout => result_tmp(79));

FA39 : FA PORT MAP (A => MATRIX3X48(0)(42),B => MATRIX3X48(1)(42),Cin => MATRIX3X48(2)(42),S => result_tmp(80),Cout => result_tmp(81));

FA40 : FA PORT MAP (A => MATRIX3X48(0)(43),B => MATRIX3X48(1)(43),Cin => MATRIX3X48(2)(43),S => result_tmp(82),Cout => result_tmp(83));

FA41 : FA PORT MAP (A => MATRIX3X48(0)(44),B => MATRIX3X48(1)(44),Cin => MATRIX3X48(2)(44),S => result_tmp(84),Cout => result_tmp(85));

FA42 : FA PORT MAP (A => MATRIX3X48(0)(45),B => MATRIX3X48(1)(45),Cin => MATRIX3X48(2)(45),S => result_tmp(86),Cout => result_tmp(87));

FA43 : FA PORT MAP (A => MATRIX3X48(0)(46),B => MATRIX3X48(1)(46),Cin => MATRIX3X48(2)(46),S => result_tmp(88),Cout => result_tmp(89));

FA44 : FA PORT MAP (A => MATRIX3X48(0)(47),B => MATRIX3X48(1)(47),Cin => MATRIX3X48(2)(47),S => result_tmp(90),Cout => result_tmp(91));

---------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------Assignment output vectors--------------------------------------------------------------------------------------------------------

	V0(1 DOWNTO 0) <= IN0_from_Matrix_stage4(1 DOWNTO 0);
	
	
	V1(1 DOWNTO 0) <= IN1_from_Matrix_stage4(1 DOWNTO 0);
	
	
	V2(1 DOWNTO 0) <= IN3_from_Matrix_stage4(1 DOWNTO 0);


-------------------------------------------------------------------------------------------------------------------------
--output
Results_FA_HA_Stage6 <= result_tmp;



END ARCHITECTURE;