module register_file (
    input  logic        rstN,
    input  logic        clk,
    input  logic [ 4:0] rs1,
    input  logic [ 4:0] rs2,
    input  logic [ 4:0] rd,
    input  logic        we,
    input  logic [31:0] data_in,
    output logic [31:0] data_out1,
    output logic [31:0] data_out2
);

  logic [31:0] register[32];

  always_comb begin
    data_out1 = register[rs1];
    data_out2 = register[rs2];
  end

  always_ff @(posedge clk, negedge rstN) begin
    if (!rstN) begin
      for (int x = 0; x < 32; x++) begin
        register[x] = 0;
      end
    end else
      if (we && (rd != 0)) register[rd] <= data_in;
  end
endmodule
