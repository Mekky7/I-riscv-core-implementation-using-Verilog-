module driver
#(
    parameter DATA_WIDTH = 8
)
(
    input   [DATA_WIDTH-1:0] data_in,
    input                    data_en,
    output  [DATA_WIDTH-1:0] data_out
);
    
    assign data_out = (data_en)? data_in: 'hz;
endmodule