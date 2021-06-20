module program_counter (
    input logic rstN,
    input logic clk,
    output logic [31:0] pc
);

  always_ff @(posedge clk, negedge rstN) begin
    if (!rstN) pc <= '0;
    else       pc <= pc + 4;
  end

endmodule
