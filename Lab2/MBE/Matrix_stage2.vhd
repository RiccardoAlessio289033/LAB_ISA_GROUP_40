LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  Matrix_stage2  IS
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
END Matrix_stage2;

ARCHITECTURE  mat1 OF Matrix_stage2 IS


SIGNAL result_tmp: STD_LOGIC_VECTOR (161 DOWNTO 0);  


type MATRIX is array (0 TO 8) of STD_LOGIC_VECTOR (47 DOWNTO 0); --number of rows/columns
SIGNAL MATRIX9X48 : MATRIX := (OTHERS => (OTHERS => '0'));


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
---------------------------------------------------------------------------Assign internal part-----------------------------------
PROCESS(Results_from_Matrix_stage1)

	
	BEGIN
	

	--0 line assignment intern
	MATRIX9X48(0)(16) <= Results_from_Matrix_stage1(0);
	MATRIX9X48(0)(17) <= Results_from_Matrix_stage1(2);
	MATRIX9X48(0)(18) <= Results_from_Matrix_stage1(4);
	MATRIX9X48(0)(19) <= Results_from_Matrix_stage1(8);
	MATRIX9X48(0)(20) <= Results_from_Matrix_stage1(12);
	MATRIX9X48(0)(21) <= Results_from_Matrix_stage1(18);
	MATRIX9X48(0)(22) <= Results_from_Matrix_stage1(24);
	MATRIX9X48(0)(23) <= Results_from_Matrix_stage1(32);
	MATRIX9X48(0)(24) <= Results_from_Matrix_stage1(40);
	MATRIX9X48(0)(25) <= Results_from_Matrix_stage1(48);
	MATRIX9X48(0)(26) <= Results_from_Matrix_stage1(56);
	MATRIX9X48(0)(27) <= Results_from_Matrix_stage1(64);
	MATRIX9X48(0)(28) <= Results_from_Matrix_stage1(72);
	MATRIX9X48(0)(29) <= Results_from_Matrix_stage1(80);
	MATRIX9X48(0)(30) <= Results_from_Matrix_stage1(86);
	MATRIX9X48(0)(31) <= Results_from_Matrix_stage1(92);
	MATRIX9X48(0)(32) <= Results_from_Matrix_stage1(96);
	MATRIX9X48(0)(33) <= Results_from_Matrix_stage1(100);
	MATRIX9X48(0)(34) <= Results_from_Matrix_stage1(102);

	--0 line assignment external partSX
	MATRIX9X48(0)(35) <= IN0_from_Matrix_stage1(16);
--------------------------------------------------------
	--1 line assignment intern
	MATRIX9X48(1)(17) <= Results_from_Matrix_stage1(1);
	MATRIX9X48(1)(18) <= Results_from_Matrix_stage1(3);
	MATRIX9X48(1)(19) <= Results_from_Matrix_stage1(7);
	MATRIX9X48(1)(20) <= Results_from_Matrix_stage1(11);
	MATRIX9X48(1)(21) <= Results_from_Matrix_stage1(17);
	MATRIX9X48(1)(22) <= Results_from_Matrix_stage1(23);
	MATRIX9X48(1)(23) <= Results_from_Matrix_stage1(31);
	MATRIX9X48(1)(24) <= Results_from_Matrix_stage1(39);
	MATRIX9X48(1)(25) <= Results_from_Matrix_stage1(47);
	MATRIX9X48(1)(26) <= Results_from_Matrix_stage1(54);
	MATRIX9X48(1)(27) <= Results_from_Matrix_stage1(63);
	MATRIX9X48(1)(28) <= Results_from_Matrix_stage1(71);
	MATRIX9X48(1)(29) <= Results_from_Matrix_stage1(79);
	MATRIX9X48(1)(30) <= Results_from_Matrix_stage1(85);
	MATRIX9X48(1)(31) <= Results_from_Matrix_stage1(91);
	MATRIX9X48(1)(32) <= Results_from_Matrix_stage1(95);
	MATRIX9X48(1)(33) <= Results_from_Matrix_stage1(99);
	MATRIX9X48(1)(34) <= Results_from_Matrix_stage1(101);
	MATRIX9X48(1)(35) <= Results_from_Matrix_stage1(103);
	
	--1 line assignment external partDX
	MATRIX9X48(1)(16) <= IN2_from_Matrix_stage1(14);


