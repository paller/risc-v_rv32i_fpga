module decoder
  import rv::*;
(
    input  logic           [31:0] instruction,
    output logic           [ 4:0] rs1,
    output logic           [ 4:0] rs2,
    output logic           [ 4:0] rd,
    output logic           [31:0] imm,
    output RV32_ALU_OPCODE        funct3,
    output RV32_INSTRUCTION_OPCODE opcode
);

  // Extract fields
  assign rd = instruction[11:07];
  assign rs1 = instruction[19:15];
  assign rs2 = instruction[24:20];
  assign funct3 = RV32_ALU_OPCODE'(instruction[14:12]);
  assign opcode = RV32_INSTRUCTION_OPCODE'(instruction[6:0]);

  // Immediates for I, S, kB, U and J instructions
  // verilog_format: off
  wire [31:0] imm_i = {{11{instruction[31]}}, instruction[30:20]};
  wire [31:0] imm_s = {{11{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]};
  wire [31:0] imm_b = {{10{instruction[31]}}, instruction[30:25], instruction[11:8], 1'b0};
  wire [31:0] imm_u = {instruction[31],       instruction[30:12], 12'd0};
  wire [31:0] imm_j = {instruction[31],       instruction[19:12], instruction[20],   instruction[30:21], 1'b0};
  // verilog_format: on

  // Instruction type
  // TODO: Update arrays
  wire is_i_instr = opcode inside {IMM, JALR, LOAD};
  wire is_r_instr = opcode inside {ARITHMETIC};
  wire is_u_instr = opcode inside {LUI, AUIPC};
  wire is_s_instr = opcode inside {STORE};
  wire is_b_instr = opcode inside {BRANCH};
  wire is_j_instr = opcode inside {JAL};

  // Using unique-case will produce a warning
  // under simulation if more than one is active.
  always_comb begin
    unique0 case (1'b1)
      is_i_instr: imm = imm_i;
      is_u_instr: imm = imm_u;
      is_s_instr: imm = imm_s;
      is_b_instr: imm = imm_b;
      is_j_instr: imm = imm_j;
      is_r_instr: imm = 'x;
    endcase
  end

endmodule
