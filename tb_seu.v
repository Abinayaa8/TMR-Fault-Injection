
`timescale 1ns/1ps

module tb_seu;

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

    $display("Before fault: acc = %d", acc);

    force dut.acc = 8'd136;
    #1;
    release dut.acc;

    $display("After fault: acc = %d", acc);

    din = 8'd2;
    #10;

    $display("Final acc = %d", acc);

    $finish;
end

initial begin
    $dumpfile("seu_wave.vcd");
    $dumpvars(0, tb_seu);
end

endmodule
