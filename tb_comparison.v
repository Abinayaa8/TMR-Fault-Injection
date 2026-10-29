
`timescale 1ns/1ps

module tb_comparison;

reg clk;
reg reset;
reg [7:0] din;

wire [7:0] baseline_acc;
wire [7:0] tmr_acc;

tmr_design baseline (
    .clk(clk),
    .reset(reset),
    .din(din),
    .acc(baseline_acc)
);

tmr_protected protected_design (
    .clk(clk),
    .reset(reset),
    .din(din),
    .acc(tmr_acc)
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

    $display("Before fault: Baseline=%d, TMR=%d",
             baseline_acc, tmr_acc);

    force baseline.acc = 8'd136;
    force protected_design.acc_c = 8'd136;

    #1;

    $display("During fault: Baseline=%d, TMR=%d",
             baseline_acc, tmr_acc);

    release baseline.acc;
    release protected_design.acc_c;

    din = 8'd2;
    #10;

    $display("After fault: Baseline=%d, TMR=%d",
             baseline_acc, tmr_acc);

    $finish;
end

initial begin
    $dumpfile("comparison_wave.vcd");
    $dumpvars(0, tb_comparison);
end

endmodule
