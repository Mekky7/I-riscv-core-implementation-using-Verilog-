module controller#(parameter OPCODE_WIDTH = 3)(
    input zero,
    input [2:0] phase,
    input [OPCODE_WIDTH-1:0] opcode,
    output  sel,rd,ld_ir,halt,inc_pc,ld_ac,wr,ld_pc,data_e
);
reg [8:0] temp_reg;
always @(*) begin
    temp_reg = 0;
    case (phase)
       0 : begin
        temp_reg = 1;
       end 
       1: begin
        temp_reg = 3;
       end
       2: begin
        temp_reg = 7;
       end
       3: begin
        temp_reg = 7;
       end
       4: begin
        temp_reg = 16;
        temp_reg [3] = (opcode ==0);
       end
       5: begin
         temp_reg = 0;
        temp_reg [1] = ((opcode ==2)||(opcode==3)||(opcode == 4)||(opcode == 5));
        // temp_reg [1] = ((2<opcode)&&(opcode<6));
       end
        6: begin
         temp_reg = 0;
         temp_reg [1] = ((opcode ==2)||(opcode==3)||(opcode == 4)||(opcode == 5));
        // temp_reg [1] = ((2<opcode)&&(opcode<6));
        temp_reg [4] = (opcode ==1) & zero;
        temp_reg [6] = (opcode == 7);
        temp_reg [8] = (opcode == 6);
       end 
        7: begin
         temp_reg = 0;
         temp_reg [1] = ((opcode ==2)||(opcode==3)||(opcode == 4)||(opcode == 5));
        // temp_reg [1] = ((2<opcode)&&(opcode<6));
       // temp_reg [4] = (opcode ==1) & zero;
        temp_reg [5] = ((opcode ==2)||(opcode==3)||(opcode == 4)||(opcode == 5));
        temp_reg [6] = (opcode == 7);
        temp_reg [7] = (opcode == 6);
        temp_reg [8] = (opcode == 6);
       end  
    endcase
end
assign {data_e,wr,ld_pc,ld_ac,inc_pc,halt,ld_ir,rd,sel} = temp_reg ;
endmodule