--------------------------------------------------------
	--2 line assignment intern
	MATRIX9X48(2)(18) <= Results_from_Matrix_stage1(6);
	MATRIX9X48(2)(19) <= Results_from_Matrix_stage1(10);
	MATRIX9X48(2)(20) <= Results_from_Matrix_stage1(14);
	MATRIX9X48(2)(21) <= Results_from_Matrix_stage1(20);
	MATRIX9X48(2)(22) <= Results_from_Matrix_stage1(26);
	MATRIX9X48(2)(23) <= Results_from_Matrix_stage1(34);
	MATRIX9X48(2)(24) <= Results_from_Matrix_stage1(42);
	MATRIX9X48(2)(25) <= Results_from_Matrix_stage1(50);
	MATRIX9X48(2)(26) <= Results_from_Matrix_stage1(58);
	MATRIX9X48(2)(27) <= Results_from_Matrix_stage1(66);
	MATRIX9X48(2)(28) <= Results_from_Matrix_stage1(74);
	MATRIX9X48(2)(29) <= Results_from_Matrix_stage1(82);
	MATRIX9X48(2)(30) <= Results_from_Matrix_stage1(88);
	MATRIX9X48(2)(31) <= Results_from_Matrix_stage1(94);
	MATRIX9X48(2)(32) <= Results_from_Matrix_stage1(98);
	
	--2 line assignment external partDX
	MATRIX9X48(2)(16) <= IN3_from_Matrix_stage1(12);
	MATRIX9X48(2)(17) <= IN2_from_Matrix_stage1(15);

	--2 line assignment external partSX
	MATRIX9X48(2)(33) <= IN3_from_Matrix_stage1(14);
	MATRIX9X48(2)(34) <= IN2_from_Matrix_stage1(16);
	MATRIX9X48(2)(35) <= IN1_from_Matrix_stage1(16);


--------------------------------------------------------
	--3 line assignment intern
	MATRIX9X48(3)(13) <= Results_from_Matrix_stage1(7);
	MATRIX9X48(3)(14) <= Results_from_Matrix_stage1(11);
	MATRIX9X48(3)(15) <= Results_from_Matrix_stage1(15);
	MATRIX9X48(3)(16) <= Results_from_Matrix_stage1(21);
	MATRIX9X48(3)(13) <= Results_from_Matrix_stage1(27);
	MATRIX9X48(3)(14) <= Results_from_Matrix_stage1(35);
	MATRIX9X48(3)(15) <= Results_from_Matrix_stage1(43);
	MATRIX9X48(3)(16) <= Results_from_Matrix_stage1(51);
	MATRIX9X48(3)(13) <= Results_from_Matrix_stage1(59);
	MATRIX9X48(3)(14) <= Results_from_Matrix_stage1(67);
	MATRIX9X48(3)(15) <= Results_from_Matrix_stage1(75);
	MATRIX9X48(3)(16) <= Results_from_Matrix_stage1(83);
	MATRIX9X48(3)(13) <= Results_from_Matrix_stage1(89);
	MATRIX9X48(3)(14) <= Results_from_Matrix_stage1(95);
	MATRIX9X48(3)(15) <= Results_from_Matrix_stage1(99);
	
	--3 line assignment external partDX
	MATRIX9X48(3)(16) <= IN4_from_Matrix_stage1(10);
	MATRIX9X48(3)(17) <= IN3_from_Matrix_stage1(13);
	MATRIX9X48(3)(18) <= IN5_from_Matrix_stage1(10);

	--3 line assignment external partSX
	MATRIX9X48(3)(34) <= IN3_from_Matrix_stage1(15);
	MATRIX9X48(3)(35) <= IN2_from_Matrix_stage1(17);


--------------------------------------------------------
	--4 line assignment intern
	MATRIX9X48(4)(20) <= Results_from_Matrix_stage1(16);
	MATRIX9X48(4)(21) <= Results_from_Matrix_stage1(22);
	MATRIX9X48(4)(22) <= Results_from_Matrix_stage1(28);
	MATRIX9X48(4)(23) <= Results_from_Matrix_stage1(36);
	MATRIX9X48(4)(24) <= Results_from_Matrix_stage1(44);
	MATRIX9X48(4)(25) <= Results_from_Matrix_stage1(52);
	MATRIX9X48(4)(26) <= Results_from_Matrix_stage1(60);
	MATRIX9X48(4)(27) <= Results_from_Matrix_stage1(68);
	MATRIX9X48(4)(28) <= Results_from_Matrix_stage1(76);
	MATRIX9X48(4)(29) <= Results_from_Matrix_stage1(84);
	MATRIX9X48(4)(30) <= Results_from_Matrix_stage1(90);
	
	--4 line assignment external partDX
	MATRIX9X48(4)(16) <= IN5_from_Matrix_stage1(8);
	MATRIX9X48(4)(17) <= IN4_from_Matrix_stage1(11);
	MATRIX9X48(4)(18) <= IN6_from_Matrix_stage1(8);
	MATRIX9X48(4)(19) <= IN5_from_Matrix_stage1(11);

	--4 line assignment external partSX
	MATRIX9X48(4)(31) <= IN6_from_Matrix_stage1(10);
	MATRIX9X48(4)(32) <= IN5_from_Matrix_stage1(12);
	MATRIX9X48(4)(33) <= IN4_from_Matrix_stage1(12);
	MATRIX9X48(4)(34) <= IN4_from_Matrix_stage1(13);
	MATRIX9X48(4)(35) <= IN3_from_Matrix_stage1(16);


