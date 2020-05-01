module perm_iota 
# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(
input  [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_iota_in,
output [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_iota_out,
input  [31:0] perm_num
);
`include "func.sv"

//wire [X_AXIS-1:0][Y_AXIS-1:0][63:0] rc;

genvar i, j, k;
generate
for(i=0;i<X_AXIS;i=i+1) begin
   for(j=0;j<Y_AXIS;j=j+1) begin
      if(i == 0 && j == 0)
assign a_iota_out[0][0] = a_iota_in[0][0] ^ rc(perm_num);
      else
assign a_iota_out[i][j] = a_iota_in[i][j];
   end
end
endgenerate

endmodule
