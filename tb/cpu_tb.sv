// testbench 
module cpu_tb;

    logic clk;
    logic rst;

    cpu_top dut (.clk(clk), .rst(rst));

    // Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        #20 rst = 0;

        // Load program
        $readmemh("../software/hex/prog.hex", dut.imem);

        #500;

        $display("x1 = %d", dut.rf.regs[1]);
        $display("x2 = %d", dut.rf.regs[2]);
        $display("x3 = %d", dut.rf.regs[3]);

        $finish;
    end

endmodule