--------------------------------------------------------
	--5 line assignment intern
	MATRIX9X48(5)(21) <= Results_from_Matrix_stage1(17);
	MATRIX9X48(5)(22) <= Results_from_Matrix_stage1(23);
	MATRIX9X48(5)(23) <= Results_from_Matrix_stage1(29);
	MATRIX9X48(5)(24) <= Results_from_Matrix_stage1(37);
	MATRIX9X48(5)(25) <= Results_from_Matrix_stage1(45);
	MATRIX9X48(5)(26) <= Results_from_Matrix_stage1(53);
	MATRIX9X48(5)(27) <= Results_from_Matrix_stage1(61);
	MATRIX9X48(5)(28) <= Results_from_Matrix_stage1(69);
	MATRIX9X48(5)(29) <= Results_from_Matrix_stage1(77);
	MATRIX9X48(5)(30) <= Results_from_Matrix_stage1(85);
	MATRIX9X48(5)(31) <= Results_from_Matrix_stage1(91);
	
	--5 line assignment external partDX
	MATRIX9X48(5)(16) <= IN6_from_Matrix_stage1(6);
	MATRIX9X48(5)(17) <= IN5_from_Matrix_stage1(9);
	MATRIX9X48(5)(18) <= IN7_from_Matrix_stage1(6);
	MATRIX9X48(5)(19) <= IN6_from_Matrix_stage1(9);
	MATRIX9X48(5)(20) <= IN8_from_Matrix_stage1(6);

	--5 line assignment external partSX
	MATRIX9X48(5)(32) <= IN6_from_Matrix_stage1(11);
	MATRIX9X48(5)(33) <= IN5_from_Matrix_stage1(13);
	MATRIX9X48(5)(34) <= IN5_from_Matrix_stage1(14);
	MATRIX9X48(5)(35) <= IN4_from_Matrix_stage1(14);


--------------------------------------------------------
	--6 line assignment intern
	MATRIX9X48(6)(22) <= Results_from_Matrix_stage1(30);
	MATRIX9X48(6)(23) <= Results_from_Matrix_stage1(38);
	MATRIX9X48(6)(24) <= Results_from_Matrix_stage1(46);
	MATRIX9X48(6)(25) <= Results_from_Matrix_stage1(54);
	MATRIX9X48(6)(26) <= Results_from_Matrix_stage1(62);
	MATRIX9X48(6)(27) <= Results_from_Matrix_stage1(70);
	MATRIX9X48(6)(28) <= Results_from_Matrix_stage1(78);
	
	--6 line assignment external partDX
	MATRIX9X48(6)(16) <= IN7_from_Matrix_stage1(4);
	MATRIX9X48(6)(17) <= IN6_from_Matrix_stage1(7);
	MATRIX9X48(6)(18) <= IN8_from_Matrix_stage1(4);
	MATRIX9X48(6)(19) <= IN7_from_Matrix_stage1(7);
	MATRIX9X48(6)(20) <= IN9_from_Matrix_stage1(4);
	MATRIX9X48(6)(21) <= IN8_from_Matrix_stage1(7);

	--6 line assignment external partSX
	MATRIX9X48(6)(29) <= IN9_from_Matrix_stage1(6);
	MATRIX9X48(6)(30) <= IN8_from_Matrix_stage1(8);
	MATRIX9X48(6)(31) <= IN7_from_Matrix_stage1(8);
	MATRIX9X48(6)(32) <= IN7_from_Matrix_stage1(9);
	MATRIX9X48(6)(33) <= IN6_from_Matrix_stage1(12);
	MATRIX9X48(6)(34) <= IN6_from_Matrix_stage1(13);
	MATRIX9X48(6)(35) <= IN5_from_Matrix_stage1(14);


--------------------------------------------------------
	--7 line assignment intern
	MATRIX9X48(7)(23) <= Results_from_Matrix_stage1(31);
	MATRIX9X48(7)(24) <= Results_from_Matrix_stage1(39);
	MATRIX9X48(7)(25) <= Results_from_Matrix_stage1(47);
	MATRIX9X48(7)(26) <= Results_from_Matrix_stage1(55);
	MATRIX9X48(7)(27) <= Results_from_Matrix_stage1(63);
	MATRIX9X48(7)(28) <= Results_from_Matrix_stage1(71);
	MATRIX9X48(7)(29) <= Results_from_Matrix_stage1(79);
	
	--7 line assignment external partDX
	MATRIX9X48(7)(16) <= IN8_from_Matrix_stage1(2);
	MATRIX9X48(7)(17) <= IN7_from_Matrix_stage1(5);
	MATRIX9X48(7)(18) <= IN9_from_Matrix_stage1(2);
	MATRIX9X48(7)(19) <= IN8_from_Matrix_stage1(5);
	MATRIX9X48(7)(20) <= IN10_from_Matrix_stage1(2);
	MATRIX9X48(7)(21) <= IN9_from_Matrix_stage1(5);
	MATRIX9X48(7)(22) <= IN11_from_Matrix_stage1(2);

	--7 line assignment external partSX
	MATRIX9X48(7)(30) <= IN9_from_Matrix_stage1(7);
	MATRIX9X48(7)(31) <= IN8_from_Matrix_stage1(9);
	MATRIX9X48(7)(32) <= IN8_from_Matrix_stage1(10);
	MATRIX9X48(7)(33) <= IN7_from_Matrix_stage1(10);
	MATRIX9X48(7)(34) <= IN7_from_Matrix_stage1(11);
	MATRIX9X48(7)(35) <= IN6_from_Matrix_stage1(14);


