module AGDC_TB;

reg     Activate_tb ; 
reg     UP_Max_tb ; 
reg     DN_Max_tb ;
reg     rst_tb ;
reg     clk_tb ;
wire    UP_M_tb ;
wire    DN_M_tb ;

////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial 
 begin
   
 // Save Waveform
   $dumpfile("AGDC.vcd") ;       
   $dumpvars; 
 
 // initialization
   initialize();

 // Reset
   reset();
   
//test case 1
  up_motor();
//test case 2
  down_motor();
//test case 3
 IDLE_case();

  $finish ;
 
 end  
 
 ////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize;
 begin
    Activate_tb = 1'b0;
    UP_Max_tb = 1'b0;
    DN_Max_tb = 1'b0;
    clk_tb = 1'b0;
 end
endtask

///////////////////////// RESET /////////////////////////
  
task reset;
 begin
 rst_tb =  'b1;
 #1
 rst_tb  = 'b0;
 #1
 rst_tb  = 'b1;
 end
endtask 
 
///////////////////////// Down_motor case /////////////////////////
task down_motor;
  begin
    Activate_tb = 1'b1;
    UP_Max_tb = 1'b1;
    DN_Max_tb = 1'b0;
    #10
    Activate_tb = 1'b0;
    #40
    if(UP_M_tb == 0 && DN_M_tb == 1)
    begin
    $display("Down Motor is ON");
    DN_Max_tb = 1'b1;
    #50
    if(UP_M_tb == 0 && DN_M_tb == 0)
    $display("IDLE mode");
    $display("test is passed");
    end
    else
    $display("Down Motor is OFF , test is failed");
 end
endtask

///////////////////////// Up_motor case /////////////////////////
task up_motor;
    begin
    Activate_tb = 1'b1;
    UP_Max_tb = 1'b0;
    DN_Max_tb = 1'b1;
    #10
    Activate_tb = 1'b0;
    #40
    if(UP_M_tb == 1 && DN_M_tb == 0)
    begin
    $display("Up Motor is ON");
    UP_Max_tb = 1'b1;
    #50
    if(UP_M_tb == 0 && DN_M_tb == 0)
    $display("IDLE mode");
    $display("test is passed");
    end
    else
    $display("Up Motor is OFF , test is failed");
    end
endtask

///////////////////////// IdLE case /////////////////////////
task IDLE_case;
 begin
    Activate_tb = 1'b0;
    UP_Max_tb = 1'b1;
    DN_Max_tb = 1'b1;
    if(UP_M_tb == 0 && DN_M_tb == 0)
    $display("test is passed");
    else
    $display("test is failed");
end
endtask

////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

initial
 begin
    forever #10 clk_tb = ~clk_tb ;
 end

////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////
AGDC DUT(
.Activate(Activate_tb), 
.UP_Max(UP_Max_tb),
.DN_Max(DN_Max_tb),
.rst(rst_tb),
.clk(clk_tb),
.UP_M(UP_M_tb),
.DN_M(DN_M_tb)
);

endmodule


