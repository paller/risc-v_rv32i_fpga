package rv;
  typedef enum logic [8:0] {
    BEQ  = 9'bx_000_11000,
    BNE  = 9'bx_001_11000,
    BLT  = 9'bx_100_11000,
    BGE  = 9'bx_101_11000,
    BLTU = 9'bx_110_11000,
    BGEU = 9'bx_111_11000,
    ADDI = 9'bx_000_00100,
    ADD  = 9'b0_000_01100
  } RV32_INSTRUCTION;
  
endpackage