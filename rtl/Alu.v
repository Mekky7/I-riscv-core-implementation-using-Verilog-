
module ALU #( parameter DATA_WIDTH = 8,
opcode_width = 3
) (
        input [DATA_WIDTH -1:0]in_a,in_b,
        input [opcode_width -1:0] opcode,
        output reg [DATA_WIDTH-1:0] alu_out,
        output  a_is_zero
);

always @(*) begin
case (opcode)
 0:
   begin
          alu_out = in_a;
   end
 1:
   begin
          alu_out = in_a;
   end
 2:
   begin
          alu_out = in_a + in_b;
   end 
 3:
   begin
          alu_out = in_a & in_b;
   end  
 4:
   begin
          alu_out = in_a ^ in_b;
   end
 5:
   begin
          alu_out = in_b;
   end
 6:
   begin
          alu_out = in_a;
   end
 7:
   begin
          alu_out = in_a;
   end
    default: begin
          alu_out = 0;
    end
endcase
end

assign a_is_zero = (~|in_a);



    
endmodule