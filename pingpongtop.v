module ping_pong_top #(parameter WIDTH=8, DEPTH=8)(
    input clk,
    input reset,
    input write_en,
    input read_en,
    input [WIDTH-1:0] data_in,
    output [WIDTH-1:0] data_out
);

wire bank_sel;
wire swap_done;

wire [2:0] w_ptr;
wire [2:0] r_ptr;

wire [WIDTH-1:0] data_out0;
wire [WIDTH-1:0] data_out1;

controller ctrl(
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .read_en(read_en),
    .bank_sel(bank_sel),
    .swap_done(swap_done),
    .w_ptr(w_ptr),
    .r_ptr(r_ptr)
);

buffer_bank #(WIDTH,DEPTH) bank0(
    .clk(clk),
    .write_en(write_en && (bank_sel==0)),
    .read_en(read_en && (bank_sel==1)),
    .w_addr(w_ptr),
    .r_addr(r_ptr),
    .data_in(data_in),
    .data_out(data_out0)
);

buffer_bank #(WIDTH,DEPTH) bank1(
    .clk(clk),
    .write_en(write_en && (bank_sel==1)),
    .read_en(read_en && (bank_sel==0)),
    .w_addr(w_ptr),
    .r_addr(r_ptr),
    .data_in(data_in),
    .data_out(data_out1)
);

assign data_out = (bank_sel==0) ? data_out1 : data_out0;

endmodule
