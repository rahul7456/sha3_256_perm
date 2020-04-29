module perm_iota 
# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(
input [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_iota_in,
input [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_iota_out
);
`include "func.sv"

wire [X_AXIS-1:0][Y_AXIS-1:0][63:0] rc;

//assign rc[0][0] = 64'h0000000000000001;
//assign rc[0][1] = 64'h0000000000008082;
//assign rc[0][2] = 64'h800000000000808A;
//assign rc[0][3] = 64'h8000000080008000;
//assign rc[0][4] = 64'h000000000000808B;
//assign rc[1][0] = 64'h0000000080000001;
//assign rc[1][1] = 64'h8000000080008081;
//assign rc[1][2] = 64'h8000000000008009;
//assign rc[1][3] = 64'h000000000000008A;
//assign rc[1][4] = 64'h0000000000000088;
//assign rc[2][0] = 64'h0000000080008009;
//assign rc[2][1] = 64'h000000008000000A;
//assign rc[2][2] = 64'h000000008000808B;
//assign rc[2][3] = 64'h800000000000008B;
//assign rc[2][4] = 64'h8000000000008089;
//assign rc[3][0] = 64'h8000000000008003;
//assign rc[3][1] = 64'h8000000000008002;
//assign rc[3][2] = 64'h8000000000000080;
//assign rc[3][3] = 64'h000000000000800A;
//assign rc[3][4] = 64'h800000008000000A;
//assign rc[4][0] = 64'h8000000080008081;
//assign rc[4][1] = 64'h8000000000008080;
//assign rc[4][2] = 64'h0000000080000001;
//assign rc[4][3] = 64'h8000000080008008;
//assign rc[4][4] = 64'h;


genvar i, j, k;
generate
for(i=0;i<X_AXIS;i=i+1) begin
   for(j=0;j<Y_AXIS;j=j+1) begin
      if(i == 0 && j == 0)
assign a_iota_out[0][0] = a_iota_in[0][0] ^ 64'h0000000000000001;
      else
assign a_iota_out[i][j] = a_iota_in[i][j];
   end
end
endgenerate

endmodule
