module register_file_tb;

  logic rstN, clk, we;
  logic [4:0] rs1, rs2, rd;
  logic [31:0] data_in;
  wire [31:0] data_out1, data_out2;

  register_file rg(.*);

  initial begin
    clk = 1;
    rstN = 1;
    we = 0;
    rs1 = 0;
    rs2 = 0;
    
    #2 rstN = 0;
    #5 rstN = 1;

    for (int x=0; x<32; x++) begin
      #10
      rd = x;
      data_in = (x + 4069) ** 2;
      we = 1'b1;
    end

    for (int x=0; x<32; x++) begin
      #10
      rs1 = x;
      rs2 = 31 - x;
      we = 1'b0;
      #10
      data_in = data_out1 + data_out2;
      rd = x;
      we = 1'b1;
    end
    $finish;
  end

  always begin
    #5 clk = ~clk;
  end

endmodule