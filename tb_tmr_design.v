
`timescale 1ns/1ps

module tb_tmr_design;

reg clk;
reg reset;
reg [7:0] din;
wire [7:0] acc;

tmr_design dut (
    .clk(clk),
    .reset(reset),
    .din(din),
    .acc(acc)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    din = 0;

    #10;
    reset = 0;

    din = 8'd5;
    #10;

    din = 8'd3;
    #10;

    din = 8'd2;
    #10;

    $finish;
end

initial begin
    $monitor("Time=%0t reset=%b din=%d acc=%d",
             $time, reset, din, acc);
end

initial begin
    $dumpfile("tmr_wave.vcd");
    $dumpvars(0, tb_tmr_design);
end

endmodule
