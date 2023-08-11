module Top_UART_tb #(parameter P_Data_Width = 8);
reg [P_Data_Width-1:0]   P_Data;
reg                     D_Valid;
reg                         Clk;
reg                       Reset;
reg                   Parity_EN;
reg                  Parity_TYP;
wire                       busy;
wire                Serial_Data; 

initial
  begin
    forever #2.5 Clk = ~Clk ;
  end
  
initial
  begin
    $dumpfile("Top_UART.vcd");
    $dumpvars;
        Initialization();
        reset();
	P_Data = 8'b11111111 ;
        Data_Valid();
	Parity_EN = 1'b0;
	Parity_TYP = 1'b0;
	#100
	
	
	
	$finish ;
  end
  
task reset;
  begin
    Reset = 1'b1;
    #5
    Reset = 1'b0;
    #5
    Reset = 1'b1;
  end
endtask
  
task Initialization;
  begin
    Reset      = 1'b1;
    D_Valid    = 1'b0;
    Clk        = 1'b0;
    Parity_EN =  1'b0;
    Parity_TYP = 1'b0;
  end
endtask
  
task Data_Valid;
  begin
    D_Valid = 1'b0;
    #5
    D_Valid = 1'b1;
    #20
    D_Valid = 1'b0;
  end
endtask

Top_UART DUT(
.P_Data(P_Data),
.D_Valid(D_Valid),
.Clk(Clk),
.Reset(Reset),
.Parity_EN(Parity_EN),
.Parity_TYP(Parity_TYP),
.busy(busy),
.Serial_Data(Serial_Data)
);

endmodule