module imem (
    input  logic [31:0] pc,
    output logic [31:0] data
);

  logic [31:0] instruction_memory[2048];

  always_comb data = instruction_memory[pc[31:2]];

  initial begin
    int mem_id = 0;
    // LUI
    instruction_memory[mem_id++] = {20'('h10025), 5'h1,  7'b0110111};
    instruction_memory[mem_id++] = {20'('h20025), 5'h2,  7'b0110111};
    instruction_memory[mem_id++] = {20'('h30F25), 5'h3,  7'b0110111};

    // AUIPC
    instruction_memory[mem_id++] = {20'('h02000), 5'h4,  7'b0010111};
    instruction_memory[mem_id++] = {20'('h000FF), 5'h5,  7'b0010111};
    instruction_memory[mem_id++] = {20'('h00000), 5'h6,  7'b0010111};

    // IMM add
    for (int idx = 1; idx < 32; idx++) begin
      instruction_memory[mem_id++] = {12'('h025*idx), 5'(idx - 1), 3'b000, 5'(idx), 7'b0010011};
    end

    for (int idx = 0; idx<12; idx++) begin
      instruction_memory[mem_id++] = {12'('h225), 5'(idx), 3'b010, 5'(idx+12), 7'b0010011};
    end

    // End
    instruction_memory[mem_id++] = '0;
  end

  /*
  initial begin
    $display("Loading imem");
    $readmemh("../src/rv32_0.0.1/test/software/programs/test.mem", instruction_memory);
  end
  */

endmodule
