module perm_rho 
# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(
input [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_rho_in,
input [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_rho_out
);
`include "func.sv"

wire [X_AXIS-1:0][Y_AXIS-1:0][8:0] t_offset;

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
for(i=0;i<X_AXIS;i=i+1) begin
   for(j=0;j<Y_AXIS;j=j+1) begin
      for(k=0;k<Z_AXIS;k=k+1) begin
assign a_rho_out[i][j][k] = a_rho_in[i][j][mod64(k-t_offset[i][j])];
      end
   end
end
endgenerate

endmodule
