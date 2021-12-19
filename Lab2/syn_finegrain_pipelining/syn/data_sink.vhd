library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    CLK   : in std_logic; --rimane uguale
    FP_Z   : in std_logic_vector(31 downto 0));
end data_sink;

architecture beh of data_sink is

begin  -- beh

  process (CLK) --il rst devo toglierlo
--..\modelsim_lab2\pipelinato\fp_prod.hex
    file res_fp : text open WRITE_MODE is "C:\Users\Riccardo Alessio\Desktop\PoliTo\IV anno\Integrated systems architecture\Lab2_modified\fp_products.hex";
    variable line_out : line;   
 
  begin  -- process
    if CLK'event and CLK = '1' then

      --devo scrivere il risultato nel file in esadecimale
        hwrite(line_out, FP_Z); 
        writeline(res_fp, line_out); --scrivo in resultsmodelsim.hex line_out che deve essere un numero esadecimale
      
    end if;
  end process;

end beh;