--------------------------------------------------------
	--8 line assignment intern
	MATRIX9X48(8)(35) <= IN7_from_Matrix_stage1(12);
	MATRIX9X48(8)(34) <= IN8_from_Matrix_stage1(12);
	MATRIX9X48(8)(33) <= IN8_from_Matrix_stage1(11);
	MATRIX9X48(8)(32) <= IN9_from_Matrix_stage1(9);
	MATRIX9X48(8)(31) <= IN9_from_Matrix_stage1(8);
	MATRIX9X48(8)(30) <= IN10_from_Matrix_stage1(5);
	MATRIX9X48(8)(29) <= IN10_from_Matrix_stage1(4);
	MATRIX9X48(8)(28) <= IN11_from_Matrix_stage1(4);
	MATRIX9X48(8)(27 DOWNTO 24) <= IN12_from_Matrix_stage1(5 DOWNTO 2);
	MATRIX9X48(8)(23) <= IN11_from_Matrix_stage1(3);
	MATRIX9X48(8)(22) <= IN12_from_Matrix_stage1(0);
	MATRIX9X48(8)(21) <= IN10_from_Matrix_stage1(3);
	MATRIX9X48(8)(20) <= IN11_from_Matrix_stage1(0);
	MATRIX9X48(8)(19) <= IN9_from_Matrix_stage1(3);
	MATRIX9X48(8)(18) <= IN10_from_Matrix_stage1(0);
	MATRIX9X48(8)(17) <= IN8_from_Matrix_stage1(3);
	MATRIX9X48(8)(16) <= IN9_from_Matrix_stage1(0);
	


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Assign external part----------------------------------------------------------------------

  
	MATRIX9X48(0)(15 DOWNTO 0)  <= IN0_from_Matrix_stage1(15 DOWNTO 0);    
	MATRIX9X48(0)(47 DOWNTO 36)  <= IN0_from_Matrix_stage1(28 DOWNTO 17);


-------------------------0-------------------------------

	MATRIX9X48(1)(15 DOWNTO 0)  <= IN1_from_Matrix_stage1(15 DOWNTO 0);
	MATRIX9X48(1)(47 DOWNTO 36)  <= IN1_from_Matrix_stage1(28 DOWNTO 17);

---------------------------1-----------------------------

    	MATRIX9X48(2)(15 DOWNTO 2) <= IN2_from_Matrix_stage1(13 DOWNTO 0);
    	MATRIX9X48(2)(46 DOWNTO 36) <= IN2_from_Matrix_stage1(28 DOWNTO 18);

----------------------------2----------------------------

    	MATRIX9X48(3)(15 DOWNTO 4) <= IN3_from_Matrix_stage1(11 DOWNTO 0);
    	MATRIX9X48(3)(44 DOWNTO 36) <= IN3_from_Matrix_stage1(25 DOWNTO 17);

------------------------------3--------------------------

    	MATRIX9X48(4)(15 DOWNTO 6) <= IN4_from_Matrix_stage1(9 DOWNTO 0);
		MATRIX9X48(4)(42 DOWNTO 36) <= IN4_from_Matrix_stage1(21 DOWNTO 15);

-------------------------------4-------------------------

	MATRIX9X48(5)(15 DOWNTO 8) <= IN5_from_Matrix_stage1(7 DOWNTO 0);
	MATRIX9X48(5)(40 DOWNTO 36) <= IN5_from_Matrix_stage1(20 DOWNTO 16);
	
-----------------------------5---------------------------

	MATRIX9X48(6)(15 DOWNTO 10) <= IN6_from_Matrix_stage1(5 DOWNTO 0);
	MATRIX9X48(6)(38 DOWNTO 36) <= IN6_from_Matrix_stage1(17 DOWNTO 15);
	
-----------------------------6---------------------------

	MATRIX9X48(7)(15 DOWNTO 12) <= IN7_from_Matrix_stage1(3 DOWNTO 0);
	MATRIX9X48(7)(36) <= IN7_from_Matrix_stage1(13);
	
-----------------------------7---------------------------

	MATRIX9X48(8)(15 DOWNTO 14) <= IN8_from_Matrix_stage1(1 DOWNTO 0);
	
