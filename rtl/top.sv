module top
  (
    //input logic rstN,
    input logic clk,
    output logic led
);
  import rv::*;
  
  wire rstN = 1;

  // Program counter
  wire [31:0] pc;
  // Imem
  wire [31:0] instruction;
  // Decoder
  wire [ 4:0] rs1;
  wire [ 4:0] rs2;
  wire [ 4:0] rd;
  wire [31:0] imm;
  wire RV32_INSTRUCTION alu_opcode;
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

  imem imem (.clk(clk), .data_in(instruction),
  .we(we), .pc(pc), .data(instruction));
  assign led = instruction[0];
  // we very wrong!
  
  decoder decoder (
      .instruction(instruction),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .rd_we(we),
      .imm(imm),
      .alu_opcode(alu_opcode)
  );

  register_file register_file (
      .clk(clk),
      .rstN(rstN),
      .rs1(rs1),
      .rs2(rs2),
      .rd(rd),
      .we(we),
      .data_in(alu_result), // Missing MUX
      .data_out1(op1),
      .data_out2(op2)
  );

  alu alu (
      .op1(op1),
      .op2(op2),
      .imm(imm),
      .opcode(alu_opcode),
      .result(alu_result)
  );
endmodule