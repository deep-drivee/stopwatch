module stopwatch (
    input wire clk,
    input wire reset,        // Async reset
    input wire start_stop,   // Toggle start/pause
    input wire clr,          // Clear stopwatch
    output reg [3:0] sec_ones,
    output reg [3:0] sec_tens,
    output reg [3:0] min_ones,
    output reg [3:0] min_tens
);

    reg running = 0;
    reg [25:0] counter = 0;  // For simulation: use small value (like 10)
    parameter TICK_COUNT = 10; // Set to 50_000_000 for 1s @ 50 MHz

    // Internal logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sec_ones  <= 0;
            sec_tens  <= 0;
            min_ones  <= 0;
            min_tens  <= 0;
            counter   <= 0;
            running   <= 0;
        end else begin
            // Toggle start/pause
            if (start_stop)
                running <= ~running;

            // Clear stopwatch
            if (clr) begin
                sec_ones <= 0;
                sec_tens <= 0;
                min_ones <= 0;
                min_tens <= 0;
                counter  <= 0;
            end

            // Only increment time when running
            if (running) begin
                counter <= counter + 1;

                if (counter == TICK_COUNT) begin
                    counter <= 0;

                    // BCD increment logic
                    if (sec_ones < 9)
                        sec_ones <= sec_ones + 1;
                    else begin
                        sec_ones <= 0;
                        if (sec_tens < 5)
                            sec_tens <= sec_tens + 1;
                        else begin
                            sec_tens <= 0;
                            if (min_ones < 9)
                                min_ones <= min_ones + 1;
                            else begin
                                min_ones <= 0;
                                if (min_tens < 9)
                                    min_tens <= min_tens + 1;
                                else
                                    min_tens <= 0; // rolls over at 99:59
                            end
                        end
                    end

                    // Print to console for simulation
                    $display("MM:SS -> %d%d:%d%d", min_tens, min_ones, sec_tens, sec_ones);
                end
            end
        end
    end
endmodule
