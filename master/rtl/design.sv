// Top level design
`include "fifo_mem.v"
module master_module (clk, rst_n, enable, addr, write, read, wdata, rdata, resp);
 
  input logic clk;
  input logic rst_n;
  input logic enable;
  input logic [1:0] addr;
  input logic write;
  input logic read;
  input logic  [7:0] wdata;
  output logic [7:0] rdata;
  output logic resp;
 
  logic [7:0] fifo_data_in;
 
  logic fifo_wr;
  logic fifo_rd;
  logic fifo_reg_write;
 
  logic[7:0] STAT_REG;//addr=1
  logic[31:0] MEM_REG; //addr= 2

  logic[7:0] fifo_data_out;
 
  logic fifo_underflow, fifo_overflow, fifo_full, fifo_empty;
   
  always_comb begin
fifo_rd = enable && rst_n ? (addr == 'h0) && read : 0;
fifo_wr = enable && rst_n ? (addr == 'h0) && write : 0;
fifo_data_in = enable && rst_n ? {8{fifo_wr}} &  wdata : 0;
    fifo_reg_write = enable && rst_n ? (addr == 'h1 ) && write && (wdata[4] == 'h1) : 0;
//fifo_reg_write-only write to reg is for clr of STAT_REG
  end  
 
  //top level outputs
  always_comb begin    
  //  resp = (addr == 'h2) && write && enable;//writing to MEM_REG
case(addr)
  0 : rdata = fifo_data_out;
  1 : rdata = STAT_REG;
  2 : rdata = MEM_REG;
  default : rdata = 0;
endcase
  end
 
 //STAT_REG
 assign STAT_REG[7:5] = 0;
 assign STAT_REG[4] = fifo_reg_write;
 assign STAT_REG[3] = fifo_underflow;
 assign STAT_REG[2] = fifo_overflow;
 assign STAT_REG[1] = fifo_empty;
 assign STAT_REG[0] = fifo_full;
 //MEM_REG
 assign MEM_REG[7:0] = fifo_data_in;
 assign MEM_REG[31:24] = fifo_data_out;
 assign MEM_REG[8] = fifo_wr- fifo_rd;
 assign MEM_REG[23:9] =0;
 
  fifo_mem fifo_mem(
    .data_out(fifo_data_out),
    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty),
    .fifo_overflow(fifo_overflow),
    .fifo_underflow(fifo_underflow),
    .clk(clk),
    .rst_n(rst_n),
    .wr(fifo_wr),
    .rd(fifo_rd),
    .data_in(fifo_data_in),
.clear(STAT_REG[4])
  );    
 

 
endmodule

