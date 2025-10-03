
module display_stopwatch(
    input wire [3:0] sec_one, //units of seconds
    input wire [3:0] sec_ten, //ten digits of seconds
    input wire [3:0] min_one, //units of minutes
    input wire [3:0] min_ten, //ten digits of minutes
    input wire [3:0] hour_one, //units of hours
    input wire [3:0] hour_ten,//ten digits of hours
    output wire [6:0] led_0, // led connect to units of seconds
    output wire [6:0] led_1, // led connect to ten digits of seconds
    output wire [6:0] led_2,  // led connect to units of minites
    output wire [6:0] led_3, // led connect to ten digits of minites
    output wire [6:0] led_4, // led connect to units of hours
    output wire [6:0] led_5 // led connect to ten digits of hours
    );
    
   //connect to led   
   seven_segment Led_0(.digit(sec_one),.segments(led_0));
   seven_segment Led_1(.digit(sec_ten),.segments(led_1));
   seven_segment Led_2(.digit(min_one),.segments(led_2));
   seven_segment Led3(.digit(min_ten),.segments(led_3));
   seven_segment Led4(.digit(hour_one),.segments(led_4));
   seven_segment Led5(.digit(hour_ten),.segments(led_5));
   
endmodule
