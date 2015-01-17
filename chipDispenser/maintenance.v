module maintenance(clk, inputSignal, results, sortStart, dispenseStart, sortColour, dispense, sortComplete, dispenseComplete,
			selectRedBlue, selectGreenOther, selectBinRecycle, selectRed, selectGreenBlue, positionRedBlue, positionGreenOther, positionBinRecycle, positionRed, positionGreenBlue, state);

//input
input clk;
input [6:0] inputSignal;
input sortComplete, dispenseComplete;

//output
output [2:0] results;
output [2:0] sortColour;	//which colour is to be sorted
output sortStart, dispenseStart;	//tell the system to start sorting and/or dispensing
output [1:0] dispense;		//which colour is to be dispensed
output [9:0] positionRedBlue, positionGreenOther, positionBinRecycle, positionRed, positionGreenBlue;
output selectRedBlue, selectGreenOther, selectBinRecycle, selectRed, selectGreenBlue;
output [4:0] state;


//reg
reg [4:0] state;
reg [0:0] start;
reg [5:0] controlSignal;
reg [5:0] controlSignal_reg;
reg [5:0] controlSignalCheck;
reg [2:0] sortColour;
reg sortStart, dispenseStart;
reg [1:0] dispense;
reg [2:0] results;
reg [0:0] complete;
reg [0:0] received;
reg [24:0] pause;
reg [26:0] count;
reg [9:0] positionRedBlue, positionGreenOther, positionBinRecycle, positionRed, positionGreenBlue;
reg selectRedBlue, selectGreenOther, selectBinRecycle, selectRed, selectGreenBlue;

//initial
initial state = 5'd0;
initial pause = 25'd0;
initial count = 27'd0;
initial dispense = 2'b11;
initial sortColour = 3'b111;

//parameter
parameter control = 5'd0, binHopper = 5'd1, dispenseRed = 5'd2, dispenseGreen = 5'd3, dispenseBlue = 5'd4,
		  testRedBlueLeft = 5'd5, testRedBlueCentre = 5'd6, testRedBlueRight = 5'd7, testGreenOtherUp = 5'd8,
		  testGreenOtherCentre = 5'd9, testGreenOtherDown = 5'd10, testBinRecycleLeft = 5'd11,
		  testBinRecycleRight = 5'd12, testRedPush = 5'd13, testRedHome = 5'd14, testGreenBlueLeft = 5'd15,
		  testGreenBlueCentre = 5'd16, testGreenBlueRight = 5'd17, maintenanceEND = 5'd18;

//return signals
always@(posedge clk)
	begin
	results[0:0] <= received;
	results[1:1] <= complete;
	results[2:2] <= 1'b0;
	end

