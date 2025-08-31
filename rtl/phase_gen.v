module phase_generator 
(
  input clk,rst,
  output reg [2:0] phase
);

always @(posedge clk ) begin
    if (rst) begin
        phase <= 0;
    end else begin
        phase <= phase + 1;
    end
end
endmodule 