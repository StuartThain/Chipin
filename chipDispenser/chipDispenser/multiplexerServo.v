module multiplexerServo(select, normalSort, servoTest, muxOut);

input [0:0] select;		//select line
input [9:0] normalSort, servoTest;	//the two options for the mux to choose from

output [9:0] muxOut;	//output

reg [9:0] muxOut;	//reg

parameter normal = 1'b0, test = 1'b1; //states

always@(select or normalSort or servoTest)
	begin
		case(select)
			normal:
				begin
				muxOut <= normalSort;	//set the output to normal mode sort
				end
			test:
				begin
				muxOut <= servoTest;	//set the output to maintenance mode which testes the servo
				end
		endcase
	end
endmodule