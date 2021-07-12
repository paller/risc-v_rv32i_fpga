module program_counter_tb;

  import rv::*;

  logic clk, rstN, write_pc;
  RV32_PC_T new_pc, next_pc, pc;

  program_counter program_counter (.*);

  initial begin
    rstN = 1'b1;
    clk  = 1'b1;
    #1;
    rstN = 1'b0;
    #2;
    rstN = 1'b1;

    write_pc = 1'b1;
    new_pc = '0;
    @(negedge clk) write_pc = 1'b0;

    repeat (10) @(negedge clk);

    new_pc   = 32'h1000_ABC0;
    write_pc = 1'b1;
    @(negedge clk) write_pc = 1'b0; new_pc = '0;

    repeat (10) @(negedge clk);

    new_pc   = 32'h4000_0000;
    write_pc = 1'b1;
    @(negedge clk);
    new_pc   = 32'h0000_2048;
    @(negedge clk) write_pc = 1'b0;
    @(negedge clk);
    @(negedge clk);
    $finish;
  end

  always begin
    #5 clk = ~clk;
  end

endmodule
