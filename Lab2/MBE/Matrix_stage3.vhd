LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Matrix_stage3  IS
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
END Matrix_stage3;

ARCHITECTURE  mat1 OF Matrix_stage3 IS


SIGNAL result_tmp: STD_LOGIC_VECTOR (147 DOWNTO 0);


type MATRIX is array (0 TO 5)  of STD_LOGIC_VECTOR (47 DOWNTO 0); --number of rows/columns
SIGNAL MATRIX6X48 : MATRIX := (OTHERS => (OTHERS => '0'));

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
																						--Assign internal part--
PROCESS(Results_from_Matrix_stage2)

	variable z1,z2,z3,z4,z5,z6 : INTEGER;
	BEGIN									
	--0 line assignment intern
	
	--0 line assignment external partSX
	MATRIX6X48(0)(41) <= IN0_from_Matrix_stage2(10);
	
	-- DX
	MATRIX6X48(0)(10) <= Results_from_Matrix_stage2(0);
	MATRIX6X48(0)(11) <= Results_from_Matrix_stage2(2);
	MATRIX6X48(0)(12) <= Results_from_Matrix_stage2(4);
	MATRIX6X48(0)(13) <= Results_from_Matrix_stage2(8);
	MATRIX6X48(0)(14) <= Results_from_Matrix_stage2(12);
	MATRIX6X48(0)(15) <= Results_from_Matrix_stage2(18);
	
	z1 := 24;
	for w in 16 to 35 loop
		MATRIX6X48(0)(w) <= Results_from_Matrix_stage2(z1);
		z1 := z1 + 6; -- 25 iterazioni * 6 + 24 = 174
	end loop;

	--0 line assignment external partSX
	MATRIX6X48(0)(36) <= Results_from_Matrix_stage2(144);
	MATRIX6X48(0)(37) <= Results_from_Matrix_stage2(150);
	MATRIX6X48(0)(38) <= Results_from_Matrix_stage2(154);
	MATRIX6X48(0)(39) <= Results_from_Matrix_stage2(158);
	MATRIX6X48(0)(40) <= Results_from_Matrix_stage2(160);
	
	
	
--------------------------------------------------------
	--1 line assignment intern
																
		--1 line assignment external partDX
	MATRIX6X48(1)(10) <= IN2_from_Matrix_stage2(8);

	MATRIX6X48(1)(11) <= Results_from_Matrix_stage2(1);
	MATRIX6X48(1)(12) <= Results_from_Matrix_stage2(3);
	MATRIX6X48(1)(13) <= Results_from_Matrix_stage2(5);
	MATRIX6X48(1)(14) <= Results_from_Matrix_stage2(9);
	MATRIX6X48(1)(15) <= Results_from_Matrix_stage2(13);
	MATRIX6X48(1)(16) <= Results_from_Matrix_stage2(19);
	
	z2 := 25;
	for w in 17 to 36 loop
		MATRIX6X48(1)(w) <= Results_from_Matrix_stage2(z2);
		z2 := z2 + 6; -- 20 iterazioni * 6 + 25 = 145
	end loop;
	
	--1 line assignment external partDX
	MATRIX6X48(1)(37) <= Results_from_Matrix_stage2(145);
	MATRIX6X48(1)(38) <= Results_from_Matrix_stage2(151);
	MATRIX6X48(1)(39) <= Results_from_Matrix_stage2(155);
	MATRIX6X48(1)(40) <= Results_from_Matrix_stage2(159);
	MATRIX6X48(1)(41) <= Results_from_Matrix_stage2(161);


