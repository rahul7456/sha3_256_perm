module perm_rho_pi
(
input  [5-1:0][5-1:0][64-1:0] a_rho_in,
output [5-1:0][5-1:0][64-1:0] a_pi_out
);
`include "func.sv"

wire [5-1:0][5-1:0][8:0] t_offset;
wire [5-1:0][5-1:0][64-1:0] a_rho;

assign t_offset[0][0] = 9'd0;
assign t_offset[0][1] = 9'd36;
assign t_offset[0][2] = 9'd3;
assign t_offset[0][3] = 9'd105;
assign t_offset[0][4] = 9'd210;
assign t_offset[1][0] = 9'd1;
assign t_offset[1][1] = 9'd300;
assign t_offset[1][2] = 9'd10;
assign t_offset[1][3] = 9'd45;
assign t_offset[1][4] = 9'd66;
assign t_offset[2][0] = 9'd190;
assign t_offset[2][1] = 9'd6;
assign t_offset[2][2] = 9'd171;
assign t_offset[2][3] = 9'd15;
assign t_offset[2][4] = 9'd253;
assign t_offset[3][0] = 9'd28;
assign t_offset[3][1] = 9'd55;
assign t_offset[3][2] = 9'd153;
assign t_offset[3][3] = 9'd21;
assign t_offset[3][4] = 9'd120;
assign t_offset[4][0] = 9'd91;
assign t_offset[4][1] = 9'd276;
assign t_offset[4][2] = 9'd231;
assign t_offset[4][3] = 9'd136;
assign t_offset[4][4] = 9'd78;

genvar i, j, k;
generate
for(i=0;i<5;i=i+1) begin: gen_a_rho_out_x
   for(j=0;j<5;j=j+1) begin: gen_a_rho_out_y
      for(k=0;k<64;k=k+1) begin: gen_a_rho_out_z
assign a_rho[i][j][k] = a_rho_in[i][j][mod64(k-t_offset[i][j])];
      end: gen_a_rho_out_z
   end: gen_a_rho_out_y
end: gen_a_rho_out_x
endgenerate

genvar m,n,o;
generate
for(m=0;m<5;m=m+1) begin: gen_a_pi_out_x
   for(n=0;n<5;n=n+1) begin: gen_a_pi_out_y
      for(o=0;o<64;o=o+1) begin: gen_a_pi_out_z
assign a_pi_out[m][n][o] = a_rho[mod5(m+3*n)][m][o];
      end: gen_a_pi_out_z
   end: gen_a_pi_out_y
end: gen_a_pi_out_x
endgenerate

endmodule
