
module tmr_protected (
    input wire clk,
    input wire reset,
    input wire [7:0] din,
    output wire [7:0] acc
);

(* keep = "true" *) reg [7:0] acc_a;
(* keep = "true" *) reg [7:0] acc_b;
(* keep = "true" *) reg [7:0] acc_c;
wire [7:0] voted_acc;

assign voted_acc =
    (acc_a & acc_b) |
    (acc_b & acc_c) |
    (acc_a & acc_c);

always @(posedge clk) begin
    if (reset) begin
        acc_a <= 8'd0;
        acc_b <= 8'd0;
        acc_c <= 8'd0;
    end
    else begin
        acc_a <= voted_acc + din;
        acc_b <= voted_acc + din;
        acc_c <= voted_acc + din;
    end
end

assign acc = voted_acc;

endmodule
