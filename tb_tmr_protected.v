
`timescale 1ns/1ps

module tb_tmr_protected;

reg clk;
reg reset;
reg [7:0] din;
wire [7:0] acc;

tmr_protected dut (
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

    force dut.acc_a = 8'd136;
    #1;
    $display("After fault in A: acc = %d", acc);
    release dut.acc_a;

    din = 8'd2;
    #10;

    $display("After recovery: acc = %d", acc);

    if (acc == 8'd10)
        $display("PASS: TMR masked the single-register fault.");
    else
        $display("FAIL: Expected acc = 10, got %d", acc);

    $finish;
end

initial begin
    $dumpfile("tmr_protected_wave.vcd");
    $dumpvars(0, tb_tmr_protected);
end

endmodule
