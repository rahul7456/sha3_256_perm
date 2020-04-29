module perm_pi# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(input  [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_pi_in,
  output [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_pi_out);
`include "func.sv"

genvar i,j,k;
generate
for(i=0;i<X_AXIS;i=i+1) begin
   for(j=0;j<Y_AXIS;j=j+1) begin
      for(k=0;k<Z_AXIS;k=k+1) begin
assign a_pi_out[i][j][k] = a_pi_in[mod5(i+3*j)][i][k];
      end
   end
end
endgenerate

endmodule