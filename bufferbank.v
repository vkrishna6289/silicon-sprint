module buffer_bank #(parameter WIDTH=8, DEPTH=8)(
    input clk,
    input write_en,
    input read_en,

    input [2:0] w_addr,
    input [2:0] r_addr,

    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

reg [WIDTH-1:0] mem [0:DEPTH-1];

always @(posedge clk)
begin
    if(write_en)
        mem[w_addr] <= data_in;

    if(read_en)
        data_out <= mem[r_addr];
end

endmodule