-------------------------------------------------------- 
	--2 line assignment intern
	
		--2 line assignment external partDX
	MATRIX6X48(2)(10) <= IN3_from_Matrix_stage2(6);
	MATRIX6X48(2)(11) <= IN2_from_Matrix_stage2(9);

	--2 line assignment external partSX
	MATRIX6X48(2)(39) <= IN3_from_Matrix_stage2(8);
	MATRIX6X48(2)(40) <= IN2_from_Matrix_stage2(10);
	MATRIX6X48(2)(41) <= IN1_from_Matrix_stage2(10);
	
	z3 := 26;
	for w in 16 to 35 loop
		MATRIX6X48(2)(w) <= Results_from_Matrix_stage2(z3);
		z3 := z3 + 6; -- 20 * 6 + 26 = 146
	end loop;
	
	--2 line assignment external partDX
	MATRIX6X48(2)(12) <= Results_from_Matrix_stage2(6);
	MATRIX6X48(2)(13) <= Results_from_Matrix_stage2(10);
	MATRIX6X48(2)(14) <= Results_from_Matrix_stage2(14);
	MATRIX6X48(2)(15) <= Results_from_Matrix_stage2(20);

	--2 line assignment external partSX
	MATRIX6X48(2)(36) <= Results_from_Matrix_stage2(146);
	MATRIX6X48(2)(37) <= Results_from_Matrix_stage2(152);
	MATRIX6X48(2)(38) <= Results_from_Matrix_stage2(156);


--------------------------------------------------------
	--3 line assignment intern

		--3 line assignment external partDX
	MATRIX6X48(3)(10) <= IN4_from_Matrix_stage2(4);
	MATRIX6X48(3)(11) <= IN3_from_Matrix_stage2(7);
	MATRIX6X48(3)(12) <= IN5_from_Matrix_stage2(4);

	--3 line assignment external partSX
	MATRIX6X48(3)(40) <= IN3_from_Matrix_stage2(9);
	MATRIX6X48(3)(41) <= IN2_from_Matrix_stage2(11);

	
	z4 := 27;
	for w in 17 to 36 loop
		MATRIX6X48(3)(w) <= Results_from_Matrix_stage2(z4);
		z4 := z4 + 6; -- 20 * 6 + 27 = 147
	end loop;
	
	--3 line assignment external partDX
	MATRIX6X48(3)(13) <= Results_from_Matrix_stage2(7);
	MATRIX6X48(3)(14) <= Results_from_Matrix_stage2(11);
	MATRIX6X48(3)(15) <= Results_from_Matrix_stage2(15);
	MATRIX6X48(3)(16) <= Results_from_Matrix_stage2(21);

	--3 line assignment external partSX
	MATRIX6X48(3)(37) <= Results_from_Matrix_stage2(147);
	MATRIX6X48(3)(38) <= Results_from_Matrix_stage2(153);
	MATRIX6X48(3)(39) <= Results_from_Matrix_stage2(157);


--------------------------------------------------------
	--4 line assignment intern
	
	--4 line assignment external partDX
	MATRIX6X48(4)(10) <= IN5_from_Matrix_stage2(2);
	MATRIX6X48(4)(11) <= IN4_from_Matrix_stage2(5);
	MATRIX6X48(4)(12) <= IN6_from_Matrix_stage2(2);
	MATRIX6X48(4)(13) <= IN5_from_Matrix_stage2(5);

	--4 line assignment external partSX
	MATRIX6X48(4)(37) <= IN6_from_Matrix_stage2(4);
	MATRIX6X48(4)(38) <= IN5_from_Matrix_stage2(6);
	MATRIX6X48(4)(39) <= IN4_from_Matrix_stage2(6);
	MATRIX6X48(4)(40) <= IN4_from_Matrix_stage2(7);
	MATRIX6X48(4)(41) <= IN3_from_Matrix_stage2(10);

	
	z5 := 28;
	for w in 16 to 35 loop
		MATRIX6X48(4)(w) <= Results_from_Matrix_stage2(z5);
		z5 := z5 + 6;
	end loop;
	
	--4 line assignment external partDX
	MATRIX6X48(4)(14) <= Results_from_Matrix_stage2(16);
	MATRIX6X48(4)(15) <= Results_from_Matrix_stage2(22);

	--4 line assignment external partSX
	MATRIX6X48(4)(36) <= Results_from_Matrix_stage2(148);


