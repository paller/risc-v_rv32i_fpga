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
      ALU_SLL:  res = rs1 << rs2[4:0];
      ALU_SRL:  res = rs1 >> rs2[4:0];
      ALU_SRA:  res = $signed(rs1) >>> rs2[4:0];
      ALU_ADD:  res = rs1 + rs2;
      ALU_SUB:  res = rs1 - rs2;
      ALU_XOR:  res = rs1 ^ rs2;
      ALU_OR:   res = rs1 | rs2;
      ALU_AND:  res = rs1 & rs2;
      ALU_SLT:  res = {31'b0, $signed(rs1) < $signed(rs2)};
      ALU_SLTU: res = {31'b0, rs1 < rs2};
      ALU_SBT:  res = {31'b0, $signed(rs1) >= $signed(rs2)};
      ALU_SBTU: res = {31'b0, rs1 >= rs2};
      ALU_EQ:   res = {31'b0, rs1 == rs2};
      ALU_NEQ:  res = {31'b0, rs1 != rs2};
      default:  res = 'x;
    endcase
  end

endmodule
