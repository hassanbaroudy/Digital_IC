module AGDC(
input  wire        Activate , UP_Max , DN_Max ,
input  wire        rst,
input  wire        clk,
output reg         UP_M,
output reg         DN_M
);

localparam  [1:0]    IDLE = 2'b00,
                     Mv_Up = 2'b01,
		             Mv_Dn = 2'b10;
					 
reg    [1:0]         current_state,
                     next_state ;
					 
// state transition 		
always @(posedge clk or negedge rst)
 begin
  if(!rst)
   begin
     current_state <= IDLE ;
   end
  else
   begin
     current_state <= next_state ;
   end
 end
 
 // next_state logic
 always @(*)
  begin
    case(current_state)
	IDLE   :begin
	        if(!Activate)
                    next_state = IDLE ;
		else if(Activate && DN_Max == 1 && UP_Max == 0)
                    next_state = Mv_Up ;
                else if(Activate && DN_Max == 0 && UP_Max == 1)				
                    next_state = Mv_Dn ;
		 else
	            next_state = IDLE ;
                end
	Mv_Up  :begin
	        if(UP_Max)
                    next_state = IDLE;	
		else
		    next_state = Mv_Up;
		end
        Mv_Dn  :begin
	        if(DN_Max)
                    next_state = IDLE;	
		else
		    next_state = Mv_Dn;
		end	
	default :  next_state = IDLE ;		 
  endcase
end	

 // next_state logic
always @(*)
  begin
    case(current_state)
	IDLE   :begin
	        UP_M =0;
		DN_M =0;
	        end
	Mv_Up  :begin
	        UP_M =1;
		DN_M =0;
	        end
	Mv_Dn  :begin
	        UP_M =0;
		DN_M =1;
	       end
	default  :begin
	           UP_M =0;
	           DN_M =0;
	          end
    endcase
  end
endmodule
