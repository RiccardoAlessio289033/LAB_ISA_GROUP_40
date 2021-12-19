LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


ENTITY  RCA  IS
    PORT(
   Results_from_Matrix_stage5    : IN STD_LOGIC_VECTOR(91 DOWNTO 0);  

	IN0_from_Matrix_stage5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	IN1_from_Matrix_stage5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 		
	IN2_from_Matrix_stage5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

   final_Result    : OUT STD_LOGIC_VECTOR(45 DOWNTO 0) 
	
    );
END RCA;


ARCHITECTURE  mat1 OF RCA IS

SIGNAL sum_from_stage5: STD_LOGIC_VECTOR (45 DOWNTO 0) := (OTHERS => '0'); 
SIGNAL cout_from_stage5: STD_LOGIC_VECTOR (45 DOWNTO 0) := (OTHERS => '0'); 
SIGNAL sum_tmp, result_tmp : STD_LOGIC_VECTOR(47 DOWNTO 0);

SIGNAL vet1, vet2 : STD_LOGIC_VECTOR (1 DOWNTO 0);

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
vet1 <= IN0_from_Matrix_stage5;
vet2 <= IN1_from_Matrix_stage5;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------Assign FAs and HAs results of the previous stage to RCA--------------------------------------------
PROCESS (Results_from_Matrix_stage5)

variable z1,z2 : INTEGER;

	BEGIN
	
	z1 := 0;
	for w in 0 to 45 loop
		sum_from_stage5(w) <= Results_from_Matrix_stage5(z1);
		z1 := z1 + 2;
	end loop;
	
	z2 := 1;
	for w in 0 to 45 loop
		cout_from_stage5(w) <= Results_from_Matrix_stage5(z2);
		z2 := z2 + 2;
	end loop;
	
	
	

END PROCESS;


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------Instance FAs HAs--------------------------------------------------------------------------
HA0 : HA PORT MAP (A => vet1(0),B => vet2(0),S => sum_tmp(0),Cout => result_tmp(0));

FA0 : FA PORT MAP (A => vet1(1),B => '0',Cin => result_tmp(0),S => sum_tmp(1),Cout => result_tmp(1));

FA1 : FA PORT MAP (A => sum_from_stage5(0),B => IN2_from_Matrix_stage5(0),Cin => result_tmp(1),S => sum_tmp(2),Cout => result_tmp(2));

FA2 : FA PORT MAP (A => sum_from_stage5(1),B => cout_from_stage5(0),Cin => result_tmp(2),S => sum_tmp(3),Cout => result_tmp(3));

FA3 : FA PORT MAP (A => sum_from_stage5(2),B => cout_from_stage5(1),Cin => result_tmp(3),S => sum_tmp(4),Cout => result_tmp(4));

FA4 : FA PORT MAP (A => sum_from_stage5(3),B => cout_from_stage5(2),Cin => result_tmp(4),S => sum_tmp(5),Cout => result_tmp(5));

FA5 : FA PORT MAP (A => sum_from_stage5(4),B => cout_from_stage5(3),Cin => result_tmp(5),S => sum_tmp(6),Cout => result_tmp(6));

FA6 : FA PORT MAP (A => sum_from_stage5(5),B => cout_from_stage5(4),Cin => result_tmp(6),S => sum_tmp(7),Cout => result_tmp(7));

FA7 : FA PORT MAP (A => sum_from_stage5(6),B => cout_from_stage5(5),Cin => result_tmp(7),S => sum_tmp(8),Cout => result_tmp(8));

FA8 : FA PORT MAP (A => sum_from_stage5(7),B => cout_from_stage5(6),Cin => result_tmp(8),S => sum_tmp(9),Cout => result_tmp(9));

FA9 : FA PORT MAP (A => sum_from_stage5(8),B => cout_from_stage5(7),Cin => result_tmp(9),S => sum_tmp(10),Cout => result_tmp(10));

FA10 : FA PORT MAP (A => sum_from_stage5(9),B => cout_from_stage5(8),Cin => result_tmp(10),S => sum_tmp(11),Cout => result_tmp(11));

FA11 : FA PORT MAP (A => sum_from_stage5(10),B => cout_from_stage5(9),Cin => result_tmp(11),S => sum_tmp(12),Cout => result_tmp(12));

FA12 : FA PORT MAP (A => sum_from_stage5(11),B => cout_from_stage5(10),Cin => result_tmp(12),S => sum_tmp(13),Cout => result_tmp(13));

FA13 : FA PORT MAP (A => sum_from_stage5(12),B => cout_from_stage5(11),Cin => result_tmp(13),S => sum_tmp(14),Cout => result_tmp(14));

FA14 : FA PORT MAP (A => sum_from_stage5(13),B => cout_from_stage5(12),Cin => result_tmp(14),S => sum_tmp(15),Cout => result_tmp(15));

FA15 : FA PORT MAP (A => sum_from_stage5(14),B => cout_from_stage5(13),Cin => result_tmp(15),S => sum_tmp(16),Cout => result_tmp(16));

FA16 : FA PORT MAP (A => sum_from_stage5(15),B => cout_from_stage5(14),Cin => result_tmp(16),S => sum_tmp(17),Cout => result_tmp(17));

FA17 : FA PORT MAP (A => sum_from_stage5(16),B => cout_from_stage5(15),Cin => result_tmp(17),S => sum_tmp(18),Cout => result_tmp(18));

FA18 : FA PORT MAP (A => sum_from_stage5(17),B => cout_from_stage5(16),Cin => result_tmp(18),S => sum_tmp(19),Cout => result_tmp(19));

