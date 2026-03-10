module controller #(parameter DEPTH=8)(
    input clk,
    input reset,
    input write_en,
    input read_en,

    output reg bank_sel,
    output reg swap_done,

    output reg [2:0] w_ptr,
    output reg [2:0] r_ptr
);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        w_ptr <= 0;
        r_ptr <= 0;
        bank_sel <= 0;
        swap_done <= 0;
    end

    else
    begin

        swap_done <= 0;

        if(write_en)
            w_ptr <= w_ptr + 1;

        if(read_en)
            r_ptr <= r_ptr + 1;

        if(w_ptr == DEPTH-1)
        begin
            bank_sel <= ~bank_sel;
            w_ptr <= 0;
            r_ptr <= 0;
            swap_done <= 1;
        end

    end
end

endmodule
