module RCServoFull(clk, clockwise,anticlockwise, RCServo_pulse);
input clk;
input [0:0] clockwise,anticlockwise;
output RCServo_pulse;
reg RCServo_pulse;


parameter ClkDiv = 195; 

reg [7:0] ClkCount;
reg ClkTick;
always @(posedge clk) ClkTick <= (ClkCount==ClkDiv-2); //set ClkTick to 1 when reach state
always @(posedge clk) if(ClkTick) ClkCount <= 8'b0; else ClkCount <= ClkCount + 1'b1; /* reset ClkCount when 1 tick
                                                                             else continue counting*/

////////////////////////////////////////////////////////////////////////////
reg [11:0] PulseCount;
always @(posedge clk) if(ClkTick) PulseCount <= PulseCount + 1'b1; // for each tick increment pulsecount 1

// make sure the RCServo_position is stable while the pulse is generated
reg [9:0] RCServo_position;
always @(posedge clk) if(PulseCount==0) RCServo_position <= {clockwise,anticlockwise,8'b01101111}; /*first time through Pulsecount output width of pulse
                                                                           thereafter output 0 until time for next pulse*/


always @(posedge clk) RCServo_pulse <= (PulseCount < {2'b00,RCServo_position}); /*set output low until
                                                                             length of pulse is reached*/

endmodule