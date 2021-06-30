module decoder
  import rv::*;
(
    input  logic            [31:0] instruction,
    output logic            [ 4:0] rs1,
    output logic            [ 4:0] rs2,
    output logic            [ 4:0] rd,
    output logic                   rd_we,
    output logic            [31:0] imm,
    output RV32_ALU_OPCODE         funct3,
    output RV32_ALU_INPUT          alu_second_input
);

  // Extract fields
  assign rd  = instruction[11:07];
  assign rs1 = instruction[19:15];
  assign rs2 = instruction[24:20];
  assign funct3 = RV32_ALU_OPCODE'(instruction[14:12]);
  RV32_INSTRUCTION_OPCODE opcode = RV32_INSTRUCTION_OPCODE'(instruction[06:00]);
  wire [6:0] funct7 = instruction[31:25];

  // Instruction type
  // TODO: Update with enum types
  wire is_i_instr = opcode inside {7'b0000111, 7'b0010011, 7'b0011011, 7'b1100111};
  wire is_r_instr = opcode inside {7'b0101111, 7'b0110011, 7'b0111011, 7'b1010011};
  wire is_u_instr = opcode inside {7'b0010111, 7'b0110111};
  wire is_s_instr = opcode inside {7'b0000011, 7'b0100011, 7'b0100111};
  wire is_b_instr = opcode inside {7'b1100011};
  wire is_j_instr = opcode inside {7'b1101111};

  // Valid fields
  wire rd_valid  = (is_r_instr || is_i_instr || is_u_instr || is_j_instr);
  wire rs1_valid = (is_r_instr || is_i_instr || is_s_instr || is_b_instr);
  wire rs2_valid = (is_r_instr || is_s_instr || is_b_instr);
  wire imm_valid = !is_r_instr;
  wire funct3_valid = rs1_valid;
  wire funct7_valid = is_r_instr;

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

  assign alu_opcode = RV32_INSTRUCTION'({funct3, opcode});
  
  always_comb begin
    alu_second_input = ALU_MUX_RS2;
    rd_we = 1'b0;

    case(opcode)
      IMM: begin
        alu_second_input = ALU_MUX_IMM;
        rd_we = 1'b1;
      end
    endcase
  end

  /*
  wire is_beq = alu_opcode ==? BEQ;
  wire is_bne = alu_opcode ==? BNE;
  wire is_blt = alu_opcode ==? BLT;
  wire is_bge = alu_opcode ==? BGE;
  wire is_bltu = alu_opcode ==? BLTU;
  wire is_bgeu = alu_opcode ==? BGEU;
  wire is_addi = alu_opcode ==? ADDI;
  wire is_add = alu_opcode ==? ADD;
  */

endmodule
