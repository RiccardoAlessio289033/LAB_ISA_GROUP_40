//`timescale 1ns

module tb_MBE (); 

   wire CLK_i;
   wire [31:0] MBE_A_i;
   wire [31:0] MBE_B_i;
   wire [45:0] MBE_Result_i;

   clk_gen CG(.CLK(CLK_i)); 

   data_maker SM(.clk(CLK_i),
						.in_A(MBE_A_i),
						.in_B(MBE_B_i));

   MBE UUT(.Clk(CLK_i),
				.A_IN(MBE_A_i),
				.B_IN(MBE_B_i),
            .Result(MBE_Result_i)); 

   data_sink DS(.clk(CLK_i),
					.out_Result(MBE_Result_i));   

endmodule

		   