-----------------------------8---------------------------
----------------------------------------------------------------------------------------------

END PROCESS;



-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Instance FAs HAs--------------------------------------------------------------------------
HA1 : HA PORT MAP (A => MATRIX9X48(0)(10),B => MATRIX9X48(1)(10),S => result_tmp(0),Cout => result_tmp(1));

HA2 : HA PORT MAP (A => MATRIX9X48(0)(11),B => MATRIX9X48(1)(11),S => result_tmp(2),Cout => result_tmp(3));

FA1 : FA PORT MAP (A => MATRIX9X48(0)(12),B => MATRIX9X48(1)(12),Cin => MATRIX9X48(2)(8),S => result_tmp(4),Cout => result_tmp(5));
HA3 : HA PORT MAP (A => MATRIX9X48(3)(12),B => MATRIX9X48(4)(12),S => result_tmp(6),Cout => result_tmp(7));

FA2 : FA PORT MAP (A => MATRIX9X48(0)(13),B => MATRIX9X48(1)(13),Cin => MATRIX9X48(2)(13),S => result_tmp(8),Cout => result_tmp(9));
HA4 : HA PORT MAP (A => MATRIX9X48(3)(13),B => MATRIX9X48(4)(13),S => result_tmp(10),Cout => result_tmp(11));

FA3 : FA PORT MAP (A => MATRIX9X48(0)(14),B => MATRIX9X48(1)(14),Cin => MATRIX9X48(2)(14),S => result_tmp(12),Cout => result_tmp(13));
FA4 : FA PORT MAP (A => MATRIX9X48(3)(14),B => MATRIX9X48(4)(14),Cin => MATRIX9X48(5)(14),S => result_tmp(14),Cout => result_tmp(15));
HA5 : HA PORT MAP (A => MATRIX9X48(6)(14),B => MATRIX9X48(7)(14),S => result_tmp(16),Cout => result_tmp(17));

FA5 : FA PORT MAP (A => MATRIX9X48(0)(15),B => MATRIX9X48(1)(15),Cin => MATRIX9X48(2)(15),S => result_tmp(18),Cout => result_tmp(19));
FA6 : FA PORT MAP (A => MATRIX9X48(3)(15),B => MATRIX9X48(4)(15),Cin => MATRIX9X48(5)(15),S => result_tmp(20),Cout => result_tmp(21));
HA6 : HA PORT MAP (A => MATRIX9X48(6)(15),B => MATRIX9X48(7)(15),S => result_tmp(22),Cout => result_tmp(23));

FA7 : FA PORT MAP (A => MATRIX9X48(0)(16),B => MATRIX9X48(1)(16),Cin => MATRIX9X48(2)(16),S => result_tmp(24),Cout => result_tmp(25));
FA8 : FA PORT MAP (A => MATRIX9X48(3)(16),B => MATRIX9X48(4)(16),Cin => MATRIX9X48(5)(16),S => result_tmp(26),Cout => result_tmp(27));
FA9 : FA PORT MAP (A => MATRIX9X48(6)(16),B => MATRIX9X48(7)(16),Cin => MATRIX9X48(8)(16),S => result_tmp(28),Cout => result_tmp(29));

FA10 : FA PORT MAP (A => MATRIX9X48(0)(17),B => MATRIX9X48(1)(17),Cin => MATRIX9X48(2)(17),S => result_tmp(30),Cout => result_tmp(31));
FA11 : FA PORT MAP (A => MATRIX9X48(3)(17),B => MATRIX9X48(4)(17),Cin => MATRIX9X48(5)(17),S => result_tmp(32),Cout => result_tmp(33));
FA12 : FA PORT MAP (A => MATRIX9X48(6)(17),B => MATRIX9X48(7)(17),Cin => MATRIX9X48(8)(17),S => result_tmp(34),Cout => result_tmp(35));

FA13 : FA PORT MAP (A => MATRIX9X48(0)(18),B => MATRIX9X48(1)(18),Cin => MATRIX9X48(2)(18),S => result_tmp(36),Cout => result_tmp(37));
FA14 : FA PORT MAP (A => MATRIX9X48(3)(18),B => MATRIX9X48(4)(18),Cin => MATRIX9X48(5)(18),S => result_tmp(38),Cout => result_tmp(39));
FA15 : FA PORT MAP (A => MATRIX9X48(6)(18),B => MATRIX9X48(7)(18),Cin => MATRIX9X48(8)(18),S => result_tmp(40),Cout => result_tmp(41));

FA16 : FA PORT MAP (A => MATRIX9X48(0)(19),B => MATRIX9X48(1)(19),Cin => MATRIX9X48(2)(19),S => result_tmp(42),Cout => result_tmp(43));
FA17 : FA PORT MAP (A => MATRIX9X48(3)(19),B => MATRIX9X48(4)(19),Cin => MATRIX9X48(5)(19),S => result_tmp(44),Cout => result_tmp(45));
FA18 : FA PORT MAP (A => MATRIX9X48(6)(19),B => MATRIX9X48(7)(19),Cin => MATRIX9X48(8)(19),S => result_tmp(46),Cout => result_tmp(47));

