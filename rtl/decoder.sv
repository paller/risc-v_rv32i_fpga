module decoder
  import rv::*;
(
    input  logic            [31:0] instruction,
    output logic            [ 4:0] rs1,
    output logic            [ 4:0] rs2,
    output logic            [ 4:0] rd,
    output logic                   rd_we,
    output logic            [31:0] imm,
    output RV32_INSTRUCTION        alu_opcode
);


  // Extract fields
  assign rd  = instruction[11:07];
  assign rs1 = instruction[19:15];
  assign rs2 = instruction[24:20];
  wire [4:0] opcode = instruction[06:02];
  wire [2:0] funct3 = instruction[14:12];
  wire [6:0] funct7 = instruction[31:25];

  // Instruction type
  wire is_i_instr = opcode inside {5'b00000, 5'b00001, 5'b00100, 5'b00110, 5'b11001};
  wire is_r_instr = opcode inside {5'b01011, 5'b01100, 5'b01110, 5'b10100};
  wire is_u_instr = opcode inside {5'b00101, 5'b01101};
  wire is_s_instr = opcode inside {5'b01000, 5'b01001};
  wire is_b_instr = opcode inside {5'b11000};
  wire is_j_instr = opcode inside {5'b11011};

  // Valid fields
  wire rd_valid = (is_r_instr || is_i_instr || is_u_instr || is_j_instr);
  wire rs1_valid = (is_r_instr || is_i_instr || is_s_instr || is_b_instr);
  wire rs2_valid = (is_r_instr || is_s_instr || is_b_instr);
  wire imm_valid = !is_r_instr;
  wire funct3_valid = rs1_valid;
  wire funct7_valid = is_r_instr;

  always_comb begin
    rd_we = rd_valid;
  end

  // Immediates for I, S, B, U and J instructions
  wire [31:0] imm_i = {{11{instruction[31]}}, instruction[30:20]};
  wire [31:0] imm_s = {
    {11{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]
  };
  wire [31:0] imm_b = {{10{instruction[31]}}, instruction[30:25], instruction[11:8], 1'b0};
  wire [31:0] imm_u = {instruction[31], instruction[30:12], 12'd0};
  wire [31:0] imm_j = {
    instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0
  };

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

  assign alu_opcode = RV32_INSTRUCTION'({instruction[30], funct3, opcode});
  wire is_beq = alu_opcode ==? BEQ;
  wire is_bne = alu_opcode ==? BNE;
  wire is_blt = alu_opcode ==? BLT;
  wire is_bge = alu_opcode ==? BGE;
  wire is_bltu = alu_opcode ==? BLTU;
  wire is_bgeu = alu_opcode ==? BGEU;
  wire is_addi = alu_opcode ==? ADDI;
  wire is_add = alu_opcode ==? ADD;

endmodule
