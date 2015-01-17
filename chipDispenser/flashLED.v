module flashLED(clk, redLED1, greenLED1, blueLED1, redLED2, greenLED2, blueLED2);

//inputs
input clk;

//outputs
output redLED1, greenLED1, blueLED1, redLED2, greenLED2, blueLED2;

//registers
reg redLED1, greenLED1, blueLED1, redLED2, greenLED2, blueLED2;
reg [26:0] pause;
reg [2:0] state;

//initialisations
initial pause = 27'b0;
initial state = 1'd0;

//parameters
parameter red = 2'd0, green = 2'd1, blue = 2'd2;
/*
This module controls two LEDs at once so that the block diagram was not overloaded with block and
it give the option of having two LEDs doing one thing while another tow do something else.
The module runs througnt the rgb colours in a loop.
*/
always@(posedge clk)
	begin
	case(state)
		red:
			begin
			redLED1 <= 1'b1;	
			redLED2 <= 1'b1;
			if(pause >= 37500000)		//wait for 0.75 seconds
				begin
				pause <= 27'd0;
				redLED1 <= 1'b0;
				redLED2 <= 1'b0;
				state <= green;
				end
			else
				begin
				pause <= pause + 1'b1;
				state <= red;
				end
			end
		green:
			begin
			greenLED1 <= 1'b1;
			greenLED2 <= 1'b1;
			if(pause >= 37500000)	//wait for 0.75 seconds
				begin
				pause <= 27'd0;
				greenLED1 <= 1'b0;
				greenLED2 <= 1'b0;
				state <= blue;
				end
			else
				begin
				pause <= pause + 1'b1;
				state <= green;
				end
			end
		blue:
			begin
			blueLED1 <= 1'b1;
			blueLED2 <= 1'b1;
			if(pause >= 37500000)	//wait for 0.75 seconds
				begin
				pause <= 27'd0;
				blueLED1 <= 1'b0;
				blueLED2 <= 1'b0;
				state <= red;
				end
			else
				begin
				pause <= pause + 1'b1;
				state <= blue;
				end
			end
		endcase
	end
endmodule