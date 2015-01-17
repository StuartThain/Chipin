module multiplexerOutput(select, normalOutput, maintenanceOutput, muxOut);

input [0:0] select;		//select line
input [2:0] normalOutput, maintenanceOutput;	//the two options for the mux to choose from

output [2:0] muxOut;	//output

reg [2:0] muxOut;	//reg

parameter normal = 1'b0, maintenance = 1'b1; //states

always@(select or normalOutput or maintenanceOutput)
	begin
		case(select)
			normal:
				begin
				muxOut <= normalOutput;	//set the output to normal mode output
				end
			maintenance:
				begin
				muxOut <= maintenanceOutput;	//set the output to maintenance mode output
				end
		endcase
	end
endmodule