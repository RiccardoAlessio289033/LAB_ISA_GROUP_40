library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    clk   : in std_logic;
    out_Result   : in std_logic_vector(45 downto 0));
end data_sink;

architecture beh of data_sink is

begin  -- beh

  process (CLK)
    file res_mbe : text open WRITE_MODE is "./mbe_results.hex";
    variable line_out : line;
  begin  -- process
    if CLK'event and CLK = '1' then  -- rising clock edge
		if (out_Result(0) = 'U') then
		else
			--write(line_out, conv_integer(signed(out_Result)));
			--writeline(res_mbe, line_out);
		end if;
    end if;
  end process;

end beh;