FA19 : FA PORT MAP (A => MATRIX9X48(0)(20),B => MATRIX9X48(1)(20),Cin => MATRIX9X48(2)(20),S => result_tmp(48),Cout => result_tmp(49));
FA20 : FA PORT MAP (A => MATRIX9X48(3)(20),B => MATRIX9X48(4)(20),Cin => MATRIX9X48(5)(20),S => result_tmp(50),Cout => result_tmp(51));
FA21 : FA PORT MAP (A => MATRIX9X48(6)(20),B => MATRIX9X48(7)(20),Cin => MATRIX9X48(8)(20),S => result_tmp(52),Cout => result_tmp(53));

FA22 : FA PORT MAP (A => MATRIX9X48(0)(21),B => MATRIX9X48(1)(21),Cin => MATRIX9X48(2)(21),S => result_tmp(54),Cout => result_tmp(55));
FA23 : FA PORT MAP (A => MATRIX9X48(3)(21),B => MATRIX9X48(4)(21),Cin => MATRIX9X48(5)(21),S => result_tmp(56),Cout => result_tmp(57));
FA24 : FA PORT MAP (A => MATRIX9X48(6)(21),B => MATRIX9X48(7)(21),Cin => MATRIX9X48(8)(21),S => result_tmp(58),Cout => result_tmp(59));

FA25 : FA PORT MAP (A => MATRIX9X48(0)(22),B => MATRIX9X48(1)(22),Cin => MATRIX9X48(2)(22),S => result_tmp(60),Cout => result_tmp(61));
FA26 : FA PORT MAP (A => MATRIX9X48(3)(22),B => MATRIX9X48(4)(22),Cin => MATRIX9X48(5)(22),S => result_tmp(62),Cout => result_tmp(63));
FA27 : FA PORT MAP (A => MATRIX9X48(6)(22),B => MATRIX9X48(7)(22),Cin => MATRIX9X48(8)(22),S => result_tmp(64),Cout => result_tmp(65));

FA28 : FA PORT MAP (A => MATRIX9X48(0)(23),B => MATRIX9X48(1)(23),Cin => MATRIX9X48(2)(23),S => result_tmp(66),Cout => result_tmp(67));
FA29 : FA PORT MAP (A => MATRIX9X48(3)(23),B => MATRIX9X48(4)(23),Cin => MATRIX9X48(5)(23),S => result_tmp(68),Cout => result_tmp(69));
FA30 : FA PORT MAP (A => MATRIX9X48(6)(23),B => MATRIX9X48(7)(23),Cin => MATRIX9X48(8)(23),S => result_tmp(70),Cout => result_tmp(71));

FA31 : FA PORT MAP (A => MATRIX9X48(0)(24),B => MATRIX9X48(1)(24),Cin => MATRIX9X48(2)(24),S => result_tmp(72),Cout => result_tmp(73));
FA32 : FA PORT MAP (A => MATRIX9X48(3)(24),B => MATRIX9X48(4)(24),Cin => MATRIX9X48(5)(24),S => result_tmp(74),Cout => result_tmp(75));
FA33 : FA PORT MAP (A => MATRIX9X48(6)(24),B => MATRIX9X48(7)(24),Cin => MATRIX9X48(8)(24),S => result_tmp(76),Cout => result_tmp(77));

FA34 : FA PORT MAP (A => MATRIX9X48(0)(25),B => MATRIX9X48(1)(25),Cin => MATRIX9X48(2)(25),S => result_tmp(78),Cout => result_tmp(79));
FA35 : FA PORT MAP (A => MATRIX9X48(3)(25),B => MATRIX9X48(4)(25),Cin => MATRIX9X48(5)(25),S => result_tmp(80),Cout => result_tmp(81));
FA36 : FA PORT MAP (A => MATRIX9X48(6)(25),B => MATRIX9X48(7)(25),Cin => MATRIX9X48(8)(25),S => result_tmp(82),Cout => result_tmp(83));

FA37 : FA PORT MAP (A => MATRIX9X48(0)(26),B => MATRIX9X48(1)(26),Cin => MATRIX9X48(2)(26),S => result_tmp(84),Cout => result_tmp(85));
FA38 : FA PORT MAP (A => MATRIX9X48(3)(26),B => MATRIX9X48(4)(26),Cin => MATRIX9X48(5)(26),S => result_tmp(86),Cout => result_tmp(87));
FA39 : FA PORT MAP (A => MATRIX9X48(6)(26),B => MATRIX9X48(7)(26),Cin => MATRIX9X48(8)(26),S => result_tmp(88),Cout => result_tmp(89));

