module multiplexerThree(select, controllerInput, maintenanceInput, controllerStart, maintenanceStart, startOut, muxOut);

input [0:0] select;
input [0:0] controllerStart, maintenanceStart;
input [1:0] controllerInput, maintenanceInput;

output [0:0] startOut;
output [1:0] muxOut;

reg [0:0] startOut;
reg [1:0] muxOut;

parameter controller = 1'b0, maintenance = 1'b1; 

always@(select or controllerStart or controllerInput or maintenanceStart or maintenanceInput)
	begin
		case(select)
			controller:
				begin
				startOut <= controllerStart;
				muxOut <= controllerInput;
				end
			maintenance:
				begin
				startOut <= maintenanceStart;
				muxOut <= maintenanceInput;
				end
		endcase
	end
endmodule