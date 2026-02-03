// program counter
module pc (
    input  logic        clk,
    input  logic        rst,
    input  logic        we,
    input  logic [31:0] next_pc,
    output logic [31:0] pc
);

    always_ff @(posedge clk) begin
        if (rst)
            pc <= 32'b0;
        else if (we)
            pc <= next_pc;
    end

endmodule
