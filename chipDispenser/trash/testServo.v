module testServo(clk, servoSelect, selectRedBlue, selectGreenOther, selectBinRecycle, selectRed, selectGreenBlue, positionRedBlue, positionGreenOther, positionBinRecycle, positionRed, positionGreenBlue, testComplete);

//inputs
input clk;
input [3:0] servoSelect;

//outputs
output selectRedBlue, selectGreenOther, selectBinRecycle, selectRed, selectGreenBlue;
output [9:0] positionRedBlue, positionGreenOther, positionBinRecycle, positionRed, positionGreenBlue;
output testComplete;

//reg
reg selectRedBlue, selectGreenOther, selectBinRecycle, selectRed, selectGreenBlue;
reg [9:0] positionRedBlue, positionGreenOther, positionBinRecycle, positionRed, positionGreenBlue;
reg [3:0] state;
reg [24:0] pause;
reg [3:0] servoSelectCheck, servoSelect_reg;
reg testComplete;

//initial
initial pause = 25'd0;
initial selectRedBlue = 1'b0;
initial selectGreenOther = 1'b0;
initial selectBinRecycle = 1'b0;
initial selectRed = 1'b0;
initial selectGreenBlue = 1'b0;

//state
parameter control = 4'd0, redBlueLeft = 4'd1, redBlueCentre = 4'd2, redBlueRight = 4'd3, greenOtherUp = 4'd4,
		  greenOtherCentre = 4'd5, greenOtherDown = 4'd6, binRecycleLeft = 4'd7, binRecycleRight = 4'd8,
		  redPush = 4'd9, redHome = 4'd10, greenBlueLeft = 4'd11, greenBlueCentre = 4'd12,
		  greenBlueRight = 4'd13, maintenanceEND = 4'd14;

