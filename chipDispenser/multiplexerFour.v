module multiplexerFour(select, muxOut, startOut, controllerInput, maintenanceInput, controllerStart, maintenanceStart);

input [0:0] select;	//select line
input controllerStart, maintenanceStart;	//two options for the start line
input [2:0] controllerInput, maintenanceInput;	//two options for the input for colour

output startOut;	//start output
output [2:0] muxOut;	//colour output

//reg
reg startOut;
reg [2:0] muxOut;

//state
parameter controller = 1'b0, maintenance = 1'b1; 

always@(select or controllerInput or maintenanceStart or controllerStart or maintenanceInput)
	begin
		case(select)
			controller:
				begin
				startOut <= controllerStart;	//set output to normal mode start
				muxOut <= controllerInput;	//set output to normal mode input
				end
			maintenance:
				begin
				startOut <= maintenanceStart;	//set output to normal mode start
				muxOut <= maintenanceInput;	//set output to maintenance mode input
				end
		endcase
	end
endmodule