module counter(
    input enab, load, clk,rst,
    input [4:0]     cnt_in,
    output reg [4:0] cnt_out
);
    

always @ (posedge clk) begin    

if(rst) begin
cnt_out <= 0;
end else begin
    cnt_out <= return_cout_fun(load,enab,cnt_in,cnt_out);
end

end

function reg [4:0] return_cout_fun (input load,input enab,input [4:0] cnt_in,input [4:0] cnt_out) ;
if(load) begin
    return_cout_fun = cnt_in;
end else  if (enab) begin
        return_cout_fun = cnt_out + 1;
end else begin
    return_cout_fun = cnt_out;
end

endfunction


endmodule