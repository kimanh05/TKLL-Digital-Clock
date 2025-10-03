module time_counter(
   input wire clk,             // Clk
    input wire set_time,       // SetTime button
    input wire up,             // Up button
    input wire set,            // Set button
    output reg [4:0] hours,    // Hours
    output reg [5:0] minutes,  // Minutes
    output reg am_pm           // AM/PM 
);
reg up_prev ;
initial begin
    hours = 5'd12;    // Default is 12:00:AM
    minutes = 6'd0;  
    am_pm = 1'b0;    
    up_prev = 1'b0;
end
always @(up) begin
 up_prev <= up;
 end
 always @(up or set or set_time) begin
    if (up && !up_prev) begin
        if (set_time == 1'b0 && set == 1'b1) begin
            // Adjusting hours
            case (hours)
            5'd11:  begin
                hours = 5'd0; // Wrap around to 12 hours
                am_pm = ~am_pm; // Toggle AM/PM
            end 
            5'd23: begin
                hours = 5'd1; //  Wrap around to 1 hour of the next day
            end 
            default: begin
                hours = hours + 1; //Increment hours
            end
            endcase
        end else if (set_time == 1'b1 && set == 1'b0) begin
           // Adjusting minutes
            case(minutes)
            6'd59: begin
                minutes = 6'd0;
                case (hours)
                5'd11: begin
                    hours = 5'd0; //  If at 11:59, adjust hours and toggle AM/PM
                    am_pm = ~am_pm; // Toggle AM/PM
                end 
                5'd23: begin
                    hours = 5'd1; // If at 23:59, switch to 1 hour in 12-hour format
                end 
                default: begin
                    hours = hours + 1; // Increment hours
                end
                endcase
            end 
            default: begin
                minutes = minutes + 1; // Increment minutes
            end
            endcase
        end else if (set_time == 1'b1 && set == 1'b1) begin
            // Toggle AM/PM
            am_pm = ~am_pm;
        end
    end
end
endmodule