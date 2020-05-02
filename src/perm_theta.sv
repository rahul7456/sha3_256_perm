module perm_theta
# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(
input  [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_theta_in,
output [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_theta_out
);
`include "func.sv"

wire [X_AXIS-1:0][Z_AXIS-1:0] c;
wire [X_AXIS-1:0][Z_AXIS-1:0] d;
genvar i,j;
generate
for (i=0;i<X_AXIS;i=i+1) begin: gen_c_x
   for (j=0;j<Z_AXIS;j=j+1) begin: gen_c_z
assign c[i][j] = a_theta_in[i][0][j] ^ a_theta_in[i][1][j] ^ a_theta_in[i][2][j] ^ a_theta_in[i][3][j] ^ a_theta_in[i][4][j];
   end: gen_c_z
end: gen_c_x
endgenerate

genvar k,l;
generate
for (k=0;k<X_AXIS;k=k+1) begin: gen_d_x
   for (l=0;l<Z_AXIS;l=l+1) begin: gen_d_z
assign d[k][l] = c[mod5(k-1)][l] ^ c[mod5(k+1)][mod64(l-1)];
//initial begin
//$display("d%d,%d  =  c%d,%d EXOR c%d,%d",k,l,mod5(k-1),l,mod5(k+1),mod64(l-1));
//end
   end: gen_d_z
end: gen_d_x
endgenerate

genvar m,n,o;
generate
for(m=0;m<X_AXIS;m=m+1) begin: gen_a_theta_out_x
   for(n=0;n<Y_AXIS;n=n+1) begin: gen_a_theta_out_y
      for(o=0;o<Z_AXIS;o=o+1) begin: gen_a_theta_out_z
assign a_theta_out[m][n][o] = a_theta_in[m][n][o] ^ d[m][o];
      end: gen_a_theta_out_z
   end: gen_a_theta_out_y
end: gen_a_theta_out_x
endgenerate

//initial begin
//   wait((dix == 7));
//      $display("C");
//      $display("%h %h %h %h %h",c[0],c[1],c[2],c[3],c[4]);
//      $display("%h %h %h %h %h",d[0],d[1],d[2],d[3],d[4]);
//end

endmodule