always@(posedge clk)
	begin
	if(servoSelectCheck != servoSelect)	//check if the input of which servo to test has changed
		begin
		servoSelectCheck <= servoSelect;	//change the check to the input if it is diffrent
		servoSelect_reg <= servoSelect;		//change the reg to the input if it is diffrent
		testComplete <= 1'b0;
		end
	case(state)
		control:
			begin
			if(servoSelect_reg == 4'b0000)	//check if input is redBlueLeft
				begin
				servoSelect_reg <= 4'b1111;	// set servo select to do nothing state
				state <= redBlueLeft;	//goto redBlueLeft state
				end
			else if(servoSelect_reg == 4'b0001)	//check if input is redBlueCentre
				begin
				servoSelect_reg <= 4'b1111;	//set servo select to do nothing state
				state <= redBlueCentre;	//goto greenOtherLeft state
				end
			else if(servoSelect == 4'b0010)	//check if input is redBlueRight
				begin
				servoSelect_reg <= 4'b1111;
				state <= redBlueRight;
				end
			else if(servoSelect_reg == 4'b0011)	//check if input is greenOtherUp
				begin
				servoSelect_reg <= 4'b1111;
				state <= greenOtherUp;
				end
			else if(servoSelect_reg == 4'b0100)	//check if input is greenOtherCentre
				begin
				servoSelect_reg <= 4'b1111;
				state <= greenOtherCentre;
				end
			else if(servoSelect_reg == 4'b0101)	//check if input is greenOtherDown
				begin
				servoSelect_reg <= 4'b1111;
				state <= greenOtherDown;
				end
			else if(servoSelect_reg == 4'b0110)	//check if input is binRecycleLeft
				begin
				servoSelect_reg <= 4'b1111;
				state <= binRecycleLeft;
				end
			else if(servoSelect_reg == 4'b0111)	//check if input is binRecycleRight
				begin
				servoSelect_reg <= 4'b1111;
				state <= binRecycleRight;
				end
			else if(servoSelect_reg == 4'b1000)	//check if input is redPush
				begin
				servoSelect_reg <= 4'b1111;
				state <= redPush;
				end
			else if(servoSelect_reg == 4'b1001)	//check if input is redHome
				begin
				servoSelect_reg <= 4'b1111;
				state <= redHome;
				end
			else if(servoSelect_reg == 4'b1010)	//check if input is greenBlueLeft
				begin
				servoSelect_reg <= 4'b1111;
				state <= greenBlueLeft;
				end
			else if(servoSelect_reg == 4'b1011)	//check if input is greenBlueCentre
				begin
				servoSelect_reg <= 4'b1111;
				state <= greenBlueCentre;
				end
			else if(servoSelect_reg == 4'b1100)	//check if input is greenBlueRight
				begin
				servoSelect_reg <= 4'b1111;
				state <= greenBlueRight;
				end
			else if(servoSelect_reg == 4'b1101)
				begin
				servoSelect_reg <= 4'b1111;
				state <= maintenanceEND;
				end
			else
				state <= control;			//if servo select is none of the action values then set state back to cnotrol
			end
		redBlueLeft:			//REDBLUELEFT
			begin
			selectRedBlue <= 1'b1;
			positionRedBlue <= 10'd160;	//set servo to 0 degrees
			if(pause == 25000000)
				begin
				pause <= 0;
				testComplete <= 1'b1;
				state <= control;
				end
			else
				begin
				pause <= pause + 1;
				state <= redBlueLeft;
				end
			end
		redBlueCentre:			//REDBLUECENTRE
			begin
			selectRedBlue <= 1'b1;
			positionRedBlue <= 10'd355;	//set servo to 90 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto control state
				end
			else
				begin
				pause <= pause + 1;	//increse pause by one
				state <= redBlueCentre;	//continue looping
				end
			end
		redBlueRight:			//REDBLUERIGHT
			begin
			selectRedBlue <= 1'b1;
			positionRedBlue <= 10'd800;	//set servo to 90 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0 
				testComplete <= 1'b1;
				state <= control;	//goto control state
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= redBlueRight;	//goto state redBlueRight
				end
			end
		greenOtherUp:			//GREENOTHERUP
			begin
			selectGreenOther <= 1'b1;
			positionGreenOther <= 10'd160;	//set servo to 0 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state control
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= greenOtherUp;	//goto state greenOtherUp
				end
			end
		greenOtherCentre:		//GREENOTHERCENTRE
			begin
			selectGreenOther <= 1'b1;
			positionGreenOther <= 10'd355;	//set servo to 180 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state control
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= greenOtherCentre;	//goto state greenOtherCentre
				end
			end
		greenOtherDown:		//GREENOTHERDOWN
			begin
			selectGreenOther <= 1'b1;
			positionGreenOther <= 10'd800;	//set servo to 90 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state control
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= greenOtherDown;	//goto state greenOtherCentre
				end
			end
		binRecycleLeft:			//BINRECYCLELEFT
			begin
			selectBinRecycle <= 1'b1;
			positionBinRecycle <= 10'd160;	//set servo to 0 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state binRecycle
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= binRecycleLeft;	//goto state binRecycleLeft
				end
			end
		binRecycleRight:		//BINRECYCLERIGHT
			begin
			selectBinRecycle <= 1'b1;
			positionBinRecycle <= 10'd800;	//set servo to 180 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state control
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= binRecycleRight;	//goto state binRecycleRight
				end
			end
		redPush:				//REDPUSH
			begin
			selectRed <= 1'b1;
			positionRed <= 10'd160;	//set servo to 0 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state redRight
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= redPush;	//goto state redLeft
				end
			end
		redHome:				//REDHOME
			begin
			selectRed <= 1'b1;
			positionRed <= 10'd355;	//set servo to 180 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state redCentre
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= redHome;	//goto state redRight
				end
			end
		greenBlueLeft:			//GREENBLUELEFT
			begin
			selectGreenBlue <= 1'b1;
			positionGreenBlue <= 10'd160;	//set servo to 0 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state greenBlueRight
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= greenBlueLeft;	//goto state greenBlueLeft
				end
			end
		greenBlueCentre:			//GREENBLUECENTRE
			begin
			selectGreenBlue <= 1'b1;
			positionGreenBlue <= 10'd355;	//set servo to 180 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state greenBlueCentre
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= greenBlueCentre;	//goto state greenBlueRight
				end
			end
		greenBlueRight:		//GREENBLUERIGHT
			begin
			selectGreenBlue <= 1'b1;
			positionGreenBlue <= 10'd800;	//set servo to 90 degrees
			if(pause == 25000000)	//wait for 0.5 seconds
				begin
				pause <= 0;	//set pause to 0
				testComplete <= 1'b1;
				state <= control;	//goto state control
				end
			else
				begin
				pause <= pause + 1;	//increase pause by one
				state <= greenBlueRight;	//goto state greenBlueCentre
				end
			end
		maintenanceEND:
			begin
			selectRedBlue <= 1'b1;
			selectGreenOther <= 1'b1;
			selectBinRecycle <= 1'b1;
			selectRed <= 1'b1;
			selectGreenBlue <= 1'b1;
			positionRedBlue <= 10'd355;
			positionGreenOther <= 10'd355;
			positionBinRecycle <= 10'd160;
			positionRed <= 10'd355;
			positionGreenBlue <= 10'd355;
			if(pause == 25000000)
				begin
				pause <= 0;
				selectRedBlue <= 1'b0;
				selectGreenOther <= 1'b0;
				selectBinRecycle <= 1'b0;
				selectRed <= 1'b0;
				selectGreenBlue <= 1'b0;
				testComplete <= 1'b1;
				state <= control;
				end
			else
				begin
				pause = pause + 1;
				state <= maintenanceEND;
				end
			end
		endcase
	end
	
endmodule










