module controller(clk, mbedInput, mbedOutput, sortStart, sortColour, dispenseStart, dispense, sortCompleteIn, dispenseCompleteIn);

//input
input clk;					//input clock
input [6:0] mbedInput;		//overall input
input sortCompleteIn, dispenseCompleteIn;

//output
output [2:0] mbedOutput;	//return signal to mbed
output [2:0] sortColour;	//which colour is to be sorted
output [0:0] sortStart, dispenseStart;	//tell the system to start sorting and/or dispensing
output [1:0] dispense;		//which colour is to be dispensed

//reg
reg [6:0] mbedInput_reg;	//reg the input so it can be split
reg [6:0] mbedInputCheck;
reg [0:0] sortStart;
reg [2:0] sortColour;
reg [0:0] dispenseStart;
reg [1:0] dispense;			
reg [2:0] mbedOutput;
reg sortCompleteOut, dispenseCompleteOut;
reg recieved;
reg [26:0] count;

always@(posedge clk)
	begin
	//mbedInputLED <= mbedInput;
	if(sortCompleteIn == 1'b1)	//check if sort comand is complete
		begin
		sortCompleteOut <= 1'b1;	//set sort complete to 1
		end
	if(dispenseCompleteIn == 1'b1) //check is dispence command is complete
		begin
		dispenseCompleteOut <= 1'b1; // set dispence complete to 1
		end
	if(mbedInputCheck != mbedInput)
		begin
		mbedInputCheck <= mbedInput;	//set check to new value
		mbedInput_reg <= mbedInput;	//load new input to the input reg
		recieved <= 1'b1;	//set recieved signal to 1
		sortCompleteOut <= 1'b0;	//set complete to 0
		dispenseCompleteOut <= 1'b0;	//setcomplete to 0
		end
	else
		begin
		if(count >= 50000000)	//wait for a second before reseting recieved
			begin
			count <= 27'b0;
			recieved <= 1'b0;
			end
		else
			begin
			count <= count + 1'b1;
			end
		end
	sortStart <= mbedInput_reg[0:0];		//set the second bit of input to starting sort
	sortColour <= mbedInput_reg[3:1];	//set the third to fifth bits to which colour is to be sorted
	dispenseStart <= mbedInput_reg[4:4];	//set to sixth bit to starting dispense
	dispense <= mbedInput_reg[6:5];		//set the seventh to eighth bits to which colour to dispense
	mbedOutput[0:0] <= recieved;		//set the first bit of the output to recieved
	mbedOutput[1:1] <= sortCompleteOut;	//set the second bit of the output to sort complete
	mbedOutput[2:2] <= dispenseCompleteOut;	// set the third bit of the output to dispense complete
	end
endmodule