FA19 : FA PORT MAP (A => sum_from_stage5(18),B => cout_from_stage5(17),Cin => result_tmp(19),S => sum_tmp(20),Cout => result_tmp(20));

FA20 : FA PORT MAP (A => sum_from_stage5(19),B => cout_from_stage5(18),Cin => result_tmp(20),S => sum_tmp(21),Cout => result_tmp(21));

FA21 : FA PORT MAP (A => sum_from_stage5(20),B => cout_from_stage5(19),Cin => result_tmp(21),S => sum_tmp(22),Cout => result_tmp(22));

FA22 : FA PORT MAP (A => sum_from_stage5(21),B => cout_from_stage5(20),Cin => result_tmp(22),S => sum_tmp(23),Cout => result_tmp(23));

FA23 : FA PORT MAP (A => sum_from_stage5(22),B => cout_from_stage5(21),Cin => result_tmp(23),S => sum_tmp(24),Cout => result_tmp(24));

FA24 : FA PORT MAP (A => sum_from_stage5(23),B => cout_from_stage5(22),Cin => result_tmp(24),S => sum_tmp(25),Cout => result_tmp(25));

FA25 : FA PORT MAP (A => sum_from_stage5(24),B => cout_from_stage5(23),Cin => result_tmp(25),S => sum_tmp(26),Cout => result_tmp(26));

FA26 : FA PORT MAP (A => sum_from_stage5(25),B => cout_from_stage5(24),Cin => result_tmp(26),S => sum_tmp(27),Cout => result_tmp(27));

FA27 : FA PORT MAP (A => sum_from_stage5(26),B => cout_from_stage5(25),Cin => result_tmp(27),S => sum_tmp(28),Cout => result_tmp(28));

FA28 : FA PORT MAP (A => sum_from_stage5(27),B => cout_from_stage5(26),Cin => result_tmp(28),S => sum_tmp(29),Cout => result_tmp(29));

FA29 : FA PORT MAP (A => sum_from_stage5(28),B => cout_from_stage5(27),Cin => result_tmp(29),S => sum_tmp(30),Cout => result_tmp(30));

FA30 : FA PORT MAP (A => sum_from_stage5(29),B => cout_from_stage5(28),Cin => result_tmp(30),S => sum_tmp(31),Cout => result_tmp(31));

FA31 : FA PORT MAP (A => sum_from_stage5(30),B => cout_from_stage5(29),Cin => result_tmp(31),S => sum_tmp(32),Cout => result_tmp(32));

FA32 : FA PORT MAP (A => sum_from_stage5(31),B => cout_from_stage5(30),Cin => result_tmp(32),S => sum_tmp(33),Cout => result_tmp(33));

FA33 : FA PORT MAP (A => sum_from_stage5(32),B => cout_from_stage5(31),Cin => result_tmp(33),S => sum_tmp(34),Cout => result_tmp(34));

FA34 : FA PORT MAP (A => sum_from_stage5(33),B => cout_from_stage5(32),Cin => result_tmp(34),S => sum_tmp(35),Cout => result_tmp(35));

FA35 : FA PORT MAP (A => sum_from_stage5(34),B => cout_from_stage5(33),Cin => result_tmp(35),S => sum_tmp(36),Cout => result_tmp(36));

FA36 : FA PORT MAP (A => sum_from_stage5(35),B => cout_from_stage5(34),Cin => result_tmp(36),S => sum_tmp(37),Cout => result_tmp(37));

FA37 : FA PORT MAP (A => sum_from_stage5(36),B => cout_from_stage5(35),Cin => result_tmp(37),S => sum_tmp(38),Cout => result_tmp(38));

FA38 : FA PORT MAP (A => sum_from_stage5(37),B => cout_from_stage5(36),Cin => result_tmp(38),S => sum_tmp(39),Cout => result_tmp(39));

FA39 : FA PORT MAP (A => sum_from_stage5(38),B => cout_from_stage5(37),Cin => result_tmp(39),S => sum_tmp(40),Cout => result_tmp(40));

FA40 : FA PORT MAP (A => sum_from_stage5(39),B => cout_from_stage5(38),Cin => result_tmp(40),S => sum_tmp(41),Cout => result_tmp(41));

FA41 : FA PORT MAP (A => sum_from_stage5(40),B => cout_from_stage5(39),Cin => result_tmp(41),S => sum_tmp(42),Cout => result_tmp(42));

FA42 : FA PORT MAP (A => sum_from_stage5(41),B => cout_from_stage5(40),Cin => result_tmp(42),S => sum_tmp(43),Cout => result_tmp(43));

FA43 : FA PORT MAP (A => sum_from_stage5(42),B => cout_from_stage5(41),Cin => result_tmp(43),S => sum_tmp(44),Cout => result_tmp(44));

FA44 : FA PORT MAP (A => sum_from_stage5(43),B => cout_from_stage5(42),Cin => result_tmp(44),S => sum_tmp(45),Cout => result_tmp(45));

FA45 : FA PORT MAP (A => sum_from_stage5(44),B => cout_from_stage5(43),Cin => result_tmp(45),S => sum_tmp(46),Cout => result_tmp(46));

FA46 : FA PORT MAP (A => sum_from_stage5(45),B => cout_from_stage5(44),Cin => result_tmp(46),S => sum_tmp(47),Cout => result_tmp(47));


---------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------Assignment output vector--------------------------------------------------------------------------------------------------------

	final_Result(45 DOWNTO 0) <= sum_tmp(45 DOWNTO 0); 




END ARCHITECTURE;