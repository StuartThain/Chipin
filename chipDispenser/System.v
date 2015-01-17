// Copyright (C) 1991-2007 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

module System(
	clk,
	mbed,
	select,
	GreenBlueServoOut,
	RedServoOut,
	BinRecycleServoOut,
	RedBlueServoOut,
	GreenOtherServoOut,
	dispenseBlueLED,
	dispenseComplete,
	dispenseGreenLED,
	dispenseRedLED,
	mainState,
	mbedOutput,
	results,
	sortBlueLED,
	sortComplete,
	sortGreenLED,
	sortRedLED
);

input	clk;
input	[6:0] mbed;
input	[0:0] select;
output	GreenBlueServoOut;
output	RedServoOut;
output	BinRecycleServoOut;
output	RedBlueServoOut;
output	GreenOtherServoOut;
output	[0:0] dispenseBlueLED;
output	[0:0] dispenseComplete;
output	[0:0] dispenseGreenLED;
output	[0:0] dispenseRedLED;
output	[4:0] mainState;
output	[2:0] mbedOutput;
output	[2:0] results;
output	[0:0] sortBlueLED;
output	[0:0] sortComplete;
output	[0:0] sortGreenLED;
output	[0:0] sortRedLED;

wire	[1:0] conDispenseColour;
wire	[0:0] conDispenseStart;
wire	[2:0] conSortColour;
wire	[0:0] conSortStart;
wire	[2:0] controllerOutput;
wire	[0:0] dispenseComplete_ALTERA_SYNTHESIZED;
wire	[9:0] mainBinRecycle;
wire	[1:0] mainDispenseColour;
wire	[0:0] maindispenseStart;
wire	[9:0] mainGreenBlue;
wire	[9:0] mainGreenOther;
wire	[9:0] mainRed;
wire	[9:0] mainRedBlue;
wire	[2:0] mainSortColour;
wire	[0:0] mainSortStart;
wire	[2:0] maintenanceOutput;
wire	[9:0] normalBinRecycle;
wire	[9:0] normalGreenBlue;
wire	[9:0] normalGreenOther;
wire	[9:0] normalRed;
wire	[9:0] normalRedBlue;
wire	[0:0] selectBinRecycle;
wire	[0:0] selectGreenBlue;
wire	[0:0] selectGreenOther;
wire	[0:0] selectRed;
wire	[0:0] selectRedBlue;
wire	[0:0] sortComplete_ALTERA_SYNTHESIZED;
wire	[0:0] startSort;
wire	[9:0] SYNTHESIZED_WIRE_0;
wire	[9:0] SYNTHESIZED_WIRE_1;
wire	[9:0] SYNTHESIZED_WIRE_2;
wire	[2:0] SYNTHESIZED_WIRE_3;
wire	[6:0] SYNTHESIZED_WIRE_4;
wire	[6:0] SYNTHESIZED_WIRE_5;
wire	[0:0] SYNTHESIZED_WIRE_6;
wire	[1:0] SYNTHESIZED_WIRE_7;
wire	[9:0] SYNTHESIZED_WIRE_8;
wire	[9:0] SYNTHESIZED_WIRE_9;





RCServo	b2v_BinRecycleServo(.clk(clk),
.RxD_data(SYNTHESIZED_WIRE_0),.RCServo_pulse(BinRecycleServoOut));
defparam	b2v_BinRecycleServo.ClkDiv = 195;

multiplexerServo	b2v_BinRecycleServoMux(.normalSort(normalBinRecycle),
.select(selectBinRecycle),.servoTest(mainBinRecycle),.muxOut(SYNTHESIZED_WIRE_0));
defparam	b2v_BinRecycleServoMux.normal = 'b0;
defparam	b2v_BinRecycleServoMux.test = 'b1;

RCServo	b2v_GreenBlueServo(.clk(clk),
.RxD_data(SYNTHESIZED_WIRE_1),.RCServo_pulse(GreenBlueServoOut));
defparam	b2v_GreenBlueServo.ClkDiv = 195;

multiplexerServo	b2v_GreenBlueServoMux(.normalSort(normalGreenBlue),
.select(selectGreenBlue),.servoTest(mainGreenBlue),.muxOut(SYNTHESIZED_WIRE_1));
defparam	b2v_GreenBlueServoMux.normal = 'b0;
defparam	b2v_GreenBlueServoMux.test = 'b1;

