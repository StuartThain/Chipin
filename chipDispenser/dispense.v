module dispense(clk, start, dispense, dispenseServoRed, dispenseServoGreenBlue, complete, redLED, greenLED, blueLED);

//inputs
input clk, start; // receive signal from controller to start and the clock
input [1:0] dispense;	//signal for which colour to dispense


//outputs
output [9:0] dispenseServoRed, dispenseServoGreenBlue;	//servos that do the dispensing
output complete;
output [0:0] redLED, greenLED, blueLED;
//output [3:0] state;


//regs
reg [3:0] state; //states
reg [9:0] dispenseServoRed, dispenseServoGreenBlue; //reg of servos
reg [24:0] pause; //wait control
reg [1:0] dispense_reg, dispenseCheck; //reg of input and check on if the input has changed
reg complete;
reg [0:0] redLED, greenLED, blueLED;

//initials
initial state = 4'd0;
initial pause = 25'd0;
initial dispenseServoRed <= 10'd440;
initial dispenseServoGreenBlue <= 10'd375;

//parameters
parameter control = 4'd0, red = 4'd1, redSecond = 4'd2, redThird = 4'd3, green = 4'd4, greenSecond = 4'd5, greenThird = 4'd6, blue = 4'd7, blueSecond = 4'd8, blueThird = 4'd9;

always@(posedge clk)
	begin
		if(dispense != dispenseCheck)	//check if there is a new input
			begin
			dispenseCheck <= dispense;	// set check to new input
			dispense_reg <= dispense;	// set reg to new input
			complete <= 1'b0;
			end
		if(start == 1'b1)	//dispense if start is one
			begin
				case(state)
						control:		//CONTROL
							begin
							if(dispense_reg == 2'b00)	//if dispense is 0 then dispense red
								begin
								dispense_reg <= 2'b11;	//set as dispensed
								state <= red;			//goto red state
								end
							else if(dispense_reg == 2'b01)	//if dispense is 1 the dispense green
								begin
								dispense_reg <= 2'b11;	//set as dispensed
								state <= green;			//goto state green
								end
							else if(dispense_reg == 2'b10)	//if dispense is 2 then dispense blue
								begin
								dispense_reg <= 2'b11;	//set as dispensed
								state <= blue;			//goto state blue
								end
							else
								begin
								state <= control;		//no new input so loop back to check again
								end
							end
						red:			//RED total time on FPGA = 1.0 seconds
							begin
							redLED <= 1'b1;
							dispenseServoRed <= 10'd200;	//set servo to push chip out
							state <= redSecond;			//goto second red state
							end
						redSecond:		//RED SECOND
							begin
							if(pause >= 30000000)		//wait for 0.6 seconds
								begin
								pause <= 25'b0;				//reset pause to 0
								dispenseServoRed <= 10'd440;	//setservo to let next chip fall
								state <= redThird;
								end
							else
								begin
								pause <= pause + 1'b1;		//not at end of wait loop
								state <= redSecond;		//loop
								end
							end
						redThird:
							begin
							if(pause >= 20000000)		//wait for 0.4 seconds
								begin
								pause <= 25'b0;
								complete <= 1'b1;	//task complete
								redLED <= 1'b0;
								state <= control;	//end red state and return to control
								end
							else
								begin
								pause <= pause + 1'b1;
								state <= redThird;
								end
							end
						green:			//GREEN total time on FPGA = 1.0 seconds
							begin
							greenLED <= 1'b1;
							dispenseServoGreenBlue <= 10'd355;
							if(pause >= 15000000)		//wait for 0.3 seconds
								begin
								pause <= 25'b0;
								state <= greenSecond;				//goto second green state
								end
							else
								begin
								pause <= pause + 1'b1;
								state <= green;
								end						
							
							end
						greenSecond:	//GREEN SECOND
							begin
							dispenseServoGreenBlue <= 10'd590;	//set servo to push out green chip
							if(pause >= 20000000)		//wait 0.4 seconds
								begin
								pause <= 25'b0;				//reset pause to 0
								
								state <= greenThird;
								end
							else
								begin
								pause <= pause + 1'b1;		//not at end of loop
								state <= greenSecond;	//loop
								end
							end
						greenThird:
							begin
							dispenseServoGreenBlue <= 10'd375;	//set servo to let next chip fall
							if(pause >= 20000000)		//wait for 0.4 seconds
								begin
								pause <= 25'b0;
								complete <= 1'b1;	//task complete
								greenLED <= 1'b0;
								state <= control;	//end green state and return to control
								end
							else
								begin
								pause <= pause + 1'b1;
								state <= greenThird;
								end
							end
						blue:			//BLUE total time on FPGA = 1.1 seconds
							begin
							blueLED <= 1'b1;
							dispenseServoGreenBlue <= 10'd395;
							if(pause >= 15000000)		//wait for 0.3 seconds
								begin
								pause <= 25'b0;
								state <= blueSecond;			//goto second blue state
								end
							else
								begin
								pause <= pause + 1'b1;
								state <= blue;
								end
							end
						blueSecond:		//BLUE SECOND
							begin
							dispenseServoGreenBlue <= 10'd10;	//set servo to push chip out
							if(pause >= 20000000)			//wait 0.4 seconds
								begin
								pause <= 25'b0;					//reset pause to 0								
								state <= blueThird;
								end
							else
								begin
								pause <= pause + 1'b1;		//not at end of loop
								state <= blueSecond;	//loop
								end
							end
						blueThird:
							begin
								dispenseServoGreenBlue <= 10'd375;	//set servo to let next chip fall
								if(pause >= 20000000)		//wait 0.4 seconds
								begin
								pause <= 25'b0;
								complete <= 1'b1;	//task complete
								blueLED <= 1'b0;
								state <= control;	//end blue state and return to cnotrol
								end
							else
								begin
								pause <= pause + 1'b1;
								state <= blueThird;
								end
							end
				endcase
			end
	end	
endmodule