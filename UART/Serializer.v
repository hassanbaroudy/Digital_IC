module Serializer #(parameter P_Data_Width = 8) (
input [P_Data_Width-1:0] P_Data,
input                  activate,
input                     Reset,
input                       Clk,
output   reg             finish,
output  reg        Serial_frame
);

reg [P_Data_Width-1:0] P_Data_reg ;
reg [3:0] counter ;

always @(posedge Clk or negedge Reset)
  begin 
    if(!Reset)
      begin
	    P_Data_reg <= 8'b0;
	    counter <= 4'b0000;
            finish <= 1'b0;
      end
    else if((activate) && (counter == 4'b0000))
      begin
        P_Data_reg <= P_Data ;
        Serial_frame <= P_Data_reg[0];
	counter <= counter + 4'b0001;
        finish <= 1'b0;
      end	
    else if((counter != 4'b0000) && (counter != 4'b1000))	  
	  begin
	     Serial_frame <= P_Data_reg[0];
             P_Data_reg <= P_Data_reg >> 1;
	     counter <= counter + 4'b0001;
             finish <= 1'b0;
	  end
     else 
	  begin
	    finish <= 1'b1;
	    counter <= 4'b0000;
	  end  
  end

endmodule