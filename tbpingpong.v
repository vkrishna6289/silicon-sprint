`timescale 1ns/1ps

module tb_ping_pong;

parameter WIDTH = 8;
parameter DEPTH = 8;

reg clk;
reg reset;
reg write_en;
reg read_en;
reg [WIDTH-1:0] data_in;

wire [WIDTH-1:0] data_out;


// expected output queue
reg [WIDTH-1:0] expected_mem [0:255];

integer write_index;
integer read_index;
integer errors;


// DUT
ping_pong_top #(WIDTH,DEPTH) dut (
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .read_en(read_en),
    .data_in(data_in),
    .data_out(data_out)
);


// Clock generation
always #5 clk = ~clk;



// Test sequence
initial begin

clk = 0;
reset = 1;
write_en = 0;
read_en = 0;
data_in = 0;

write_index = 0;
read_index = 0;
errors = 0;

#20
reset = 0;

write_en = 1;
read_en = 1;


// generate input data
repeat(40)
begin

@(posedge clk)

data_in = $random;

expected_mem[write_index] = data_in;
write_index = write_index + 1;

end


#100


if(errors == 0)
    $display("TEST PASSED");
else
    $display("TEST FAILED WITH %0d ERRORS", errors);

$finish;

end



// Output checking
always @(posedge clk)
begin

if(read_en)
begin

if(data_out !== expected_mem[read_index])
begin

$display("ERROR at time %0t Expected=%0d Got=%0d",
         $time,
         expected_mem[read_index],
         data_out);

errors = errors + 1;

end

read_index = read_index + 1;

end

end

endmodule
