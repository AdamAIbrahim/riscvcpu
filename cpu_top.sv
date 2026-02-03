// cpu top (connects everything) 
module cpu_top (
    input logic clk,
    input logic rst
);

    // PC
    logic [31:0] pc, next_pc;

    // Instruction memory
    logic [31:0] imem [0:255];
    logic [31:0] instr;

    // Wires
    logic reg_write, alu_src;
    logic [3:0] alu_ctrl;

    logic [31:0] rd1, rd2, alu_b, alu_out, imm;

    // PC
    pc pc0 (
        .clk(clk),
        .rst(rst),
        .we(1'b1),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Instruction fetch
    assign instr = imem[pc[9:2]];

    // Decode
    wire [6:0] opcode = instr[6:0];
    wire [4:0] rd     = instr[11:7];
    wire [2:0] funct3 = instr[14:12];
    wire [4:0] rs1    = instr[19:15];
    wire [4:0] rs2    = instr[24:20];
    wire [6:0] funct7 = instr[31:25];

    // Control
    control ctrl (
        opcode, funct3, funct7,
        reg_write, alu_src, alu_ctrl
    );

    // Regfile
    regfile rf (
        clk,
        reg_write,
        rs1, rs2,
        rd,
        alu_out,
        rd1, rd2
    );

    // Immediate
    immgen ig (instr, imm);

    // ALU input mux
    assign alu_b = (alu_src) ? imm : rd2;

    // ALU
    alu alu0 (
        rd1,
        alu_b,
        alu_ctrl,
        alu_out,
        /*zero*/
    );

    // PC increment
    assign next_pc = pc + 4;

endmodule
