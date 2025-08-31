
module register #(parameter DATA_WIDTH = 8) 
(input clk ,rst,load,
input [DATA_WIDTH - 1 : 0 ] data_in,
output reg [DATA_WIDTH - 1 : 0 ] data_out  );

always @(posedge clk) begin
    if (rst) begin
        data_out <= 0;
    end else begin
        if (load) begin
             data_out <= data_in;
        end
    end
end
endmodule