module alu
  import rv::*;
(
    input logic [31:0] op1,
    input logic [31:0] op2,
    input logic [31:0] imm, // Replace with mux
    input RV32_INSTRUCTION opcode,
    output logic [31:0] result
);

  always_comb begin
    unique casex(opcode)
      ADD: result = op1 + op2;
      ADDI: result = op1 + imm;
      default: result = 'x;
    endcase 
    $display("op %d, op1 %d, imm %d and res %d vs %d",
      opcode, op1, imm, result, op1 + imm);
  end

endmodule
