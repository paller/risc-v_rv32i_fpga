module top
  (
    input logic rstN,
    input logic clk,
    input [31:0] instruction
);
  import rv::*;
  
  // Program counter
  wire [31:0] pc;
  // Imem
  //wire [31:0] instruction;
  // Decoder
  wire [ 4:0] rs1;
  wire [ 4:0] rs2;
  wire [ 4:0] rd;
  wire [31:0] imm;
  RV32_ALU_OPCODE alu_opcode;
  RV32_ALU_INPUT alu_op2_mux;
  
  // Register file
  wire        we;
  wire [31:0] op1;
  wire [31:0] op2;
  // ALU
  wire [31:0] alu_result;

  program_counter program_counter (
      .rstN(rstN),
      .clk (clk),
      .pc  (pc)
  );

  /*
  imem imem (.clk(clk), .pc(pc), .data(instruction));
  dmem dmem (.clk(clk), .wr_en(!we), .addr(op1 + imm), .data_in(op2));
  */
  
  decoder decoder (
      .instruction(instruction),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .rd_we(we),
      .imm(imm),
      .funct3(alu_opcode),
      .alu_second_input(alu_op2_mux)
  );

  register_file register_file (
      .clk(clk),
      .rstN(rstN),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .we(we),
      .data_in(imm), // Missing MUX
      .data_out1(op1),
      .data_out2(op2)
  );

  alu alu (
      .op1(op1),
      .op2((alu_op2_mux == ALU_MUX_RS2) ? op2 : imm),
      .opcode(alu_opcode),
      .result(alu_result)
  );

endmodule