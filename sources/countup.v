

module countup(
    input clk, //clk_10Hz
    input reset, //mode
    input click, // click to up
    output reg[3:0] sec_one, //units of seconds
    output reg[3:0] sec_ten, //ten digits of seconds
    output reg[3:0] min_one, //units of minutes
    output reg[3:0] min_ten, //ten digits of minutes
    output reg[3:0] hour_one, //units of hours
    output reg[3:0] hour_ten, //ten degits of hours
    //Flip_flop
    reg stop, 
    reg[3:0] mili_sec,
    reg click_0
    );

   
    initial begin
        sec_one = 4'd0;
        sec_ten = 4'd0;
        min_one = 4'd0;
        min_ten = 4'd0;
        hour_one = 4'd0;
        hour_ten = 4'd0;
        mili_sec = 4'd0;
    end
    
    
    //count up to 01:00:00
    always @(posedge clk or posedge reset or posedge click) begin
        click_0 <= click;
        if (reset) begin
            sec_one <= 0;
            sec_ten <= 0;
            min_one <= 0;
            min_ten <= 0;
            hour_one <= 0;
            hour_ten <= 0;
            mili_sec <= 0;
            stop <= 1;
        end else if (click_0 & stop & click) begin
            if (mili_sec == 9 && sec_one <9) begin //sec + 1 when milisec = 9   sec + 1
                mili_sec <= 0;
                sec_one <= sec_one + 4'd1;
                sec_ten <= sec_ten;
                min_one <= min_one;
                min_ten <= min_ten;
                hour_one <= hour_one;
                hour_ten <= 0;
                end
                
            else if (mili_sec == 9 && sec_one == 9 && sec_ten < 5) begin 
                mili_sec <= 0;
                sec_one <= 0;
                sec_ten <= sec_ten + 4'd1;
                min_one <= min_one;
                min_ten <= min_ten;
                hour_one <= hour_one;
                hour_ten <= 0;
                end
            else //min +1 when milisec = 9 & sec = 59 
            if (mili_sec == 9 && sec_one == 9 && sec_ten == 5 && min_one < 9) begin 
                mili_sec <= 0;
                sec_one <= 0;
                sec_ten <= 0;
                min_one <= min_one + 4'd1;
                min_ten <= min_ten;
                hour_one <= hour_one;
                hour_ten <= 0;
                end
                
            else          
            if (mili_sec == 9 && sec_one == 9 && sec_ten == 5 && min_one == 9 && min_ten < 5) begin
                mili_sec <= 0;
                sec_one <= 0;
                sec_ten <= 0;
                min_one <= 0;
                min_ten <= (min_ten + 4'd1);
                hour_one <= hour_one;
                hour_ten <= 0;
                end
                
            else //hour + 1 when milisec = 9 & sec = 59 & min = 59 
            if (mili_sec == 4'd9 && sec_one == 4'd9 && sec_ten == 4'd5 && min_one == 4'd9 && min_ten == 4'd5 && hour_one < 4'd1) begin 
                sec_one <= 0;
                sec_ten <= 0;
                min_one <= 0;
                min_ten <= 0;
                hour_one <= hour_one + 4'd1;
                hour_ten <= 0;
                end
                
            else // stop at 01:00:00
            if (hour_one == 4'd1) begin 
                mili_sec <= 0;
                sec_one <= 0;
                sec_ten <= 0;
                min_one <= 0;
                min_ten <= 0;
                hour_one <= 4'd1;
                hour_ten <= 0;
                stop <= 0;
                end
               
                
            else begin
                mili_sec <= mili_sec + 4'd1;
               sec_one <= sec_one;
                sec_ten <= sec_ten;
                min_one <= min_one;
                min_ten <= min_ten;
                hour_one <= hour_one;
                hour_ten <= 0;
                end
               
                
        end //stop counting when click = 0 or stop = 0
        else begin
            mili_sec <= mili_sec;
            sec_one <= sec_one;
            sec_ten <= sec_ten;
            min_one <= min_one;
            min_ten <= min_ten;
            hour_one <= hour_one;
            hour_ten <= 0;
           
        end
   end
   
endmodule
