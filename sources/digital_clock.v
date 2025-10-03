
module digital_clock(
    input clk,
    input reset,
    input [1:0] clock_mode,
    input set_time,
    input set,
    input up,
    input start,
    output reg [6:0] hrs_tens,
    output reg [6:0] hrs_ones,
    output reg [6:0] min_tens,
    output reg [6:0] min_ones,
    output reg [6:0] ampm1,
    output reg [6:0] ampm0,
    output wire clock_mode_led
);

    // Constants for clock modes
    parameter DISPLAY_TIME = 2'b00;
    parameter SET_TIME = 2'b01;
    parameter STOPWATCH = 2'b10;
    parameter COUNTDOWN = 2'b11;
    
    parameter CLK_DIVIDER = 125_000_000;

    // Internal registers for current mode and time
    reg [4:0] hrs;
    reg [5:0] min;
    reg [5:0] sec;
    reg am_pm;
    wire divided_clk;
    
    // Wires for submodules
    wire [6:0] set_hrs1, set_hrs0, set_min1, set_min0;
    wire [6:0] set_am_pm1, set_am_pm0;
    wire [6:0] dp_hrs1, dp_hrs0, dp_min1, dp_min0;
    wire [6:0] dp_am_pm1, dp_am_pm0;
    wire [6:0] sw_hrs1, sw_hrs0, sw_min1, sw_min0, sw_sec1, sw_sec0;
    wire [6:0] cd_hrs1, cd_hrs0, cd_min1, cd_min0, cd_sec1, cd_sec0;

    // Instantiate set_time submodule
    set_time_module set_time_inst (
        .clk(clk),
        .set_time(set_time),
        .set(set),
        .up(up),
        .hour1(set_hrs1),
        .hour0(set_hrs0),
        .min1(set_min1),
        .min0(set_min0),
        .ampm1(set_am_pm1),
        .ampm0(set_am_pm0)
    );
    // Instantiate display submodule
    display display_inst(
    .hours(hrs),
    .minutes(min),
    .am_pm(am_pm),
    .hour1(dp_hrs1),
    .hour0(dp_hrs0),
    .min1(dp_min1),
    .min0(dp_min0),
    .ampm1(dp_am_pm1),
    .ampm0(dp_am_pm0)
    );

    // Instantiate stopwatch submodule
    stopwatch #(CLK_DIVIDER/10) stopwatch_inst (
        .clk(clk),
        .stopwatch_button(clock_mode[1] & ~clock_mode[0]),
        .start(start),
	    .reset_clk(reset),
        .led_5(sw_hrs1),
        .led_4(sw_hrs0),
        .led_3(sw_min1),
        .led_2(sw_min0),
        .led_1(sw_sec1),
        .led_0(sw_sec0)
    );

    // Instantiate countdown submodule
    countdown #(CLK_DIVIDER) countdown_inst (
        .clk(clk),
        .set_time(set_time),
        .set(set),
        .up(up),
        .reset(reset),
        .hour_1(cd_hrs1),
        .hour_0(cd_hrs0),
        .min_1(cd_min1),
        .min_0(cd_min0),
        .sec_1(cd_sec1),
        .sec_0(cd_sec0)
    );
    
    // Instantiate clock_divider submodule
    clock_divider #(CLK_DIVIDER) clk_div_inst (
    .clk(clk),
    .reset(reset),
    .clk_out(divided_clk)
    );
   
    initial begin
    hrs= 5'd12;    // Default is 12:00:AM
    min= 6'd0;  
    sec = 6'd0;
    am_pm = 1'b0; 
    end

    // State machine for mode selection and time updating
    always @(posedge divided_clk or posedge reset or clock_mode or up or posedge start) begin
            case (clock_mode)
                DISPLAY_TIME: begin
                    if (sec == 6'd59) begin
                        sec <= 6'd0;
                        if (min == 6'd59) begin
                            min <= 6'd0;
                            if (hrs == 5'd11) begin
                                hrs <= 5'd12;
                                am_pm <= ~am_pm;
                            end else if (hrs == 5'd12) begin
                                hrs <= 5'd1;
                            end else begin
                                hrs <= hrs + 1;
                            end
                        end else begin
                            min <= min + 1;
                        end
                    end else begin
                        sec <= sec + 1;
                    end
                    // Update time based on display submodule outputs
                    hrs_tens <= dp_hrs1;
                    hrs_ones <= dp_hrs0;
                    min_tens <= dp_min1;
                    min_ones <= dp_min0;
                    ampm1 <= dp_am_pm1;
                    ampm0 <= dp_am_pm0;
                end

                SET_TIME: begin
                    // Update time based on set_time submodule outputs
                    hrs_tens <= set_hrs1;
                    hrs_ones <= set_hrs0;
                    min_tens <= set_min1;
                    min_ones <= set_min0;
                    ampm1 <= set_am_pm1;
                    ampm0 <= set_am_pm0;
                end

                STOPWATCH: begin
                    // Update time based on stopwatch submodule outputs
                    hrs_tens <= sw_hrs1;
                    hrs_ones <= sw_hrs0;
                    min_tens <= sw_min1;
                    min_ones <= sw_min0;
                    ampm1 <= sw_sec1;
                    ampm0 <= sw_sec0;
                end

                COUNTDOWN: begin
                    // Update time based on countdown submodule outputs
                    hrs_tens <= cd_hrs1;
                    hrs_ones <= cd_hrs0;
                    min_tens <= cd_min1;
                    min_ones <= cd_min0;
                    ampm1 <= cd_sec1;
                    ampm0 <= cd_sec0;
                end
            endcase
        end

    // Assign clock_mode_led based on current mode
    assign clock_mode_led = !(clock_mode == DISPLAY_TIME);
endmodule
