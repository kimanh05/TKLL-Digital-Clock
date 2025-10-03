`timescale 1ns / 1ps

module display_stopwatch_tb;
    //input
    reg [3:0] sec_one;
    reg [3:0] sec_ten;
    reg [3:0] min_one;
    reg [3:0] min_ten;
    reg [3:0] hour_one;
    reg [3:0] hour_ten;
    //output
    wire [6:0] led_0;
    wire [6:0] led_1;
    wire [6:0] led_2;
    wire [6:0] led_3;
    wire [6:0] led_4;
    wire [6:0] led_5;
    
    display_stopwatch uut (.sec_one(sec_one),
                            .sec_ten(sec_ten),
                            .min_one(min_one),
                            .min_ten(min_ten),
                            .hour_one(hour_one),
                            .hour_ten(hour_ten),
                            .led_0(led_0),
                            .led_1(led_1),
                            .led_2(led_2),
                            .led_3(led_3),
                            .led_4(led_4),
                            .led_5(led_5));
    initial begin
        sec_one = 4'b0000;
        sec_ten = 4'b0000;
        min_one = 4'b0000;
        min_ten = 4'b0000;
        hour_one = 4'b0000;
        hour_ten = 4'b0000;
        #20
        sec_one = 4'b0000;
        sec_ten = 4'b0100;
        min_one = 4'b1000;
        min_ten = 4'b0001;
        hour_one = 4'b1001;
        hour_ten = 4'b0010;
        #20 $stop;
    end 
endmodule
