module perm_theta
# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(
input  [Z_AXIS-1:0] a_theta_in  [X_AXIS-1:0][Y_AXIS-1:0],
output [Z_AXIS-1:0] a_theta_out [X_AXIS-1:0][Y_AXIS-1:0],
);

wire [Z_AXIS-1:0] c [X_AXIS-1:0];
wire [Z_AXIS-1:0] d [X_AXIS-1:0];
genvar i;
generate
for (i=0; i< X_AXIS-1; i=i+1)
assign c[i] = a_theta_in[i][0] ^ a_theta_in[i][1] ^ a_theta_in[i][2] ^ a_theta_in[i][3] ^ a_theta_in[i][4];
end
endgenerate

assign d[0] = c[4] ^ c[1]
assign d[1] = c[0] ^ c[2]
assign d[2] = c[1] ^ c[3]
assign d[3] = c[2] ^ c[4]
assign d[4] = c[3] ^ c[0]



endmodule
