
module stopwatch(
    input clk, //125MHz
    input stopwatch_button, //(clock_mode[1] & ~clock_mode[0])
    input start, 
    input reset_clk,
    output wire [6:0] led_0, // led connect to units of seconds
    output wire [6:0] led_1, // led connect to ten digits of seconds
    output wire [6:0] led_2,  // led connect to units of minites
    output wire [6:0] led_3, // led connect to ten digits of minites
    output wire [6:0] led_4, // led connect to units of hours
    output wire [6:0] led_5, // led connect to ten digits of hours
    wire clk_1Hz, //clock_divider
    //Intermediate wire for BCD conversion
    wire [3:0] sec_one,
    wire [3:0] sec_ten,
    wire [3:0] min_one,
    wire [3:0] min_ten,
    wire [3:0] hour_one,
    wire[3:0] hour_ten,
    // flip_flop for control mode
    reg store_start,
    reg store_sw_btn,
    reg click,
    reg reset
    );
    
    //clock_divider 1Hz
    parameter CLK_DIVIDER = 125_000_000;
    clock_divider #(CLK_DIVIDER) clk_div(.clk(clk),
                                         .reset(reset_clk),
                                         .clk_out(clk_1Hz));
    
    //start/stop controller     
    always @(posedge clk) begin
        if (stopwatch_button) begin
            store_sw_btn <= stopwatch_button;
            store_start <= start;
            click <= (start & ~store_start)^click;           
            if (stopwatch_button & ~store_sw_btn) //rise edge of stopwatch_button
                reset <= 1'b1;
            else reset <= 1'b0;
        end else begin
            store_sw_btn <= 0;
            reset <= 1;
            store_start <= 0;
            click <= 0;
        end
    end
     
   //countup
   countup stopwatch_01(.clk(clk_1Hz),
                        .reset(reset),
                        .click(click),
                        .sec_one(sec_one),
                        .sec_ten(sec_ten),
                        .min_one(min_one),
                        .min_ten(min_ten),
                        .hour_one(hour_one),
                        .hour_ten(hour_ten));
   
   //display
   display_stopwatch stopwatch_02(.sec_one(sec_one),
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

endmodule
