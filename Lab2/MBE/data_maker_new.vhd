library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is  
  port (
    clk     : in  std_logic;
    in_A    : out unsigned(31 downto 0);
	 in_B    : out unsigned(31 downto 0));
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns;


begin  -- beh


  process (clk)
    file fp_in : text open READ_MODE is "./mbe_samples.hex";
    variable line_in : line;
    variable x : std_logic_vector(31 DOWNTO 0);
	 variable cnt : integer := 0;
  begin  -- process
    if (clk'event and clk = '1') then  -- rising clock edge
		if not endfile(fp_in) then
			if (cnt = 0) then
				readline(fp_in, line_in);
				hread(line_in, x);
				in_A <= unsigned(x) after tco;
				in_B <= unsigned(x) after tco;
				cnt := cnt + 1;
			elsif (cnt = 12) then
				cnt := 0;
			else
				cnt := cnt + 1;
			end if;
      end if;
    end if;
  end process; 

end beh;
