module perm 
(
input clk,
input reset,

input  [2:0] dix,
input  [199:0] din,
input  pushin,

output reg [2:0] doutix,
output reg [199:0] dout,
output reg pushout
);

reg [1599:0] s;
reg  [5-1:0][5-1:0][64-1:0] avec;
wire [5-1:0][5-1:0][64-1:0] a_stage_out [7:0];

wire s_last;
reg  [7:0]  perm_stage_en;
wire [1599:0] s_out;

genvar i;
generate
for (i=0; i<8; i=i+1) begin: gen_s
always @(posedge clk or posedge reset) begin
   if(reset)
      s[(200+(200*i))-1:200*i] <= 'b0;
   else begin
      if(pushin && (dix == i))
         s[(200+(200*i))-1:200*i] <= #1 din;
   end
end
end: gen_s
endgenerate

genvar x,y,z;
generate
for(x=0;x<5;x=x+1) begin: gen_avec_x
   for(y=0;y<5;y=y+1) begin: gen_avec_y
      for(z=0;z<64;z=z+1) begin: gen_avec_z
assign avec[x][y][z] = s[64*(5*y+x)+z];
      end: gen_avec_z
   end: gen_avec_y
end: gen_avec_x
endgenerate

assign s_last = ((dix == 3'd7) && pushin);

always @(posedge clk or posedge reset) begin
   if(reset)
      perm_stage_en <= 'b0;
   else
      perm_stage_en <= #1 {perm_stage_en[6:0],s_last};
end

genvar t;
generate
for(t=0;t<8;t=t+1) begin: gen_perm_stage
if(t==0) begin
perm_stage u_perm_stage (
   .clk(clk),
   .reset(reset),
   .stage_en(perm_stage_en[t]),
   .a_stage_in(avec),
   .a_stage_out(a_stage_out[t]),
   .perm_stage(t)
);
end else begin
perm_stage u_perm_stage (
   .clk(clk),
   .reset(reset),
   .stage_en(perm_stage_en[t]),
   .a_stage_in(a_stage_out[t-1]),
   .a_stage_out(a_stage_out[t]),
   .perm_stage(t)
);
end
end: gen_perm_stage
endgenerate

always @(posedge clk or posedge reset) begin
   if(reset)
      pushout <= 1'b0;
   else begin
      if(perm_stage_en[7])
         pushout <= #1 1'b1;
      else if(doutix == 7)
         pushout <= #1 1'b0;
   end
end

always @(posedge clk or posedge reset) begin
   if(reset)
      doutix <= 'b0;
   else begin
      if(doutix == 3'd7)
         doutix <= #1 3'd0;
      else if(pushout)
         doutix <= #1 doutix + 3'd1;
   end
end

genvar m,n,o;
generate
for(m=0;m<5;m=m+1) begin: gen_s_out_x
   for(n=0;n<5;n=n+1) begin: gen_s_out_y
      for(o=0;o<64;o=o+1) begin: gen_s_out_z
assign s_out[64*(5*n+m)+o] = a_stage_out[7][m][n][o];
      end: gen_s_out_z
   end: gen_s_out_y
end: gen_s_out_x
endgenerate

always @*
begin
   case(doutix)
      3'd0:    dout = s_out[199:0];
      3'd1:    dout = s_out[399:200];
      3'd2:    dout = s_out[599:400];
      3'd3:    dout = s_out[799:600];
      3'd4:    dout = s_out[999:800];
      3'd5:    dout = s_out[1199:1000];
      3'd6:    dout = s_out[1399:1200];
      3'd7:    dout = s_out[1599:1400];
      default: dout = 200'b0;
   endcase
end

// synthesis translate_off
initial begin
   wait(perm_stage_en[0]);
      $display("A");
      $display("%h %h %h %h %h",avec[0][0],avec[1][0],avec[2][0],avec[3][0],avec[4][0]);
      $display("%h %h %h %h %h",avec[0][1],avec[1][1],avec[2][1],avec[3][1],avec[4][1]);
      $display("%h %h %h %h %h",avec[0][2],avec[1][2],avec[2][2],avec[3][2],avec[4][2]);
      $display("%h %h %h %h %h",avec[0][3],avec[1][3],avec[2][3],avec[3][3],avec[4][3]);
      $display("%h %h %h %h %h",avec[0][4],avec[1][4],avec[2][4],avec[3][4],avec[4][4]);
end

initial begin
   wait(perm_stage_en[1]);
      $display("A Stage0 Out");
      $display("%h %h %h %h %h",a_stage_out[0][0][0],a_stage_out[0][1][0],a_stage_out[0][2][0],a_stage_out[0][3][0],a_stage_out[0][4][0]);
      $display("%h %h %h %h %h",a_stage_out[0][0][1],a_stage_out[0][1][1],a_stage_out[0][2][1],a_stage_out[0][3][1],a_stage_out[0][4][1]);
      $display("%h %h %h %h %h",a_stage_out[0][0][2],a_stage_out[0][1][2],a_stage_out[0][2][2],a_stage_out[0][3][2],a_stage_out[0][4][2]);
      $display("%h %h %h %h %h",a_stage_out[0][0][3],a_stage_out[0][1][3],a_stage_out[0][2][3],a_stage_out[0][3][3],a_stage_out[0][4][3]);
      $display("%h %h %h %h %h",a_stage_out[0][0][4],a_stage_out[0][1][4],a_stage_out[0][2][4],a_stage_out[0][3][4],a_stage_out[0][4][4]);
end

initial begin
   wait(perm_stage_en[2]);
      $display("A Stage1 Out");
      $display("%h %h %h %h %h",a_stage_out[1][0][0],a_stage_out[1][1][0],a_stage_out[1][2][0],a_stage_out[1][3][0],a_stage_out[1][4][0]);
      $display("%h %h %h %h %h",a_stage_out[1][0][1],a_stage_out[1][1][1],a_stage_out[1][2][1],a_stage_out[1][3][1],a_stage_out[1][4][1]);
      $display("%h %h %h %h %h",a_stage_out[1][0][2],a_stage_out[1][1][2],a_stage_out[1][2][2],a_stage_out[1][3][2],a_stage_out[1][4][2]);
      $display("%h %h %h %h %h",a_stage_out[1][0][3],a_stage_out[1][1][3],a_stage_out[1][2][3],a_stage_out[1][3][3],a_stage_out[1][4][3]);
      $display("%h %h %h %h %h",a_stage_out[1][0][4],a_stage_out[1][1][4],a_stage_out[1][2][4],a_stage_out[1][3][4],a_stage_out[1][4][4]);
end

initial begin
   wait(perm_stage_en[3]);
      $display("A Stage2 Out");
      $display("%h %h %h %h %h",a_stage_out[2][0][0],a_stage_out[2][1][0],a_stage_out[2][2][0],a_stage_out[2][3][0],a_stage_out[2][4][0]);
      $display("%h %h %h %h %h",a_stage_out[2][0][1],a_stage_out[2][1][1],a_stage_out[2][2][1],a_stage_out[2][3][1],a_stage_out[2][4][1]);
      $display("%h %h %h %h %h",a_stage_out[2][0][2],a_stage_out[2][1][2],a_stage_out[2][2][2],a_stage_out[2][3][2],a_stage_out[2][4][2]);
      $display("%h %h %h %h %h",a_stage_out[2][0][3],a_stage_out[2][1][3],a_stage_out[2][2][3],a_stage_out[2][3][3],a_stage_out[2][4][3]);
      $display("%h %h %h %h %h",a_stage_out[2][0][4],a_stage_out[2][1][4],a_stage_out[2][2][4],a_stage_out[2][3][4],a_stage_out[2][4][4]);
end

initial begin
   wait(perm_stage_en[4]);
      $display("A Stage3 Out");
      $display("%h %h %h %h %h",a_stage_out[3][0][0],a_stage_out[3][1][0],a_stage_out[3][2][0],a_stage_out[3][3][0],a_stage_out[3][4][0]);
      $display("%h %h %h %h %h",a_stage_out[3][0][1],a_stage_out[3][1][1],a_stage_out[3][2][1],a_stage_out[3][3][1],a_stage_out[3][4][1]);
      $display("%h %h %h %h %h",a_stage_out[3][0][2],a_stage_out[3][1][2],a_stage_out[3][2][2],a_stage_out[3][3][2],a_stage_out[3][4][2]);
      $display("%h %h %h %h %h",a_stage_out[3][0][3],a_stage_out[3][1][3],a_stage_out[3][2][3],a_stage_out[3][3][3],a_stage_out[3][4][3]);
      $display("%h %h %h %h %h",a_stage_out[3][0][4],a_stage_out[3][1][4],a_stage_out[3][2][4],a_stage_out[3][3][4],a_stage_out[3][4][4]);
end

initial begin
   wait(perm_stage_en[5]);
      $display("A Stage4 Out");
      $display("%h %h %h %h %h",a_stage_out[4][0][0],a_stage_out[4][1][0],a_stage_out[4][2][0],a_stage_out[4][3][0],a_stage_out[4][4][0]);
      $display("%h %h %h %h %h",a_stage_out[4][0][1],a_stage_out[4][1][1],a_stage_out[4][2][1],a_stage_out[4][3][1],a_stage_out[4][4][1]);
      $display("%h %h %h %h %h",a_stage_out[4][0][2],a_stage_out[4][1][2],a_stage_out[4][2][2],a_stage_out[4][3][2],a_stage_out[4][4][2]);
      $display("%h %h %h %h %h",a_stage_out[4][0][3],a_stage_out[4][1][3],a_stage_out[4][2][3],a_stage_out[4][3][3],a_stage_out[4][4][3]);
      $display("%h %h %h %h %h",a_stage_out[4][0][4],a_stage_out[4][1][4],a_stage_out[4][2][4],a_stage_out[4][3][4],a_stage_out[4][4][4]);
end

initial begin
   wait(perm_stage_en[6]);
      $display("A Stage5 Out");
      $display("%h %h %h %h %h",a_stage_out[5][0][0],a_stage_out[5][1][0],a_stage_out[5][2][0],a_stage_out[5][3][0],a_stage_out[5][4][0]);
      $display("%h %h %h %h %h",a_stage_out[5][0][1],a_stage_out[5][1][1],a_stage_out[5][2][1],a_stage_out[5][3][1],a_stage_out[5][4][1]);
      $display("%h %h %h %h %h",a_stage_out[5][0][2],a_stage_out[5][1][2],a_stage_out[5][2][2],a_stage_out[5][3][2],a_stage_out[5][4][2]);
      $display("%h %h %h %h %h",a_stage_out[5][0][3],a_stage_out[5][1][3],a_stage_out[5][2][3],a_stage_out[5][3][3],a_stage_out[5][4][3]);
      $display("%h %h %h %h %h",a_stage_out[5][0][4],a_stage_out[5][1][4],a_stage_out[5][2][4],a_stage_out[5][3][4],a_stage_out[5][4][4]);
end

initial begin
   wait(perm_stage_en[7]);
      $display("A Stage6 Out");
      $display("%h %h %h %h %h",a_stage_out[6][0][0],a_stage_out[6][1][0],a_stage_out[6][2][0],a_stage_out[6][3][0],a_stage_out[6][4][0]);
      $display("%h %h %h %h %h",a_stage_out[6][0][1],a_stage_out[6][1][1],a_stage_out[6][2][1],a_stage_out[6][3][1],a_stage_out[6][4][1]);
      $display("%h %h %h %h %h",a_stage_out[6][0][2],a_stage_out[6][1][2],a_stage_out[6][2][2],a_stage_out[6][3][2],a_stage_out[6][4][2]);
      $display("%h %h %h %h %h",a_stage_out[6][0][3],a_stage_out[6][1][3],a_stage_out[6][2][3],a_stage_out[6][3][3],a_stage_out[6][4][3]);
      $display("%h %h %h %h %h",a_stage_out[6][0][4],a_stage_out[6][1][4],a_stage_out[6][2][4],a_stage_out[6][3][4],a_stage_out[6][4][4]);
end

initial begin
   wait(perm_stage_en[7]);
   @(posedge clk);
   @(posedge clk);
      $display("A Stage7 Out");
      $display("%h %h %h %h %h",a_stage_out[7][0][0],a_stage_out[7][1][0],a_stage_out[7][2][0],a_stage_out[7][3][0],a_stage_out[7][4][0]);
      $display("%h %h %h %h %h",a_stage_out[7][0][1],a_stage_out[7][1][1],a_stage_out[7][2][1],a_stage_out[7][3][1],a_stage_out[7][4][1]);
      $display("%h %h %h %h %h",a_stage_out[7][0][2],a_stage_out[7][1][2],a_stage_out[7][2][2],a_stage_out[7][3][2],a_stage_out[7][4][2]);
      $display("%h %h %h %h %h",a_stage_out[7][0][3],a_stage_out[7][1][3],a_stage_out[7][2][3],a_stage_out[7][3][3],a_stage_out[7][4][3]);
      $display("%h %h %h %h %h",a_stage_out[7][0][4],a_stage_out[7][1][4],a_stage_out[7][2][4],a_stage_out[7][3][4],a_stage_out[7][4][4]);
end

// synthesis translate_on

endmodule
`include "perm_stage.sv"
`include "perm_theta.sv"
`include "perm_rho_pi.sv"
`include "perm_chi.sv"
`include "perm_iota.sv"
