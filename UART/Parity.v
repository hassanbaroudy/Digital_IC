module Parity #(parameter P_Data_Width = 8) (
input    [P_Data_Width-1:0] P_Data,
input                   Parity_TYP,
output        reg       Parity_out
);

wire                    Even_parity;
wire                     Odd_parity;
wire                       Even,Odd;
 
assign Even = 1'b0;
assign Odd = 1'b1;
assign Even_parity = (^P_Data);
assign Odd_parity  = ~(^P_Data); 

always @(*)
  begin
    if(Parity_TYP == Even)
	  begin
	    Parity_out = Even_parity;
	  end
	else 
	  begin
	    Parity_out = Odd_parity;
	  end
  end

endmodule