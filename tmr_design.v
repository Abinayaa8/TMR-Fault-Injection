
module tmr_design (
    input wire clk,
    input wire reset,
    input wire [7:0] din,
    output reg [7:0] acc
);

always @(posedge clk) begin
    if (reset)
        acc <= 8'b00000000;
    else
        acc <= acc + din;
end

endmodule
