module instructionmemory(clk, state, pc, instruction);

    input [1:0] state;
    input clk;
    input [9:0] pc; // change later
    
    output reg [31:0] instruction;

    reg [31:0] memfile [0:1023]; // increase memory size later

    initial
        begin // write instructions here
            //  addi x10, x0,  1     
            memfile[0] <= 32'b0000_0000_0001___00000___000___01010___001_0011;          //  x10     =   1
            //  addi x11, x10, 1
            memfile[1] <= 32'b0000_0000_0001___01010___000___01011___001_0011;          //  x11     =   2
            //  addi x12, x10, 2
            memfile[2] <= 32'b0000_0000_0010___01010___000___01100___001_0011;          //  x12     =   3     
            //  nop
            memfile[3] <= 32'b0000_0000_0000___00000___000___00000___000_0000;          //  nop 
            //  sw   x10, 9(x0)
            memfile[4]  <= 32'b0000000___01010___00000___010___01001___010_0011;        //  mem[9]  =   1
            //  nop
            memfile[5] <= 32'b0000_0000_0000___00000___000___00000___000_0000;          //  nop   
            //  addi x13, x10, 3 
            memfile[6] <= 32'b0000_0000_0011___01010___000___01101___001_0011;          //  x13     =   4
            //  add  x14, x11, x13                                                                                               
            memfile[7] <= 32'b0000000___01011___01101___000___01110___011_0011;         //  x14     =   6   (x14 = x11 + x13)
            //  addi x15, x14, 0
            memfile[8] <= 32'b0000_0000_0000___01110___000___01111___001_0011;          //  x15     =   6   (x15 = x14 + 0)
            //  sub x16, x15, x11
            memfile[9] <= 32'b0100000___01011___01111___000___10000___011_0011;          // x16     =   4   (x16 = x15 - x11) 
            //  addi x17, x16, 0
            memfile[10] <= 32'b0000_0000_0000___10000___000___10001___001_0011;          //  x17     =   4   (x17 = x16 + 0)
            //  sw   x11, 4(x0)         
            memfile[11]  <= 32'b0000000___01011___00000___010___00100___010_0011;         //  mem[4]  =   2
            //  nop
            memfile[12] <= 32'b0000_0000_0000___00000___000___00000___000_0000;         //  nop
            //  sw   x12, 5(x0)         
            memfile[13] <= 32'b0000000___01100___00000___010___00101___010_0011;         // mem[5]  =   3
            //  nop
            memfile[14] <= 32'b0000_0000_0000___00000___000___00000___000_0000;         //  nop
            //  lw   x18, 5(x0)         
            memfile[15] <= 32'b0000_0000_0101___00000___010___10010___000_0011;         //  x18     =   mem[5]  =   3
            //  nop
            memfile[16] <= 32'b0000_0000_0000___00000___000___00000___000_0000;         //  nop
            //  addi x19, x18, 0
            memfile[17] <= 32'b0000_0000_0000___10010___000___10011___001_0011;          //  x19     =   3   (x19 = x18 + 0)
            //  and  x20, x10, x18                                                                                               
            memfile[18] <= 32'b0000000___01010___10010___111___10100___011_0011;         //  x20     =   1   (x20 = x10 & x18)
            //  x10 = 0000_0000_0000_0000_0000_0000_0000_0001
            //  x18 = 0000_0000_0000_0000_0000_0000_0000_0011
            //  x20 = 0000_0000_0000_0000_0000_0000_0000_0001
            //  addi x23, x20, 0
            memfile[19] <= 32'b0000_0000_0000___10100___000___10111___001_0011;          //  x23     =   1   (x23 = x20 + 0)
            //  or  x21, x11, x16                                                                                               
            memfile[20] <= 32'b0000000___01011___10000___110___10101___011_0011;         //  x21     =   6   (x21 = x11 | x16)
            //  x11 = 0000_0000_0000_0000_0000_0000_0000_0010
            //  x16 = 0000_0000_0000_0000_0000_0000_0000_0100
            //  x21 = 0000_0000_0000_0000_0000_0000_0000_0110
            //  addi x24, x21, 0
            memfile[21] <= 32'b0000_0000_0000___10101___000___11000___001_0011;          //  x24     =   6   (x24 = x21 + 0)
            // xor  x22, x14, x17                                                                                               
            memfile[22] <= 32'b0000000___01110___10001___100___10110___011_0011;         //  x22     =   2   (x22 = x14 xor x17)
            //  x14 = 0000_0000_0000_0000_0000_0000_0000_0110
            //  x17 = 0000_0000_0000_0000_0000_0000_0000_0100
            //  x22 = 0000_0000_0000_0000_0000_0000_0000_0010
            //  addi x25, x22, 0
            memfile[23] <= 32'b0000_0000_0000___10110___000___11001___001_0011;          //  x25     =   2   (x25 = x22 + 0)
            //  nop
            memfile[24] <= 32'b0000_0000_0000___00000___000___00000___000_0000;         //  nop
            //  lw   x26, 4(x0)         
            memfile[25] <= 32'b0000_0000_0100___00000___010___11010___000_0011;         //  x26     =   mem[4]  = 2
            //  addi x27, x26, 0
            memfile[26] <= 32'b0000_0000_0000___11010___000___11011___001_0011;          //  x27     =   2   (x27 = x26 + 0)
            //  nop
            memfile[27] <= 32'b0000_0000_0000___00000___000___00000___000_0000;         //  nop
            //  lw   x30, 9(x0)         
            memfile[28] <= 32'b0000_0000_1001___00000___010___11110___000_0011;         //  x30     =   mem[9]  =   1
            //  nop
            memfile[29] <= 32'b0000_0000_0000___00000___000___00000___000_0000;         //  nop
            //  addi x31, x30, 0
            memfile[30] <= 32'b0000_0000_0000___11110___000___11111___001_0011;         //  x31     =   1
        end

    always @(posedge clk)
        if (state == 0)
            begin
                instruction <= memfile[pc];
            end

endmodule