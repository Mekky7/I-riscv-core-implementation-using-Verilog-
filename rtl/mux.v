module multiplexor #(parameter DATA_WIDTH =5) (
    input [DATA_WIDTH-1:0] in0,in1,
    input sel,
    output wire [DATA_WIDTH-1:0] mux_out
);

assign mux_out = (sel)? in1:in0;

         



endmodule




