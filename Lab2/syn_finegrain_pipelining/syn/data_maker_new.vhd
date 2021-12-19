library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;


library std;
use std.textio.all;
use ieee.numeric_std.all;

entity data_maker is  
  port (

    CLK     : in  std_logic;
	 FP_A: OUT    std_logic_vector (31 DOWNTO 0);
    FP_B : OUT    std_logic_vector (31 DOWNTO 0);
	 RST_n : IN STD_LOGIC;
    END_SIM : out std_logic);

end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns;

  signal sEndSim : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 10);
  
begin 

  process (CLK, RST_n)

    file fp_in : text open READ_MODE is "C:\Users\Riccardo Alessio\Desktop\PoliTo\IV anno\Integrated systems architecture\Lab2_modified\fp_samples.hex";
    variable line_in : line;
    variable hex : std_logic_vector(31 downto 0);  


  begin  -- process
   if RST_n = '0' then
		FP_A <= (OTHERS => '0') AFTER tco;
		FP_B <= (OTHERS => '0') AFTER tco;
		sEndSim <= '0' after tco;
		
   elsif CLK'event and CLK = '1' then  -- rising clock 
      if not endfile(fp_in) then
			-- primo operando
			readline(fp_in, line_in);
			hread(line_in, hex);  --legge la linea in un esadecimale a e si converte in un std_logic_vector da 32 bit
			FP_A <= hex after tco;
			
			-- secondo operando
			readline(fp_in, line_in);
			hread(line_in, hex);  --legge la linea in un esadecimale a e si converte in un std_logic_vector da 32 bit
			FP_B <= hex after tco;
			
			sEndSim <= '0' after tco;
      else
        sEndSim <= '1' after tco;
      end if;
    end if;
	 
  end process;

  process (CLK, RST_n) --, RST_n)

  begin  -- process
		if RST_n = '0' then
			END_SIM_i <= (others => '0') after tco;
		elsif CLK'event and CLK = '1' then  -- rising clock edge
				END_SIM_i(0) <= sEndSim after tco;
				END_SIM_i(1 to 10) <= END_SIM_i(0 to 9) after tco; --non so a cosa serve
		end if;
		
  end process;

  END_SIM <= END_SIM_i(10);  

end beh;
