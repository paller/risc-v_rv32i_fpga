module top_tb;

  logic rstN, clk;

  top top(.rstN(rstN), .clk(clk));

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