module perm_theta
# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(
input  [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_theta_in,
output [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_theta_out
);
`include "../src/func.sv"

wire [X_AXIS-1:0][Z_AXIS-1:0] c;
wire [X_AXIS-1:0][Z_AXIS-1:0] d;
genvar i,j;
generate
for (i=0;i<X_AXIS-1;i=i+1) begin
   for (j=0;j<Z_AXIS-1;j=j+1) begin
assign c[i][j] = a_theta_in[i][0][j] ^ a_theta_in[i][1][j] ^ a_theta_in[i][2][j] ^ a_theta_in[i][3][j] ^ a_theta_in[i][4][j];
   end
end
endgenerate

//generate
//for (i=0; i< X_AXIS-1; i=i+1)
//assign c[i] = a_theta_in[i][0] ^ a_theta_in[i][1] ^ a_theta_in[i][2] ^ a_theta_in[i][3] ^ a_theta_in[i][4];
//end
//endgenerate

genvar k,l;
generate
for (k=0; k< X_AXIS; k=k+1) begin
   for (l=0; l< Z_AXIS; l=l+1) begin
assign d[k][l] = c[mod5(k-1)][l] ^ c[mod5(k+1)][mod64(l-1)];
   end
end
endgenerate

genvar m,n,o;
generate
for(m=0;m<Y_AXIS;m=m+1) begin
   for(n=0;n<X_AXIS;n=n+1) begin
      for(o=0;o<Z_AXIS;o=o+1) begin
assign a_theta_out = a_theta_in[n][m][o] ^ d[n][o];
      end
   end
end
endgenerate

//assign d[0] = c[4] ^ c[1]
//assign d[1] = c[0] ^ c[2]
//assign d[2] = c[1] ^ c[3]
//assign d[3] = c[2] ^ c[4]
//assign d[4] = c[3] ^ c[0]
//
//d[0][0]=c[4][0] ^ c[1][63]
//d[0][1]=c[4][1] ^ c[1][63]

endmodule