FA40 : FA PORT MAP (A => MATRIX9X48(0)(27),B => MATRIX9X48(1)(27),Cin => MATRIX9X48(2)(27),S => result_tmp(90),Cout => result_tmp(91));
FA41 : FA PORT MAP (A => MATRIX9X48(3)(27),B => MATRIX9X48(4)(27),Cin => MATRIX9X48(5)(27),S => result_tmp(92),Cout => result_tmp(93));
FA42 : FA PORT MAP (A => MATRIX9X48(6)(27),B => MATRIX9X48(7)(27),Cin => MATRIX9X48(8)(27),S => result_tmp(94),Cout => result_tmp(95));

FA43 : FA PORT MAP (A => MATRIX9X48(0)(28),B => MATRIX9X48(1)(28),Cin => MATRIX9X48(2)(28),S => result_tmp(96),Cout => result_tmp(97));
FA44 : FA PORT MAP (A => MATRIX9X48(3)(28),B => MATRIX9X48(4)(28),Cin => MATRIX9X48(5)(28),S => result_tmp(98),Cout => result_tmp(99));
FA45 : FA PORT MAP (A => MATRIX9X48(6)(28),B => MATRIX9X48(7)(28),Cin => MATRIX9X48(8)(28),S => result_tmp(100),Cout => result_tmp(101));

FA46 : FA PORT MAP (A => MATRIX9X48(0)(29),B => MATRIX9X48(1)(29),Cin => MATRIX9X48(2)(29),S => result_tmp(102),Cout => result_tmp(103));
FA47 : FA PORT MAP (A => MATRIX9X48(3)(29),B => MATRIX9X48(4)(29),Cin => MATRIX9X48(5)(29),S => result_tmp(104),Cout => result_tmp(105));
FA48 : FA PORT MAP (A => MATRIX9X48(6)(29),B => MATRIX9X48(7)(29),Cin => MATRIX9X48(8)(29),S => result_tmp(106),Cout => result_tmp(107));

FA49 : FA PORT MAP (A => MATRIX9X48(0)(30),B => MATRIX9X48(1)(30),Cin => MATRIX9X48(2)(30),S => result_tmp(108),Cout => result_tmp(109));
FA50 : FA PORT MAP (A => MATRIX9X48(3)(30),B => MATRIX9X48(4)(30),Cin => MATRIX9X48(5)(30),S => result_tmp(110),Cout => result_tmp(111));
FA51 : FA PORT MAP (A => MATRIX9X48(6)(30),B => MATRIX9X48(7)(30),Cin => MATRIX9X48(8)(30),S => result_tmp(112),Cout => result_tmp(113));

FA52 : FA PORT MAP (A => MATRIX9X48(0)(31),B => MATRIX9X48(1)(31),Cin => MATRIX9X48(2)(31),S => result_tmp(114),Cout => result_tmp(115));
FA53 : FA PORT MAP (A => MATRIX9X48(3)(31),B => MATRIX9X48(4)(31),Cin => MATRIX9X48(5)(31),S => result_tmp(116),Cout => result_tmp(117));
FA54 : FA PORT MAP (A => MATRIX9X48(6)(31),B => MATRIX9X48(7)(31),Cin => MATRIX9X48(8)(31),S => result_tmp(118),Cout => result_tmp(119));

FA55 : FA PORT MAP (A => MATRIX9X48(0)(32),B => MATRIX9X48(1)(32),Cin => MATRIX9X48(2)(32),S => result_tmp(120),Cout => result_tmp(121));
FA56 : FA PORT MAP (A => MATRIX9X48(3)(32),B => MATRIX9X48(4)(32),Cin => MATRIX9X48(5)(32),S => result_tmp(122),Cout => result_tmp(123));
FA57 : FA PORT MAP (A => MATRIX9X48(6)(32),B => MATRIX9X48(7)(32),Cin => MATRIX9X48(8)(32),S => result_tmp(124),Cout => result_tmp(125));

FA58 : FA PORT MAP (A => MATRIX9X48(0)(33),B => MATRIX9X48(1)(33),Cin => MATRIX9X48(2)(33),S => result_tmp(126),Cout => result_tmp(127));
FA59 : FA PORT MAP (A => MATRIX9X48(3)(33),B => MATRIX9X48(4)(33),Cin => MATRIX9X48(5)(33),S => result_tmp(128),Cout => result_tmp(129));
FA60 : FA PORT MAP (A => MATRIX9X48(6)(33),B => MATRIX9X48(7)(33),Cin => MATRIX9X48(8)(33),S => result_tmp(130),Cout => result_tmp(131));

