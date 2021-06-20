module program_counter_tb;

  logic rstN, clk;
  logic [31:0] pc;

  program_counter program_counter(.*);

  initial begin
    clk = 1;
    rstN = 1;
    
    #2 rstN = 0;
    #5 rstN = 1;
    
    repeat(10) #10;
    $finish;
  end

  always begin
    #5 clk = ~clk;
  end

endmodule