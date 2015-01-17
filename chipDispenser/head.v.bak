module head(clk, mouthServo, rotateServo);

//inputs
input clk;

//output
output [9:0] mouthServo, rotateServo;

//registers
reg [9:0] mouthServo, rotateServo;
reg [27:0] pause;
reg [2:0] state;

//setting the initial values
initial mouthServo = 10'd200;
initial rotateServo = 10'd400;
initial state = 3'd0;

//rename the states so increase readability
parameter mouth = 3'd0, mouthTwo = 3'd1, rotate = 3'd2, rotateTwo = 3'd3, rotateThree = 3'd4;

always@(posedge clk)
	begin
		case(state)
			mouth:		//MOVE THE JAW DOWN
				begin
				mouthServo <= 10'd700;	//move the head down so it is open
				if(pause >= 150000000)	//wait for 3 seconds
					begin
					pause <= 28'd0;	//reset the wait to zero
					state <= mouthTwo;	//change state to the next head movement
					end
				else
					begin
					pause <= pause + 1'b1;	//increase pause by one for the 10 second delay
					state <= mouth; //keep the state the same
					end
				end
			mouthTwo:	//MOVE THE JAW BACK UP
				begin
				mouthServo <= 10'd200;	//return the head to the default position
				if(pause >= 135000000)	//wait for 2.7 seconds
					begin
					pause <= 28'd0;		//reset the wait
					state <= rotate;	//change state to the mext head movement
					end
				else
					begin
					pause <= pause + 1'b1;	//increase pause by one for the 7 second delay
					state <= mouthTwo;	//keep the state the same
					end
				end
			rotate:		//ROTATE THE HEAD TO THE LEFT (CLOCKWISE)
				begin
				rotateServo <= 10'd530;		//move the head to the left
				if(pause >= 145000000)	//wait for 2.9 seconds
					begin
					pause <= 28'd0;	//reset the wait
					state <= rotateTwo;	//change state to the next head movement
					end
				else
					begin
					pause <= pause + 1'b1;	//increase pause by one for the 7 second delay
					state <= rotate;	//keep the state the same
					end
				end
			rotateTwo:	//ROTATE THE HEAD TO THE RIGHT (COUNTER-CLOCKWISE)
				begin
				rotateServo <= 10'd330;	//move the head to the right
				if(pause >= 150000000)	//wait for 3 seconds
					begin
					pause <= 28'd0;	//reset the wait
					state <= rotateThree;	//change state to the next head movement
					end
				else
					begin
					pause <= pause + 1'b1;	//increase pause by one for the 7 second delay
					state <= rotateTwo;	//keep the state the same
					end
				end
			rotateThree:	//RETURN THE HEAD TO THE MIDDLE
				begin
				rotateServo <= 10'd430;	//return the head to the default position
				if(pause >= 140000000)	//wait for 2.8 seconds
					begin
					pause <= 28'd0;	//reset the wait
					state <= mouth;	//change state to the first head movement
					end
				else
					begin
					pause <= pause + 1'b1;	//increase pause by one for the 7 second delay
					state <= rotateThree;	//keep the state the same
					end
				end
			endcase
	end
endmodule