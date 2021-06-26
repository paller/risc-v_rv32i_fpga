module dmem (
    input logic        clk,
    input logic        wr_en,
    input logic [31:0] addr,
    inout logic [31:0] data_in,
    inout logic [31:0] data_out
);

  logic [31:0] data_memory[2048];

  assign data_out = data_memory[addr];

  always_ff @(posedge clk) begin
    if (wr_en) data_memory[addr] <= data_in;
  end

  initial begin
    for (int x = 0; x<2048; x++)
      data_memory[x] = 0;
  end

endmodule
