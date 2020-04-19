perm_rho
#(
parameter X_AXIS = 5,
          Y_AXIS = 5,
          Z_AXIS = 64)
(
input [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_rho_in,
input [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_rho_out,
input [4:0] curr_stage
);
`include "func.sv"

wire [4:0] temp_curr_stage;
assign temp_curr_stage = ((curr_stage+1)(curr_stage+2))/2;

generate
for(i=0;i<X_AXIS;i=i+1) begin
   for(j=0;j<Y_AXIS;j=j+1) begin
      for(k=0;k<Z_AXIS;k=k+1) begin
assign a_rho_out[i][j][k] = a_rho_in[i][j][mod64(k-temp_curr_stage)];
      end
   end
end
endgenerate

endmodule
