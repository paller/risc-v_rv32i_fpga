package rv;
  typedef enum logic [9:0] {
    LUI   = 10'bxxx_0110111,
    AUIPC = 10'bxxx_0010111,
    JAL   = 10'bxxx_1101111,
    JALR  = 10'b000_1100111,
    BEQ   = 10'b000_1100011,
    BNE   = 10'b001_1100011,
    BLT   = 10'b100_1100011,
    BGE   = 10'b101_1100011,
    BLTU  = 10'b110_1100011,
    BGEU  = 10'b111_1100011,
    LB    = 10'b000_0000011,
    LH    = 10'b001_0000011,
    LW    = 10'b010_0000011,
    LBU   = 10'b100_0000011,
    LHU   = 10'b101_0000011,
    SB    = 10'b000_0100011,
    SH    = 10'b001_0100011,
    SW    = 10'b010_0100011,
    ADDI  = 10'b000_0010011,
    SLTI  = 10'b010_0010011,
    SLTIU = 10'b011_0010011,
    XORI  = 10'b100_0010011,
    ORI   = 10'b110_0010011,
    ANDI  = 10'b111_0010011,
    SLLI  = 10'b001_0010011,
    SRxI  = 10'b101_0010011,
    ADD   = 10'b000_0110110,
    SLL   = 10'b001_0110011,
    SLT   = 10'b010_0110011,
    SLTU  = 10'b011_0110011,
    XOR   = 10'b100_0110011,
    SRx   = 10'b101_0110011,
    OR    = 10'b110_0110011,
    AND   = 10'b111_0110011
  } RV32_INSTRUCTION;

  typedef enum logic [3:0] {
    ALU_SLL  = 4'd00,
    ALU_SRL  = 4'd01,
    ALU_SRA  = 4'd02,
    ALU_ADD  = 4'd03,
    ALU_SUB  = 4'd04,
    ALU_XOR  = 4'd05,
    ALU_OR   = 4'd06,
    ALU_AND  = 4'd07,
    ALU_SLT  = 4'd08,
    ALU_SLTU = 4'd09,
    ALU_SBT  = 4'd10,
    ALU_SBTU = 4'd11,
    ALU_EQ   = 4'd12,
    ALU_NEQ  = 4'd13,
    ALU_NOP  = 4'd15
  } RV32_ALU_OPCODE;

  typedef enum logic
  {
    RS2 = 1'b0,
    IMM = 1'b1
  } RV32_ALU_INPUT;

endpackage
