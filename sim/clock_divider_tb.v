`timescale 1ns / 1ps

// Declare the testbench module
module clock_divider_tb;
    reg clk;        // Clock signal
    reg reset;      // Reset signal
    wire clk_out;   // Output clock signal from the clock divider

    // Instantiate the clock_divider module
    clock_divider #(100) uut ( // set to 100 to facilitate easier testing
        .clk(clk),
        .reset(reset),
        .clk_out(clk_out)
    );

    // Generate a clock signal with a frequency of 125MHz (period of 8ns)
    always begin
        forever #4 clk = ~clk;
    end

    // Initialize signals and run the test
    initial begin
        clk = 0;       // Initialize the clock to 0
        reset = 1;     // Start with reset active
        #10            // Wait for 10ns
        reset = 0;     // Deactivate reset
        #50_000;       // Run simulation for 50,000ns
        $stop;         // Stop the simulation
    end

endmodule
