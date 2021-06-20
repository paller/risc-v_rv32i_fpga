//module ram(din, we, addr, clk, dout);
module imem (
    input logic clk,
    input logic  [31:0] data_in,
    input logic         we,
    input  logic [31:0] pc,
    output logic [31:0] data
);

  logic [31:0] instruction_memory[64];

  always_ff @(posedge clk) begin
    if (we)
      instruction_memory[pc] <= data_in;
    else
      data <= instruction_memory[pc[31:2]];
  end

  initial begin
    $display("Loading imem");
    //$readmemh("../src/erv_0.0.1/test/software/add_test.mem", instruction_memory);
  end

endmodule
