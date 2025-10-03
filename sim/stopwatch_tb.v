`timescale 1ns / 1ns

module stopwatch_tb;
//input
reg clk;
reg stopwatch_button;
reg start;
reg reset;
//output
 wire [6:0] led_0; // led connect to units of seconds
 wire [6:0] led_1; // led connect to ten digits of seconds
 wire [6:0] led_2;  // led connect to units of minites
 wire [6:0] led_3; // led connect to ten digits of minites
 wire [6:0] led_4; // led connect to units of hours
 wire [6:0] led_5; // led connect to ten digits of hours

stopwatch #(10) uut(.clk(clk), // set to 10 to facilitate easier testing
                    .stopwatch_button(stopwatch_button),
                    .start(start),.reset_clk(reset),
                    .led_0(led_0),
                    .led_1(led_1),
                    .led_2(led_2),
                    .led_3(led_3),
                    .led_4(led_4),
                    .led_5(led_5)
                    );


initial begin
    clk = 0;
    forever #4 clk = ~clk; 
    end
    initial begin
        stopwatch_button <= 0; // do other jobs
        start <= 0;
        reset<=1;
        #4 reset <=0; 
        #4 stopwatch_button <= 1;
        #100 start <= 1; //press button to count
        #20 start <= 0; //release button
        #100_000
        start <= 1; //press button to stop
        #20 start <= 0; //release button
        #1_000 start <= 1; //press button to continue if current time les than 1 hour
        #20 start <= 0; //release button
        #100_000 stopwatch_button <= 0; //do other
        #200 $stop;
    end
endmodule