--------------------------------------------------------
	--5 line assignment intern
	
	--5 line assignment external partDX
	MATRIX6X48(5)(10) <= IN6_from_Matrix_stage2(0);
	MATRIX6X48(5)(11) <= IN5_from_Matrix_stage2(3);
	MATRIX6X48(5)(12) <= IN7_from_Matrix_stage2(0);
	MATRIX6X48(5)(13) <= IN6_from_Matrix_stage2(3);
	MATRIX6X48(5)(14) <= IN8_from_Matrix_stage2(0);

	--5 line assignment external partSX
	MATRIX6X48(5)(38) <= IN6_from_Matrix_stage2(5);
	MATRIX6X48(5)(39) <= IN5_from_Matrix_stage2(7);
	MATRIX6X48(5)(40) <= IN5_from_Matrix_stage2(8);
	MATRIX6X48(5)(41) <= IN4_from_Matrix_stage2(8);
	
	z6 := 29;
	for w in 17 to 36 loop
		MATRIX6X48(5)(w) <= Results_from_Matrix_stage2(z6);
		z6 := z6 + 6;
	end loop;
	
	--5 line assignment external partDX
	MATRIX6X48(5)(15) <= Results_from_Matrix_stage2(17);
	MATRIX6X48(5)(16) <= Results_from_Matrix_stage2(23);

	--5 line assignment external partSX
	MATRIX6X48(5)(37) <= Results_from_Matrix_stage2(149);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Assign external part----------------------------------------------------------------------


	MATRIX6X48(0)(9 DOWNTO 0)  <= IN0_from_Matrix_stage2(9 DOWNTO 0); 
--SX
	MATRIX6X48(0)(47 DOWNTO 42)  <= IN0_from_Matrix_stage2(16 DOWNTO 11);							

-------------------------0-------------------------------

	MATRIX6X48(1)(9 DOWNTO 0)  <= IN1_from_Matrix_stage2(9 DOWNTO 0); 
--SX
	MATRIX6X48(1)(47 DOWNTO 42)  <= IN1_from_Matrix_stage2(16 DOWNTO 11);

---------------------------1-----------------------------

	MATRIX6X48(2)(9 DOWNTO 2) <= IN2_from_Matrix_stage2(7 DOWNTO 0);
--SX
	MATRIX6X48(2)(46 DOWNTO 42) <= IN2_from_Matrix_stage2(16 DOWNTO 12);


----------------------------2----------------------------
--DX
	MATRIX6X48(3)(9 DOWNTO 4) <= IN3_from_Matrix_stage2(5 DOWNTO 0);
--SX
	MATRIX6X48(3)(44 DOWNTO 42) <= IN3_from_Matrix_stage2(13 DOWNTO 11);


------------------------------3--------------------------
--DX
	MATRIX6X48(4)(9 DOWNTO 6) <= IN4_from_Matrix_stage2(3 DOWNTO 0);
--SX
	MATRIX6X48(4)(42) <= IN4_from_Matrix_stage2(9);


------------------------------4--------------------------
--DX
	MATRIX6X48(5)(9 DOWNTO 8) <= IN5_from_Matrix_stage2(1 DOWNTO 0);


------------------------------5--------------------------



END PROCESS;

-----------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Instance FAs HAs--------------------------------------------------------------------------
HA1 : HA PORT MAP (A => MATRIX6X48(0)(6),B => MATRIX6X48(1)(6),S => result_tmp(0),Cout => result_tmp(1));

HA2 : HA PORT MAP (A => MATRIX6X48(0)(7),B => MATRIX6X48(1)(7),S => result_tmp(2),Cout => result_tmp(3));

FA1 : FA PORT MAP (A => MATRIX6X48(0)(8),B => MATRIX6X48(1)(8),Cin => MATRIX6X48(2)(8),S => result_tmp(4),Cout => result_tmp(5));
HA3 : HA PORT MAP (A => MATRIX6X48(3)(8),B => MATRIX6X48(4)(8),S => result_tmp(6),Cout => result_tmp(7));

FA2 : FA PORT MAP (A => MATRIX6X48(0)(9),B => MATRIX6X48(1)(9),Cin => MATRIX6X48(2)(9),S => result_tmp(8),Cout => result_tmp(9));
HA4 : HA PORT MAP (A => MATRIX6X48(3)(9),B => MATRIX6X48(4)(9),S => result_tmp(10),Cout => result_tmp(11));