RCServo	b2v_GreenOtherServo(.clk(clk),
.RxD_data(SYNTHESIZED_WIRE_2),.RCServo_pulse(GreenOtherServoOut));
defparam	b2v_GreenOtherServo.ClkDiv = 195;

multiplexerServo	b2v_GreenOtherServoMux(.normalSort(normalGreenOther),
.select(selectGreenOther),.servoTest(mainGreenOther),.muxOut(SYNTHESIZED_WIRE_2));
defparam	b2v_GreenOtherServoMux.normal = 'b0;
defparam	b2v_GreenOtherServoMux.test = 'b1;

sort	b2v_inst(.clk(clk),
.start(startSort),.colour(SYNTHESIZED_WIRE_3),.complete(sortComplete_ALTERA_SYNTHESIZED),.blueLED(sortBlueLED),.greenLED(sortGreenLED),.redLED(sortRedLED),.sortServoBinRecycle(normalBinRecycle),.sortServoGreenOther(normalGreenOther),.sortServoRedBlue(normalRedBlue));
defparam	b2v_inst.bin = 'b0111;
defparam	b2v_inst.binSecond = 'b1000;
defparam	b2v_inst.binThird = 'b1001;
defparam	b2v_inst.blue = 'b0101;
defparam	b2v_inst.blueSecond = 'b0110;
defparam	b2v_inst.colourSense = 'b0000;
defparam	b2v_inst.green = 'b0011;
defparam	b2v_inst.greenSecond = 'b0100;
defparam	b2v_inst.recycle = 'b1010;
defparam	b2v_inst.recycleSecond = 'b1011;
defparam	b2v_inst.recycleThird = 'b1100;
defparam	b2v_inst.red = 'b0001;
defparam	b2v_inst.redSecond = 'b0010;

multiplexerFour	b2v_inst11(.controllerStart(conSortStart),
.maintenanceStart(mainSortStart),.controllerInput(conSortColour),.maintenanceInput(mainSortColour),.select(select),.startOut(startSort),.muxOut(SYNTHESIZED_WIRE_3));
defparam	b2v_inst11.controller = 'b0;
defparam	b2v_inst11.maintenance = 'b1;

multiplexerOutput	b2v_inst12(.maintenanceOutput(maintenanceOutput),
.normalOutput(controllerOutput),.select(select),.muxOut(mbedOutput));
defparam	b2v_inst12.maintenance = 'b1;
defparam	b2v_inst12.normal = 'b0;

multiplexerThree	b2v_inst17(.controllerInput(conDispenseColour),
.controllerStart(conDispenseStart),.maintenanceInput(mainDispenseColour),.maintenanceStart(maindispenseStart),.select(select),.muxOut(SYNTHESIZED_WIRE_7),.startOut(SYNTHESIZED_WIRE_6));
defparam	b2v_inst17.controller = 'b0;
defparam	b2v_inst17.maintenance = 'b1;

maintenance	b2v_inst2(.clk(clk),
.sortComplete(sortComplete_ALTERA_SYNTHESIZED),.dispenseComplete(dispenseComplete_ALTERA_SYNTHESIZED),.inputSignal(SYNTHESIZED_WIRE_4),.sortStart(mainSortStart),.dispenseStart(maindispenseStart),.selectRedBlue(selectRedBlue),.selectGreenOther(selectGreenOther),.selectBinRecycle(selectBinRecycle),.selectRed(selectRed),.selectGreenBlue(selectGreenBlue),.dispense(mainDispenseColour),.positionBinRecycle(mainBinRecycle),.positionGreenBlue(mainGreenBlue),.positionGreenOther(mainGreenOther),.positionRed(mainRed),.positionRedBlue(mainRedBlue),.results(maintenanceOutput),.sortColour(mainSortColour),.state(mainState));
defparam	b2v_inst2.binHopper = 'b00001;
defparam	b2v_inst2.control = 'b00000;
defparam	b2v_inst2.dispenseBlue = 'b00100;
defparam	b2v_inst2.dispenseGreen = 'b00011;
defparam	b2v_inst2.dispenseRed = 'b00010;
defparam	b2v_inst2.maintenanceEND = 'b10010;
defparam	b2v_inst2.testBinRecycleLeft = 'b01011;
defparam	b2v_inst2.testBinRecycleRight = 'b01100;
defparam	b2v_inst2.testGreenBlueCentre = 'b10000;
defparam	b2v_inst2.testGreenBlueLeft = 'b01111;
defparam	b2v_inst2.testGreenBlueRight = 'b10001;
defparam	b2v_inst2.testGreenOtherCentre = 'b01001;
defparam	b2v_inst2.testGreenOtherDown = 'b01010;
defparam	b2v_inst2.testGreenOtherUp = 'b01000;
defparam	b2v_inst2.testRedBlueCentre = 'b00110;
defparam	b2v_inst2.testRedBlueLeft = 'b00101;
defparam	b2v_inst2.testRedBlueRight = 'b00111;
defparam	b2v_inst2.testRedHome = 'b01110;
defparam	b2v_inst2.testRedPush = 'b01101;

