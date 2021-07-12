module top_tb;

  logic rstN, clk;

  top top (
      .rstN(rstN),
      .clk(clk)
  );

  initial begin
    clk  = 1'b1;
    rstN = 1'b1;

    // Reset
    #1;
    rstN = 1'b0;
    @(negedge clk) rstN = 1'b1;

    repeat(50) @(posedge clk);
    $finish;
  end

  always begin
    #5 clk = ~clk;
  end

endmodule
