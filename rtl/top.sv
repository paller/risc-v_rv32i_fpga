module top (
    input logic rstN,
    input logic clk
);
  import rv::*;

  controller controller (
      .clk(clk),
      .rstN(rstN)
  );

endmodule
