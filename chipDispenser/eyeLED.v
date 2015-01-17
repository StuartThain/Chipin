module eyeLED(clk, redLED);

//input
input clk;

//output
output redLED;

//registers
reg redLED, greenLED, blueLED;
reg [2:0] state;
reg [27:0] pause;
reg [7:0] colourSelect;
reg [16:0] counter;

//parameters
parameter clkDelay = 195;
parameter delay = 3'd0, flicker = 3'd1, flickerTwo = 3'd2, flickerThree = 3'd3, flickerFour = 3'd4;

//initialisations
initial state = 3'd0;
initial pause = 28'd0;

always@(posedge clk)
	begin
	case(state)
		delay:		//wait for 2.9 seconds before performing a flicker
			begin
			if(pause >= 145000000)
				begin
				colourSelect <= 8'd177;	//dim LED
				pause <= 28'd0;	//reset pause
				counter <= 17'd0;	//reset counter
				state <= flicker;	//goto next state
				end
			else
				begin
				colourSelect <= 8'd255;		//set LED to fully on
				counter <= counter + 1'b1;
				if(counter <= colourSelect * clkDelay)	//if counter is morethan or equal to the 
														//colourSelect multipied by clkDelay
					begin
					redLED <= 1'b1;		//set the redLED to on
					pause <= pause + 1'b1;
					state <= delay;	//keep the state the same
					end
				else
					begin
					redLED <= 1'b0;	//set the LED to off
					pause <= pause + 1'b1;
					state <= delay;	//keep the state the same
					end
				end
			end
		flicker:
			begin
			if(pause >= 110000000)	//wait for 2.2 seconds
				begin
				colourSelect <= 8'd50;		//dim the LED to nearly off
				pause <= 28'd0;		//reset pause
				counter <= 17'd0;	//reset counter
				state <= flickerTwo;	//goto next state
				end
			else
				begin
				counter <= counter + 1'b1;
				if(counter <= colourSelect * clkDelay)	//if counter is morethan or equal to the 
														//colourSelect multipied by clkDelay
					begin
					redLED <= 1'b1;		//set the redLED to on
					pause <= pause + 1'b1;
					state <= flicker;	//keep the state the same
					end
				else
					begin
					redLED <= 1'b0;		//set the redLED to on
					pause <= pause + 1'b1;
					state <= flicker;	//keep the state the same
					end
				end
			end
		flickerTwo:
			begin
			if(pause >= 50000000)	//wait for 1 second
				begin
				colourSelect <= 8'd255;
				pause <= 28'd0;
				counter <= 17'd0;
				state <= flickerThree;	//goto next state
				end
			else
				begin
				counter <= counter + 1'b1;
				if(counter <= colourSelect * clkDelay)	//if counter is morethan or equal to the 
														//colourSelect multipied by clkDelay
					begin
					redLED <= 1'b1;		//set the redLED to on
					pause <= pause + 1'b1;
					state <= flickerTwo;	//keep the state the same
					end
				else
					begin
					redLED <= 1'b0;		//set the redLED to on
					pause <= pause + 1'b1;
					state <= flickerTwo;	//keep the state the same
					end
				end
			end
		flickerThree:
			begin
			if(pause >= 5000000)	//wait for 0.1 seconds
				begin
				colourSelect <= 8'd0;
				pause <= 28'd0;
				counter <= 17'd0;
				state <= flickerFour;	//goto next state
				end
			else
				begin
				counter <= counter + 1'b1;
				if(counter <= colourSelect * clkDelay)	//if counter is morethan or equal to the
														// colourSelect multipied by clkDelay
					begin
					redLED <= 1'b1;	//set the redLED to on
					pause <= pause + 1'b1;
					state <= flickerThree;	//keep the state the same
					end
				else
					begin
					redLED <= 1'b0;	//set the redLED to on
					pause <= pause + 1'b1;
					state <= flickerThree;	//keep the state the same
					end
				end
			end
		flickerFour:
			begin
			if(pause >= 5000000)	//wait for 0.1 seconds
				begin
				pause <= 28'd0;
				state <= delay;		//goto first state
				end
			else
				begin
				pause <= pause + 1'b1;
				state <= flickerFour;	//keep the state the same
				end
			end
		endcase
	end
endmodule