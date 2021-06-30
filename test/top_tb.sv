module top_tb;

  logic rstN, clk;
  logic [31:0] instruction;

  top top(.rstN(rstN), .clk(clk), .instruction(instruction));

  initial begin
    clk = 1;
    rstN = 1;
 
    // Reset
    @(negedge clk)
      rstN = 0;
    @(negedge clk)
      rstN = 1;

    repeat(26)
      @(posedge clk)
        ;

    $finish;
  end

  always begin
    #5 clk = ~clk;
  end

endmodule