FA3 : FA PORT MAP (A => MATRIX6X48(0)(10),B => MATRIX6X48(1)(10),Cin => MATRIX6X48(2)(10),S => result_tmp(12),Cout => result_tmp(13));
FA4 : FA PORT MAP (A => MATRIX6X48(3)(10),B => MATRIX6X48(4)(10),Cin => MATRIX6X48(5)(10),S => result_tmp(14),Cout => result_tmp(15));

FA5 : FA PORT MAP (A => MATRIX6X48(0)(11),B => MATRIX6X48(1)(11),Cin => MATRIX6X48(2)(11),S => result_tmp(16),Cout => result_tmp(17));
FA6 : FA PORT MAP (A => MATRIX6X48(3)(11),B => MATRIX6X48(4)(11),Cin => MATRIX6X48(5)(11),S => result_tmp(18),Cout => result_tmp(19));

FA7 : FA PORT MAP (A => MATRIX6X48(0)(12),B => MATRIX6X48(1)(12),Cin => MATRIX6X48(2)(12),S => result_tmp(20),Cout => result_tmp(21));
FA8 : FA PORT MAP (A => MATRIX6X48(3)(12),B => MATRIX6X48(4)(12),Cin => MATRIX6X48(5)(12),S => result_tmp(22),Cout => result_tmp(23));

FA9 : FA PORT MAP (A => MATRIX6X48(0)(13),B => MATRIX6X48(1)(13),Cin => MATRIX6X48(2)(13),S => result_tmp(24),Cout => result_tmp(25));
FA10 : FA PORT MAP (A => MATRIX6X48(3)(13),B => MATRIX6X48(4)(13),Cin => MATRIX6X48(5)(13),S => result_tmp(26),Cout => result_tmp(27));

FA11 : FA PORT MAP (A => MATRIX6X48(0)(14),B => MATRIX6X48(1)(14),Cin => MATRIX6X48(2)(14),S => result_tmp(28),Cout => result_tmp(29));
FA12 : FA PORT MAP (A => MATRIX6X48(3)(14),B => MATRIX6X48(4)(14),Cin => MATRIX6X48(5)(14),S => result_tmp(30),Cout => result_tmp(31));

FA13 : FA PORT MAP (A => MATRIX6X48(0)(15),B => MATRIX6X48(1)(15),Cin => MATRIX6X48(2)(15),S => result_tmp(32),Cout => result_tmp(33));
FA14 : FA PORT MAP (A => MATRIX6X48(3)(15),B => MATRIX6X48(4)(15),Cin => MATRIX6X48(5)(15),S => result_tmp(34),Cout => result_tmp(35));

FA15 : FA PORT MAP (A => MATRIX6X48(0)(16),B => MATRIX6X48(1)(16),Cin => MATRIX6X48(2)(16),S => result_tmp(36),Cout => result_tmp(37));
FA16 : FA PORT MAP (A => MATRIX6X48(3)(16),B => MATRIX6X48(4)(16),Cin => MATRIX6X48(5)(16),S => result_tmp(38),Cout => result_tmp(39));

FA17 : FA PORT MAP (A => MATRIX6X48(0)(17),B => MATRIX6X48(1)(17),Cin => MATRIX6X48(2)(17),S => result_tmp(40),Cout => result_tmp(41));
FA18 : FA PORT MAP (A => MATRIX6X48(3)(17),B => MATRIX6X48(4)(17),Cin => MATRIX6X48(5)(17),S => result_tmp(42),Cout => result_tmp(43));

FA19 : FA PORT MAP (A => MATRIX6X48(0)(18),B => MATRIX6X48(1)(18),Cin => MATRIX6X48(2)(18),S => result_tmp(44),Cout => result_tmp(45));
FA20 : FA PORT MAP (A => MATRIX6X48(3)(18),B => MATRIX6X48(4)(18),Cin => MATRIX6X48(5)(18),S => result_tmp(46),Cout => result_tmp(47));