//main code
always@(posedge clk)
	begin
		controlSignal <= inputSignal[5:0];	//set the first 5 values of the input to the control signal
		start <= inputSignal[6:6];			//set the last bit of the input to the start signal
		if(controlSignal != controlSignalCheck)	//check if the input has changed
			begin
			controlSignalCheck <= controlSignal;	// reset the check to the new value
			controlSignal_reg <= controlSignal;		// changed the used value
			received <= 1'b1;	//set received to 1 when new signal is received
			complete <= 1'b0;	//reset complete
			end
		else if(count == 50000000)	//wait a second to turn received off
			begin
			count <= 27'b0;
			received <= 1'b0;
			end
		else
			begin
			count <= count + 1'b1;
			end
		if(start)	//if the start bit is equal to 1 then run the main code else do nothing
			begin
				case(state)
					control:
						begin
							if(controlSignal_reg == 6'b000001)	//check if the input is equal to 1
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= binHopper;
								end
							else if(controlSignal_reg == 6'b000010)	//check if the input is equal to 2
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= dispenseRed;
								end
							else if(controlSignal_reg == 6'b000011)	//check if the input is equal to 3
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= dispenseGreen;
								end
							else if(controlSignal_reg == 6'b000100)	//check if the input is equal to 4
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= dispenseBlue;
								end
							else if(controlSignal_reg == 6'b000101)	//check if the input is equal to 5
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testRedBlueLeft;
								end
							else if(controlSignal_reg == 6'b000110)	//check if the input is equal to 6
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testRedBlueCentre;
								end
							else if(controlSignal_reg == 6'b000111)	//check if the input is equal to 7
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testRedBlueRight;
								end
							else if(controlSignal_reg == 6'b001000)	//check if the input is equal to 8
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testGreenOtherUp;
								end
							else if(controlSignal_reg == 6'b001001)	//check if the input is equal to 9
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testGreenOtherCentre;
								end
							else if(controlSignal_reg == 6'b001010)	//check if the input is equal to 10
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testGreenOtherDown;
								end
							else if(controlSignal_reg == 6'b001011)	//check if the input is equal to 11
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testBinRecycleLeft;
								end
							else if(controlSignal_reg == 6'b001100)	//check if the input is equal to 12
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testBinRecycleRight;
								end
							else if(controlSignal_reg == 6'b001101)	//check if the input is equal to 13
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testRedPush;	
								end
							else if(controlSignal_reg == 6'b001110)	//check if the input is equal to 14
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testRedHome;
								end
							else if(controlSignal_reg == 6'b001111)	//check if the input is equal to 15
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testGreenBlueLeft;
								end
							else if(controlSignal_reg == 6'b010000)	//check if the input is equal to 16
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testGreenBlueCentre;
								end
							else if(controlSignal_reg == 6'b010001)	//check if the input is equal to 17
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= testGreenBlueRight;
								end
							else if(controlSignal_reg == 6'b010010)	//check if the input is equal to 18
								begin
								controlSignal_reg <= 6'b111111;	//set the input reg to do nothing state so the code only runs once
								state <= maintenanceEND;
								end
							else		//if none of the above is true then the state stays the same and loop throw again
								begin
								state <= control;
								end
						end
					binHopper:			//BIN HOPPER
						begin
						sortStart <= 1'b1;	//set start sort to 1
						sortColour <= 3'b011;	//set the colour to bin
						if(sortComplete)	//if a complete signal is received then end state
							begin
							sortColour <= 3'b111;	//set colour to do nothing state
							sortStart <= 1'b0;		//set start sort to 0
							complete <= 1'b1;		//set the complete output to 1
							state <= control;		
							end
						else				//if not complete loop back to the start of the state
							begin
							state <= binHopper;
							end
						end
					dispenseRed:		//DISPENSE RED
						begin
						dispenseStart <= 1'b1;	//set start dispense to 1
						dispense <= 2'b00;		//set the colour to red
						if(dispenseComplete)	//if a complete signal is received then end this state
							begin
							dispense <= 2'b11;	// set the colour to do nothing state
							dispenseStart <= 1'b0;	//reset dispense start to 0
							complete <= 1'b1;	//set as complete
							state <= control;	//return to the control state
							end
						else
							begin
							state <= dispenseRed;	//else loop
							end
						end
					dispenseGreen:		//DISPENSE GREEN
						begin
						dispenseStart <= 1'b1;	//set start dispense to 1
						dispense <= 2'b01;		//set dispense to the colour green
						if(dispenseComplete)	//loop until the dispense complete signal is received
							begin
							dispense <= 2'b11;	//reset dispense to do nothing
							dispenseStart <= 1'b0;	//reset dispense start
							complete <= 1'b1;	//set as complete
							state <= control;	//return to the control state
							end
						else
							begin
							state <= dispenseGreen;	//else loop
							end
						end
					dispenseBlue:		//DISPENSE BLUE
						begin
						dispenseStart <= 1'b1;	//set start dispense to 1
						dispense <= 2'b10;		//set dispense to the colour blue
						if(dispenseComplete)	//loop until the dispense complete signal is received
							begin
							dispense <= 2'b11;	//reset dispense to do nothing
							dispenseStart <= 1'b0;	//reset dispense start
							complete <= 1'b1;	//set as complete
							state <= control;	//return to the control state
							end
						else
							begin
							state <= dispenseBlue; //else loop
							end
						end
					testRedBlueLeft:
						begin
						selectRedBlue <= 1'b1;
						positionRedBlue <= 10'd570;	//set servo to the left degrees
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto control state
							end
						else
							begin
							pause <= pause + 1'b1;
							state <= testRedBlueLeft;
							end
						end
					testRedBlueCentre:
						begin
						selectRedBlue <= 1'b1;
						positionRedBlue <= 10'd355;	//set servo to the centre
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto control state
							end
						else
							begin
							pause <= pause + 1'b1;	//increse pause by one
							state <= testRedBlueCentre;	//continue looping
							end
						end
					testRedBlueRight:
						begin
						selectRedBlue <= 1'b1;
						positionRedBlue <= 10'd185;	//set servo to right degrees
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0 
							complete <= 1'b1;
							state <= control;	//goto control state
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testRedBlueRight;	//goto state redBlueRight
							end
						end
					testGreenOtherUp:
						begin
						selectGreenOther <= 1'b1;
						positionGreenOther <= 10'd560;	//set servo to the up position
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state control
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testGreenOtherUp;	//goto state greenOtherUp
							end
						end
					testGreenOtherCentre:
						begin
						selectGreenOther <= 1'b1;
						positionGreenOther <= 10'd340;	//set servo to the centre
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state control
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testGreenOtherCentre;	//goto state greenOtherCentre
							end
						end
					testGreenOtherDown:
						begin
						selectGreenOther <= 1'b1;
						positionGreenOther <= 10'd70;	//set servo to the down position
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state control
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testGreenOtherDown;	//goto state greenOtherCentre
							end
						end
					testBinRecycleLeft:
						begin
						selectBinRecycle <= 1'b1;
						positionBinRecycle <= 10'd350;	//set servo to the left
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state binRecycle
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testBinRecycleLeft;	//goto state binRecycleLeft
							end
						end
					testBinRecycleRight:
						begin
						selectBinRecycle <= 1'b1;
						positionBinRecycle <= 10'd580;	//set servo to the right
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state control
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testBinRecycleRight;	//goto state binRecycleRight
							end
						end
					testRedPush:
						begin
						selectRed <= 1'b1;
						positionRed <= 10'd200;	//set servo to the push position
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state redRight
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testRedPush;	//goto state redLeft
							end
						end
					testRedHome:
						begin
						selectRed <= 1'b1;
						positionRed <= 10'd440;	//set servo to the home position
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state redCentre
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testRedHome;	//goto state redRight
							end
						end
					testGreenBlueLeft:
						begin
						selectGreenBlue <= 1'b1;
						positionGreenBlue <= 10'd550;	//set servo to the left
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state greenBlueRight
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testGreenBlueLeft;	//goto state greenBlueLeft
							end
						end
					testGreenBlueCentre:
						begin
						selectGreenBlue <= 1'b1;
						positionGreenBlue <= 10'd355;	//set servo to the centre
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state greenBlueCentre
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testGreenBlueCentre;	//goto state greenBlueRight
							end
						end
					testGreenBlueRight:
						begin
						selectGreenBlue <= 1'b1;
						positionGreenBlue <= 10'd10;	//set servo to the right
						if(pause == 25000000)	//wait for 0.5 seconds
							begin
							pause <= 25'b0;	//set pause to 0
							complete <= 1'b1;
							state <= control;	//goto state control
							end
						else
							begin
							pause <= pause + 1'b1;	//increase pause by one
							state <= testGreenBlueRight;	//goto state greenBlueCentre
							end
						end
						//reset all values to the default for controller mode
					maintenanceEND:
						begin
						selectRedBlue <= 1'b1;
						selectGreenOther <= 1'b1;
						selectBinRecycle <= 1'b1;
						selectRed <= 1'b1;
						selectGreenBlue <= 1'b1;
						positionRedBlue <= 10'd355;
						positionGreenOther <= 10'd355;
						positionBinRecycle <= 10'd580;
						positionRed <= 10'd440;
						positionGreenBlue <= 10'd355;
						if(pause == 25000000)	//wait for servos to return
							begin
							pause <= 25'b0;
							selectRedBlue <= 1'b0;
							selectGreenOther <= 1'b0;
							selectBinRecycle <= 1'b0;
							selectRed <= 1'b0;
							selectGreenBlue <= 1'b0;
							complete <= 1'b1;
							state <= control;
							end
						else
							begin
							pause <= pause + 1'b1;
							state <= maintenanceEND;
							end
						end
				endcase
			end
	end
	
endmodule