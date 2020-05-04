module perm_theta
(
input  [5-1:0][5-1:0][64-1:0] a_theta_in,
output [5-1:0][5-1:0][64-1:0] a_theta_out
);
`include "func.sv"

wire [5-1:0][64-1:0] c;
wire [5-1:0][64-1:0] d;
genvar i,j;
generate
for (i=0;i<5;i=i+1) begin: gen_c_x
   for (j=0;j<64;j=j+1) begin: gen_c_z
assign c[i][j] = a_theta_in[i][0][j] ^ a_theta_in[i][1][j] ^ a_theta_in[i][2][j] ^ a_theta_in[i][3][j] ^ a_theta_in[i][4][j];
   end: gen_c_z
end: gen_c_x
endgenerate

genvar k,l;
generate
for (k=0;k<5;k=k+1) begin: gen_d_x
   for (l=0;l<64;l=l+1) begin: gen_d_z
assign d[k][l] = c[mod5(k-1)][l] ^ c[mod5(k+1)][mod64(l-1)];
   end: gen_d_z
end: gen_d_x
endgenerate

genvar m,n,o;
generate
for(m=0;m<5;m=m+1) begin: gen_a_theta_out_x
   for(n=0;n<5;n=n+1) begin: gen_a_theta_out_y
      for(o=0;o<64;o=o+1) begin: gen_a_theta_out_z
assign a_theta_out[m][n][o] = a_theta_in[m][n][o] ^ d[m][o];
      end: gen_a_theta_out_z
   end: gen_a_theta_out_y
end: gen_a_theta_out_x
endgenerate

endmodule