FA21 : FA PORT MAP (A => MATRIX6X48(0)(19),B => MATRIX6X48(1)(19),Cin => MATRIX6X48(2)(19),S => result_tmp(48),Cout => result_tmp(49));
FA22 : FA PORT MAP (A => MATRIX6X48(3)(19),B => MATRIX6X48(4)(19),Cin => MATRIX6X48(5)(19),S => result_tmp(50),Cout => result_tmp(51));

FA23 : FA PORT MAP (A => MATRIX6X48(0)(20),B => MATRIX6X48(1)(20),Cin => MATRIX6X48(2)(20),S => result_tmp(52),Cout => result_tmp(53));
FA24 : FA PORT MAP (A => MATRIX6X48(3)(20),B => MATRIX6X48(4)(20),Cin => MATRIX6X48(5)(20),S => result_tmp(54),Cout => result_tmp(55));

FA25 : FA PORT MAP (A => MATRIX6X48(0)(21),B => MATRIX6X48(1)(21),Cin => MATRIX6X48(2)(21),S => result_tmp(56),Cout => result_tmp(57));
FA26 : FA PORT MAP (A => MATRIX6X48(3)(21),B => MATRIX6X48(4)(21),Cin => MATRIX6X48(5)(21),S => result_tmp(58),Cout => result_tmp(59));

FA27 : FA PORT MAP (A => MATRIX6X48(0)(22),B => MATRIX6X48(1)(22),Cin => MATRIX6X48(2)(22),S => result_tmp(60),Cout => result_tmp(61));
FA28 : FA PORT MAP (A => MATRIX6X48(3)(22),B => MATRIX6X48(4)(22),Cin => MATRIX6X48(5)(22),S => result_tmp(62),Cout => result_tmp(63));

FA29 : FA PORT MAP (A => MATRIX6X48(0)(23),B => MATRIX6X48(1)(23),Cin => MATRIX6X48(2)(23),S => result_tmp(64),Cout => result_tmp(65));
FA30 : FA PORT MAP (A => MATRIX6X48(3)(23),B => MATRIX6X48(4)(23),Cin => MATRIX6X48(5)(23),S => result_tmp(66),Cout => result_tmp(67));

FA31 : FA PORT MAP (A => MATRIX6X48(0)(24),B => MATRIX6X48(1)(24),Cin => MATRIX6X48(2)(24),S => result_tmp(68),Cout => result_tmp(69));
FA32 : FA PORT MAP (A => MATRIX6X48(3)(24),B => MATRIX6X48(4)(24),Cin => MATRIX6X48(5)(24),S => result_tmp(70),Cout => result_tmp(71));

FA33 : FA PORT MAP (A => MATRIX6X48(0)(25),B => MATRIX6X48(1)(25),Cin => MATRIX6X48(2)(25),S => result_tmp(72),Cout => result_tmp(73));
FA34 : FA PORT MAP (A => MATRIX6X48(3)(25),B => MATRIX6X48(4)(25),Cin => MATRIX6X48(5)(25),S => result_tmp(74),Cout => result_tmp(75));

FA35 : FA PORT MAP (A => MATRIX6X48(0)(26),B => MATRIX6X48(1)(26),Cin => MATRIX6X48(2)(26),S => result_tmp(76),Cout => result_tmp(77));
FA36 : FA PORT MAP (A => MATRIX6X48(3)(26),B => MATRIX6X48(4)(26),Cin => MATRIX6X48(5)(26),S => result_tmp(78),Cout => result_tmp(79));

FA37 : FA PORT MAP (A => MATRIX6X48(0)(27),B => MATRIX6X48(1)(27),Cin => MATRIX6X48(2)(27),S => result_tmp(80),Cout => result_tmp(81));
FA38 : FA PORT MAP (A => MATRIX6X48(3)(27),B => MATRIX6X48(4)(27),Cin => MATRIX6X48(5)(27),S => result_tmp(82),Cout => result_tmp(83));

