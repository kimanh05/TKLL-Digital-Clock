`timescale 1ns / 1ps

module count_up_tb;
    //Input
    reg clk;
    reg reset;
    reg click;
    //Output
    wire [3:0] sec_one; //units of seconds
    wire[3:0] sec_ten; //ten digits of seconds
    wire[3:0] min_one; //units of minutes
    wire[3:0] min_ten; //ten digits of minutes
    wire[3:0] hour_one; //units of hours
    wire[3:0] hour_ten; //ten digits of hours
    
    countup uut(.clk(clk),
                .reset(reset),
                .click(click),
                .sec_one(sec_one),
                .sec_ten( sec_ten),
                .min_one( min_one),
                .min_ten( min_ten),
                .hour_one( hour_one),
                .hour_ten( hour_ten));
    
    initial begin
    clk = 0;
    forever #4 clk = ~clk;
    end
    initial begin
        reset <= 1; //reset to 00:00:00
        click <= 0; 
        #4 reset <=0; 
        #2 click <= 1; //start counting up
        #2000 click <= 0; //stop counting
        #8 $stop;
    end
endmodule
