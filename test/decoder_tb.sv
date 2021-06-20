module decoder_tb;

  logic [31:0] instr;
  wire  [31:0] imm;

  int instr_list[] = '{5'b00000,  // I
                       5'b00001,  // I
                       5'b00100,  // I
                       5'b00110,  // I
                       5'b11001,  // I 
                       5'b00101,  // U
                       5'b01101,  // U
                       5'b01000,  // S
                       5'b01001,  // S
                       5'b01011,  // R
                       5'b01100,  // R
                       5'b01110,  // R
                       5'b10100,  // R
                       5'b11000,  // B
                       5'b11011}; // J

  int funct3_list[] = '{3'b000,
                        3'b001,
                        3'b100,
                        3'b101,
                        3'b110,
                        3'b111};

  decoder decoder(.instruction(instr), .imm(imm));
  // 14:12
  initial begin
    for (int x = 0; x<instr_list.size; x++) begin
      for (int y = 0; y<funct3_list.size; y++) begin
        $display("what is this x,y %d,%d", instr_list[x], funct3_list[y]);
        instr = {3'(funct3_list[y]), 5'bxxxxx, 5'(instr_list[x]), 2'b11};
        $display("%b", instr);
        #10;
      end
    end

    $finish;
  end
endmodule