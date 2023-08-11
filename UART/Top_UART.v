module Top_UART #(parameter P_Data_Width = 8) (
input [P_Data_Width-1:0] P_Data,
input                   D_Valid,
input                       Clk,
input                     Reset,
input                 Parity_EN,
input                Parity_TYP,
output                     busy,
output              Serial_Data 
);

wire  Serial_frame;
wire  finish;
wire  activate;
wire  Parity_out;

Serializer #(.P_Data_Width(8)) UART_Serializer(
.P_Data(P_Data),
.activate(activate),
.Reset(Reset),
.Clk(Clk),
.finish(finish),
.Serial_frame(Serial_frame)
);

Parity #(.P_Data_Width(8)) UART_Parity(
.P_Data(P_Data),
.Parity_TYP(Parity_TYP),
.Parity_out(Parity_out)
);

FSM UART_FSM (
.D_Valid(D_Valid),
.Clk(Clk),
.Reset(Reset),
.Serial_frame(Serial_frame),
.Parity_EN(Parity_EN),
.Parity_out(Parity_out),
.finish(finish),
.busy(busy),
.activate(activate),
.Serial_Data(Serial_Data)
);
endmodule