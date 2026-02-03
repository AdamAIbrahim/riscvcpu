// immediate generator (i type for now)
module immgen (
    input  logic [31:0] instr,
    output logic [31:0] imm
);

    always_comb begin
        // I-type
        imm = {{20{instr[31]}}, instr[31:20]};
    end

endmodule
