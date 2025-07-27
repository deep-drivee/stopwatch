`timescale 1ns/1ps

module tb_stopwatch;

    reg clk = 0;
    reg reset = 0;
    reg start_stop = 0;
    reg clr = 0;

    wire [3:0] sec_ones, sec_tens, min_ones, min_tens;

    // Instantiate the stopwatch module
    stopwatch uut (
        .clk(clk),
        .reset(reset),
        .start_stop(start_stop),
        .clr(clr),
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .min_ones(min_ones),
        .min_tens(min_tens)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Toggle start_stop signal (for 1 clock pulse)
    task pulse_start_stop;
        begin
            start_stop = 1;
            @(posedge clk);
            start_stop = 0;
        end
    endtask

    // Pulse clr
    task pulse_clr;
        begin
            clr = 1;
            @(posedge clk);
            clr = 0;
        end
    endtask

    // Wait for N ticks
    task wait_ticks(input integer count);
        integer i;
        begin
            for (i = 0; i < count; i = i + 1)
                @(posedge clk);
        end
    endtask

    // Display current time in MM:SS
    task show_time;
        begin
            $display("MM:SS ->  %0d%0d:%0d%0d", min_tens, min_ones, sec_tens, sec_ones);
        end
    endtask

    initial begin
        $display("=== Stopwatch Full Test Start ===");

        // Initial reset
        reset = 1;
        wait_ticks(2);
        reset = 0;
        $display("Reset complete");
        show_time();

        // Start stopwatch
        pulse_start_stop;
        $display("Stopwatch started");

        // Wait for 70 ticks = 7 simulated seconds (as TICK_COUNT = 10)
        wait_ticks(70);
        show_time();

        // Pause stopwatch
        pulse_start_stop;
        $display("Stopwatch paused");
        wait_ticks(10);
        show_time();

        // Resume
        pulse_start_stop;
        $display("Stopwatch resumed");

        // Wait till 2 minutes = 2×60 = 1200 seconds → 1200 ticks
        wait_ticks(1200);
        show_time();

        // Clear during run
        pulse_clr;
        $display("Stopwatch cleared");
        show_time();

        // Confirm counting starts again
        wait_ticks(20);
        show_time();

        // Pause and reset
        pulse_start_stop; // pause
        reset = 1;
        wait_ticks(2);
        reset = 0;
        $display("Stopwatch reset");
        show_time();

        $display("=== Stopwatch Test Complete ===");
        $finish;
    end

endmodule
