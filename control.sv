//minimal control unit
module control (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic       reg_write,
    output logic       alu_src,
    output logic [3:0] alu_ctrl
);

    always_comb begin

        // Defaults
        reg_write = 0;
        alu_src   = 0;
        alu_ctrl  = 4'b0000;

        case (opcode)

            7'b0110011: begin // R-type
                reg_write = 1;
                alu_src   = 0;

                if (funct7 == 7'b0100000)
                    alu_ctrl = 4'b0001; // SUB
                else
                    alu_ctrl = 4'b0000; // ADD
            end

            7'b0010011: begin // ADDI
                reg_write = 1;
                alu_src   = 1;
                alu_ctrl  = 4'b0000;
            end

        endcase
    end

endmodule
