module alu
  import rv::*;
(
    input logic [31:0] op1,
    input logic [31:0] op2,
    input RV32_ALU_OPCODE opcode,
    output logic [31:0] result
);

  always_comb begin
    unique case (opcode)
      ALU_ADD:  result = op1 + op2;
      ALU_SLL:  result = op1 << op2[4:0];
      ALU_SLT:  result = {31'b0, $signed(op1) < $signed(op2)};
      ALU_SLTU: result = {31'b0, op1 < op2};
      ALU_XOR:  result = op1 ^ op2;
      ALU_SRx:  result = op1 >> op2[4:0];
      ALU_OR:   result = op1 | op2;
      ALU_AND:  result = op1 & op2;
      default:  result = 'x;
    endcase
  end

endmodule
