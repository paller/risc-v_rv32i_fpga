module imem (
    input logic clk,
    input  logic [31:0] pc,
    output logic [31:0] data
);

  logic [31:0] instruction_memory[2048];

  always_ff @(posedge clk) begin
      data <= instruction_memory[pc[31:2]];
  end

  initial begin
    $display("Loading imem");
    $readmemh("../src/rv32_0.0.1/test/software/programs/test.mem", instruction_memory);
  end

endmodule
