module multiplexerSeven(select, mbedInput, controllerOutput, maintenanceOutput);

input [0:0] select;	//select line
input [6:0] mbedInput;	//input

output [6:0] controllerOutput, maintenanceOutput;	//two options for the output signal

reg [6:0] controllerOutput, maintenanceOutput;	//reg

initial controllerOutput <= 7'b1101110;
initial maintenanceOutput <= 7'b0111111;

parameter controller = 1'b0, maintenance = 1'b1; //states

always@(select or mbedInput)
	begin
		case(select)
			controller:
				begin
				controllerOutput <= mbedInput;	//set output to controller(normal mode)
				maintenanceOutput <= 7'b0111111;	//set maintenance to do nothing state
				end
			maintenance:
				begin
				maintenanceOutput <= mbedInput;	//set output to maintenance mode
				controllerOutput <= 7'b1101110;	//set controller to do nothing state
				end
		endcase
	end
endmodule