FA39 : FA PORT MAP (A => MATRIX6X48(0)(28),B => MATRIX6X48(1)(28),Cin => MATRIX6X48(2)(28),S => result_tmp(84),Cout => result_tmp(85));
FA40 : FA PORT MAP (A => MATRIX6X48(3)(28),B => MATRIX6X48(4)(28),Cin => MATRIX6X48(5)(28),S => result_tmp(86),Cout => result_tmp(87));

FA41 : FA PORT MAP (A => MATRIX6X48(0)(29),B => MATRIX6X48(1)(29),Cin => MATRIX6X48(2)(29),S => result_tmp(88),Cout => result_tmp(89));
FA42 : FA PORT MAP (A => MATRIX6X48(3)(29),B => MATRIX6X48(4)(29),Cin => MATRIX6X48(5)(29),S => result_tmp(90),Cout => result_tmp(91));

FA43 : FA PORT MAP (A => MATRIX6X48(0)(30),B => MATRIX6X48(1)(30),Cin => MATRIX6X48(2)(30),S => result_tmp(92),Cout => result_tmp(93));
FA44 : FA PORT MAP (A => MATRIX6X48(3)(30),B => MATRIX6X48(4)(30),Cin => MATRIX6X48(5)(30),S => result_tmp(94),Cout => result_tmp(95));

FA45 : FA PORT MAP (A => MATRIX6X48(0)(31),B => MATRIX6X48(1)(31),Cin => MATRIX6X48(2)(31),S => result_tmp(96),Cout => result_tmp(97));
FA46 : FA PORT MAP (A => MATRIX6X48(3)(31),B => MATRIX6X48(4)(31),Cin => MATRIX6X48(5)(31),S => result_tmp(98),Cout => result_tmp(99));

FA47 : FA PORT MAP (A => MATRIX6X48(0)(32),B => MATRIX6X48(1)(32),Cin => MATRIX6X48(2)(32),S => result_tmp(100),Cout => result_tmp(101));
FA48 : FA PORT MAP (A => MATRIX6X48(3)(32),B => MATRIX6X48(4)(32),Cin => MATRIX6X48(5)(32),S => result_tmp(102),Cout => result_tmp(103));

FA49 : FA PORT MAP (A => MATRIX6X48(0)(33),B => MATRIX6X48(1)(33),Cin => MATRIX6X48(2)(33),S => result_tmp(104),Cout => result_tmp(105));
FA50 : FA PORT MAP (A => MATRIX6X48(3)(33),B => MATRIX6X48(4)(33),Cin => MATRIX6X48(5)(33),S => result_tmp(106),Cout => result_tmp(107));

FA51 : FA PORT MAP (A => MATRIX6X48(0)(34),B => MATRIX6X48(1)(34),Cin => MATRIX6X48(2)(34),S => result_tmp(108),Cout => result_tmp(109));
FA52 : FA PORT MAP (A => MATRIX6X48(3)(34),B => MATRIX6X48(4)(34),Cin => MATRIX6X48(5)(34),S => result_tmp(110),Cout => result_tmp(111));

FA53 : FA PORT MAP (A => MATRIX6X48(0)(35),B => MATRIX6X48(1)(35),Cin => MATRIX6X48(2)(35),S => result_tmp(112),Cout => result_tmp(113));
FA54 : FA PORT MAP (A => MATRIX6X48(3)(35),B => MATRIX6X48(4)(35),Cin => MATRIX6X48(5)(35),S => result_tmp(114),Cout => result_tmp(115));

FA55 : FA PORT MAP (A => MATRIX6X48(0)(36),B => MATRIX6X48(1)(36),Cin => MATRIX6X48(2)(36),S => result_tmp(116),Cout => result_tmp(117));
FA56 : FA PORT MAP (A => MATRIX6X48(3)(36),B => MATRIX6X48(4)(36),Cin => MATRIX6X48(5)(36),S => result_tmp(118),Cout => result_tmp(119));

FA57 : FA PORT MAP (A => MATRIX6X48(0)(37),B => MATRIX6X48(1)(37),Cin => MATRIX6X48(2)(37),S => result_tmp(120),Cout => result_tmp(121));
FA58 : FA PORT MAP (A => MATRIX6X48(3)(37),B => MATRIX6X48(4)(37),Cin => MATRIX6X48(5)(37),S => result_tmp(122),Cout => result_tmp(123));

