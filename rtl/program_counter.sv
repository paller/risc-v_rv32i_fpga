module program_counter
  import rv::*;
(
    input  logic     rstN,
    input  logic     clk,
    input  logic     write_pc,
    input  RV32_PC_T new_pc,
    output RV32_PC_T pc
);

  always_ff @(posedge clk, negedge rstN) begin
    if (!rstN) pc <= '0;
    else       pc <= write_pc ? new_pc : pc + 4;
  end

endmodule
