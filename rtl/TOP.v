module risc
   (
    input clk
    ,input rst,
    output halt 
    );

wire [2:0] phase;
wire rd,wr,ld_ac,ld_pc,data_e,sel;
wire [4:0] pc_addr,addr,ir_addr;
wire [7:0] data,data_out ;
wire [7:0] ac_out;
wire [2:0] opcode ;
wire [7:0] alu_out;


assign opcode =  data_out [7:5];
assign ir_addr = data_out [4:0];
/* note that data out is the overall output of the register file (instruction register) and it's devided into the 2 parts :
1. opcode
2.ir_addr 
*/

counter program_counter_BLOCK 
(
     .enab(inc_pc), 
     .load(ld_pc), 
     .clk(clk),
     .rst(rst),
     .cnt_in(ir_addr),
     .cnt_out(pc_addr)
);


phase_generator Phase_generator_BLOCK
(
   .clk(clk),
   .rst(rst),
   .phase(phase)
);

controller Controller_BLOCK
(
    .zero(zero),
    .phase(phase),
    .opcode(opcode),
    .sel(sel),
    .rd(rd),
    .ld_ir(ld_ir),
    .halt(halt),
    .inc_pc(inc_pc),
    .ld_ac(ld_ac),
    .wr(wr),
    .ld_pc(ld_pc),
    .data_e(data_e)
);

memory  memory_inst

 (
                .clk(clk)  ,
                .wr(wr)   ,
                .rd(rd)   ,
                .addr(addr) ,
                .data(data)  
 );

multiplexor multiplexor 
(
    .in0(ir_addr),
    .in1(pc_addr),
    .sel(sel),
    .mux_out(addr)
);

register  instruction_register
( 
          .clk(clk) ,
          .rst(rst),
          .load(ld_ir),
          .data_in(data),
          .data_out(data_out)  
  );



register accumulator
( 
    .clk(clk) ,
    .rst(rst),
    .load(ld_ac),
    .data_in(alu_out),
    .data_out(ac_out)
);


driver driver 
(
    .data_in(alu_out),
    .data_out(data),
    .data_en(data_e)
);


ALU alu_inst
 (
        .in_a(ac_out),
        .in_b(data),
        .opcode(opcode),
        .alu_out(alu_out),
        .a_is_zero(zero)
 );








endmodule