FA59 : FA PORT MAP (A => MATRIX6X48(0)(38),B => MATRIX6X48(1)(38),Cin => MATRIX6X48(2)(38),S => result_tmp(124),Cout => result_tmp(125));
FA60 : FA PORT MAP (A => MATRIX6X48(3)(38),B => MATRIX6X48(4)(38),Cin => MATRIX6X48(5)(38),S => result_tmp(126),Cout => result_tmp(127));

FA61 : FA PORT MAP (A => MATRIX6X48(0)(39),B => MATRIX6X48(1)(39),Cin => MATRIX6X48(2)(39),S => result_tmp(128),Cout => result_tmp(129));
FA62 : FA PORT MAP (A => MATRIX6X48(3)(39),B => MATRIX6X48(4)(39),Cin => MATRIX6X48(5)(39),S => result_tmp(130),Cout => result_tmp(131));

FA63 : FA PORT MAP (A => MATRIX6X48(0)(40),B => MATRIX6X48(1)(40),Cin => MATRIX6X48(2)(40),S => result_tmp(132),Cout => result_tmp(133));
FA64 : FA PORT MAP (A => MATRIX6X48(3)(40),B => MATRIX6X48(4)(40),Cin => MATRIX6X48(5)(40),S => result_tmp(134),Cout => result_tmp(135));

FA65 : FA PORT MAP (A => MATRIX6X48(0)(41),B => MATRIX6X48(1)(41),Cin => MATRIX6X48(2)(41),S => result_tmp(136),Cout => result_tmp(137));
FA66 : FA PORT MAP (A => MATRIX6X48(3)(41),B => MATRIX6X48(4)(41),Cin => MATRIX6X48(5)(41),S => result_tmp(138),Cout => result_tmp(139));

FA67 : FA PORT MAP (A => MATRIX6X48(0)(42),B => MATRIX6X48(1)(42),Cin => MATRIX6X48(2)(42),S => result_tmp(140),Cout => result_tmp(141));
HA5 : HA PORT MAP (A => MATRIX6X48(3)(42),B => MATRIX6X48(4)(42),S => result_tmp(142),Cout => result_tmp(143));

FA68 : FA PORT MAP (A => MATRIX6X48(0)(43),B => MATRIX6X48(1)(43),Cin => MATRIX6X48(2)(43),S => result_tmp(144),Cout => result_tmp(145));

HA6 : HA PORT MAP (A => MATRIX6X48(0)(44),B => MATRIX6X48(1)(44),S => result_tmp(146),Cout => result_tmp(147));



---------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------Assignment output vectors--------------------------------------------------------------------------------------------------------


	V0(5 DOWNTO 0) <= IN0_from_Matrix_stage2(5 DOWNTO 0);
	--SX
	V0(8 DOWNTO 6) <= IN0_from_Matrix_stage2(16 DOWNTO 14);
	
	
	
	V1(5 DOWNTO 0) <= IN1_from_Matrix_stage2(5 DOWNTO 0);
	--SX
	V1(8 DOWNTO 6) <= IN1_from_Matrix_stage2(16 DOWNTO 14);
	
	
	
	V2(5 DOWNTO 0) <= IN2_from_Matrix_stage2(5 DOWNTO 0);
	--SX
	V2(8 DOWNTO 6) <= IN2_from_Matrix_stage2(16 DOWNTO 14);
	
	

	V3(3 DOWNTO 0) <= IN3_from_Matrix_stage2(3 DOWNTO 0);
	--SX
	V3(5 DOWNTO 4) <= IN3_from_Matrix_stage2(13 DOWNTO 12);
	
	
	V4(1 DOWNTO 0) <= IN4_from_Matrix_stage2(1 DOWNTO 0);
	
	
	V5(1 DOWNTO 0) <= IN5_from_Matrix_stage2(1 DOWNTO 0);


-------------------------------------------------------------------------------------------------------------------------
--output
Results_FA_HA_Stage4 <= result_tmp;



END ARCHITECTURE;