FA61 : FA PORT MAP (A => MATRIX9X48(0)(34),B => MATRIX9X48(1)(34),Cin => MATRIX9X48(2)(34),S => result_tmp(132),Cout => result_tmp(133));
FA62 : FA PORT MAP (A => MATRIX9X48(3)(34),B => MATRIX9X48(4)(34),Cin => MATRIX9X48(5)(34),S => result_tmp(134),Cout => result_tmp(135));
FA63 : FA PORT MAP (A => MATRIX9X48(6)(34),B => MATRIX9X48(7)(34),Cin => MATRIX9X48(8)(34),S => result_tmp(136),Cout => result_tmp(137));

FA64 : FA PORT MAP (A => MATRIX9X48(0)(35),B => MATRIX9X48(1)(35),Cin => MATRIX9X48(2)(35),S => result_tmp(138),Cout => result_tmp(139));
FA65 : FA PORT MAP (A => MATRIX9X48(3)(35),B => MATRIX9X48(4)(35),Cin => MATRIX9X48(5)(35),S => result_tmp(140),Cout => result_tmp(141));
FA66 : FA PORT MAP (A => MATRIX9X48(6)(35),B => MATRIX9X48(7)(35),Cin => MATRIX9X48(8)(35),S => result_tmp(142),Cout => result_tmp(143));

FA67 : FA PORT MAP (A => MATRIX9X48(0)(36),B => MATRIX9X48(1)(36),Cin => MATRIX9X48(2)(36),S => result_tmp(144),Cout => result_tmp(145));
FA68 : FA PORT MAP (A => MATRIX9X48(3)(36),B => MATRIX9X48(4)(36),Cin => MATRIX9X48(5)(36),S => result_tmp(146),Cout => result_tmp(147));
HA7  : HA PORT MAP (A => MATRIX9X48(6)(36),B => MATRIX9X48(7)(36),S => result_tmp(148),Cout => result_tmp(149));

FA69 : FA PORT MAP (A => MATRIX9X48(0)(37),B => MATRIX9X48(1)(37),Cin => MATRIX9X48(2)(37),S => result_tmp(150),Cout => result_tmp(151));
FA70 : FA PORT MAP (A => MATRIX9X48(3)(37),B => MATRIX9X48(4)(37),Cin => MATRIX9X48(5)(37),S => result_tmp(152),Cout => result_tmp(153));

FA71 : FA PORT MAP (A => MATRIX9X48(0)(38),B => MATRIX9X48(1)(38),Cin => MATRIX9X48(2)(38),S => result_tmp(154),Cout => result_tmp(155));
HA8 : HA PORT MAP (A => MATRIX9X48(3)(38),B => MATRIX9X48(4)(38),S => result_tmp(156),Cout => result_tmp(157));

FA72 : FA PORT MAP (A => MATRIX9X48(0)(39),B => MATRIX9X48(1)(39),Cin => MATRIX9X48(2)(39),S => result_tmp(158),Cout => result_tmp(159));

HA9 : HA PORT MAP (A => MATRIX9X48(0)(40),B => MATRIX9X48(1)(40),S => result_tmp(160),Cout => result_tmp(161));


---------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------Assignment output vectors--------------------------------------------------------------------------------------------------------

	
	V0(9 DOWNTO 0) <= IN0_from_Matrix_stage1(9 DOWNTO 0);
	V0(16 DOWNTO 10) <= IN0_from_Matrix_stage1(28 DOWNTO 22);
	
	
	V1(9 DOWNTO 0) <= IN1_from_Matrix_stage1(9 DOWNTO 0);
	V1(16 DOWNTO 10) <= IN1_from_Matrix_stage1(28 DOWNTO 22);


	V2(9 DOWNTO 0) <= IN2_from_Matrix_stage1(9 DOWNTO 0);
	V2(16 DOWNTO 10) <= IN2_from_Matrix_stage1(28 DOWNTO 22);
	
	
	V3(7 DOWNTO 0) <= IN3_from_Matrix_stage1(7 DOWNTO 0);
	V3(13 DOWNTO 8) <= IN3_from_Matrix_stage1(25 DOWNTO 20);
	
	
	V4(5 DOWNTO 0) <= IN4_from_Matrix_stage1(5 DOWNTO 0);
	V4(9 DOWNTO 6) <= IN4_from_Matrix_stage1(21 DOWNTO 18);

	
	V5(5 DOWNTO 0) <= IN5_from_Matrix_stage1(5 DOWNTO 0);
	V5(8 DOWNTO 6) <= IN5_from_Matrix_stage1(20 DOWNTO 18);
	
	
	V6(3 DOWNTO 0) <= IN6_from_Matrix_stage1(3 DOWNTO 0);
	V6(5 DOWNTO 4) <= IN6_from_Matrix_stage1(17 DOWNTO 16);
	
	
	V7(1 DOWNTO 0) <= IN7_from_Matrix_stage1(1 DOWNTO 0);
	
	
	V8(1 DOWNTO 0) <= IN8_from_Matrix_stage1(1 DOWNTO 0);



-------------------------------------------------------------------------------------------------------------------------
--output
Results_FA_HA_Stage3 <= result_tmp;



END ARCHITECTURE;