controller	b2v_inst3(.clk(clk),
.sortCompleteIn(sortComplete_ALTERA_SYNTHESIZED),.dispenseCompleteIn(dispenseComplete_ALTERA_SYNTHESIZED),.mbedInput(SYNTHESIZED_WIRE_5),.dispense(conDispenseColour),.dispenseStart(conDispenseStart),.mbedOutput(controllerOutput),.sortColour(conSortColour),.sortStart(conSortStart));

multiplexerSeven	b2v_inst4(.mbedInput(mbed),
.select(select),.controllerOutput(SYNTHESIZED_WIRE_5),.maintenanceOutput(SYNTHESIZED_WIRE_4));
defparam	b2v_inst4.controller = 'b0;
defparam	b2v_inst4.maintenance = 'b1;

dispense	b2v_inst6(.clk(clk),
.start(SYNTHESIZED_WIRE_6),.dispense(SYNTHESIZED_WIRE_7),.complete(dispenseComplete_ALTERA_SYNTHESIZED),.blueLED(dispenseBlueLED),.dispenseServoGreenBlue(normalGreenBlue),.dispenseServoRed(normalRed),.greenLED(dispenseGreenLED),.redLED(dispenseRedLED));
defparam	b2v_inst6.blue = 'b0111;
defparam	b2v_inst6.blueSecond = 'b1000;
defparam	b2v_inst6.blueThird = 'b1001;
defparam	b2v_inst6.control = 'b0000;
defparam	b2v_inst6.green = 'b0100;
defparam	b2v_inst6.greenSecond = 'b0101;
defparam	b2v_inst6.greenThird = 'b0110;
defparam	b2v_inst6.red = 'b0001;
defparam	b2v_inst6.redSecond = 'b0010;
defparam	b2v_inst6.redThird = 'b0011;

RCServo	b2v_RedBlueServo(.clk(clk),
.RxD_data(SYNTHESIZED_WIRE_8),.RCServo_pulse(RedBlueServoOut));
defparam	b2v_RedBlueServo.ClkDiv = 195;

multiplexerServo	b2v_RedBlueServoMux(.normalSort(normalRedBlue),
.select(selectRedBlue),.servoTest(mainRedBlue),.muxOut(SYNTHESIZED_WIRE_8));
defparam	b2v_RedBlueServoMux.normal = 'b0;
defparam	b2v_RedBlueServoMux.test = 'b1;

RCServo	b2v_RedServo(.clk(clk),
.RxD_data(SYNTHESIZED_WIRE_9),.RCServo_pulse(RedServoOut));
defparam	b2v_RedServo.ClkDiv = 195;

multiplexerServo	b2v_RedServoMux(.normalSort(normalRed),
.select(selectRed),.servoTest(mainRed),.muxOut(SYNTHESIZED_WIRE_9));
defparam	b2v_RedServoMux.normal = 'b0;
defparam	b2v_RedServoMux.test = 'b1;
assign	dispenseComplete = dispenseComplete_ALTERA_SYNTHESIZED;
assign	results = maintenanceOutput;
assign	sortComplete = sortComplete_ALTERA_SYNTHESIZED;


endmodule
