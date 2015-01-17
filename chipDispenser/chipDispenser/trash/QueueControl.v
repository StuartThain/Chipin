module QueueControl(clk, sortRedIn, sortGreenIn, sortBlueIn, dispenseRedIn, dispenseGreenIn,
					dispenseBlueIn,
					sortRedOut, sortGreenOut, sortBlueOut, dispenseRedOut, dispenseGreenOut, dispenseBlueOut,
					mainRedOut, mainGreenOut, mainBlueOut);

input clk;
input [5:0] sortRedIn, sortGreenIn, sortBlueIn, dispenseRedIn, dispenseGreenIn,
			dispenseBlueIn;

output [5:0] sortRedOut, sortGreenOut, sortBlueOut, dispenseRedOut, dispenseGreenOut, dispenseBlueOut,
			 mainRedOut, mainGreenOut, mainBlueOut;

reg [5:0] sortRedOut, sortGreenOut, sortBlueOut, dispenseRedOut, dispenseGreenOut, dispenseBlueOut,
		  mainRedOut, mainGreenOut, mainBlueOut;
reg [5:0] redQueue, greenQueue, blueQueue;

initial redQueue = 0; 
initial greenQueue = 0;
initial blueQueue = 0;

always@(posedge clk)
	begin
	//red
	if(redQueue != sortRedIn && redQueue == dispenseRedIn)
		begin
		redQueue <= sortRedIn;
		sortRedOut <= sortRedIn;
		dispenseRedOut <= sortRedIn;
		mainRedOut <= sortRedIn;
		end
	else if(redQueue == sortRedIn && redQueue != dispenseRedIn)
		begin
		redQueue <= dispenseRedIn;
		sortRedOut <= dispenseRedIn;
		dispenseRedOut <= dispenseRedIn;
		mainRedOut <= dispenseRedIn;
		end
	else if(redQueue != sortRedIn && redQueue != dispenseRedIn)
		begin
		sortRedOut <= redQueue;
		dispenseRedOut <= redQueue;
		end
	//green
	else if(greenQueue != sortGreenIn && greenQueue == dispenseGreenIn)
		begin
		greenQueue <= sortGreenIn;
		sortGreenOut <= sortGreenIn;
		dispenseGreenOut <= sortGreenIn;
		mainGreenOut <= sortGreenIn;
		end
	else if(greenQueue == sortGreenIn && greenQueue != dispenseGreenIn)
		begin
		greenQueue <= dispenseGreenIn;
		sortGreenOut <= dispenseGreenIn;
		dispenseGreenOut <= dispenseGreenIn;
		mainGreenOut <= sortGreenIn;
		end
	else if(greenQueue != sortGreenIn && greenQueue != dispenseGreenIn)
		begin
		sortGreenOut <= greenQueue;
		dispenseGreenOut <= greenQueue;
		end
	//blue
	else if(blueQueue != sortBlueIn && blueQueue == dispenseBlueIn)
		begin
		blueQueue <= sortBlueIn;
		sortBlueOut <= sortBlueIn;
		dispenseBlueOut <= sortBlueIn;
		mainBlueOut <= sortBlueIn;
		end
	else if(blueQueue == sortBlueIn && blueQueue != dispenseBlueIn)
		begin
		blueQueue <= dispenseBlueIn;
		sortBlueOut <= dispenseBlueIn;
		dispenseBlueOut <= dispenseBlueIn;
		mainBlueOut <= dispenseBlueIn;
		end
	else if(blueQueue != sortBlueIn && blueQueue != dispenseBlueIn)
		begin
		sortBlueOut <= blueQueue;
		dispenseBlueOut <=blueQueue;
		end
	end
endmodule












