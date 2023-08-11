module Clk_divider_tb #(paramter Div_ratio_width = 4) ();

 reg                        ref_clk_tb;
 reg                        reset_tb;
 reg                        enable_tb;
 reg  [Div_ratio_width-1:0] division_ratio_tb;
 wire                       divided_clk_tb;

 initial
   begin
     forever #10 ref_clk_tb = ~ref_clk_tb;
   end
   
initial
  begin
     $dumpfile("Clk_divider.vcd");
	 $dumpvars;
	 Initialize();
	 Reset();
	 enable_tb = 1'b0;
	 division_ratio_tb = 'b0100;
	 #180
	 
	 
  end



task Initialize;
  begin
    reset_tb = 1'b1;
	enable_tb = 1'b1;
	ref_clk_tb = 1'b1;
	division_ratio_tb = 'b1;
  end
  
task Reset;
  begin
    reset_tb =1'b1;
	#15
	reset_tb = 1'b0;
	#15
	reset_tb = 1'b1;
  end


Clk_divider_DUT
(.ref_clk(ref_clk_tb),
 .reset(reset_tb),
 .enable(enable_tb),
 .division_ratio(division_ratio_tb),
 .divided_clk(divided_clk_tb)
);
endmodule