module perm_stage
# (
X_AXIS = 5,
Y_AXIS = 5,
Z_AXIS = 64
)(
input  clk,
input  reset,
input  stage_en,
input  [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_stage_in,
output reg [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_stage_out,
input  [31:0] perm_stage
);

wire [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_theta_out [2:0];
wire [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_rho_out [2:0];
wire [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_pi_out [2:0];
wire [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_chi_out [2:0];
wire [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_iota_out [2:0];

genvar i;
generate
for(i=0;i<3;i=i+1) begin
if(i == 0) begin
perm_theta #(X_AXIS, Y_AXIS, Z_AXIS) u_perm_theta (
.a_theta_in  (a_stage_in),
.a_theta_out (a_theta_out[i])
);
end else begin
perm_theta #(X_AXIS, Y_AXIS, Z_AXIS) u_perm_theta (
.a_theta_in  (a_iota_out[i-1]),
.a_theta_out (a_theta_out[i])
);
end

perm_rho #(X_AXIS, Y_AXIS, Z_AXIS) u_perm_rho (
.a_rho_in  (a_theta_out[i]),
.a_rho_out (a_rho_out[i])
);

perm_pi #(X_AXIS, Y_AXIS, Z_AXIS) u_perm_pi (
.a_pi_in  (a_rho_out[i]),
.a_pi_out (a_pi_out[i])
);

perm_chi #(X_AXIS, Y_AXIS, Z_AXIS) u_perm_chi (
.a_chi_in  (a_pi_out[i]),
.a_chi_out (a_chi_out[i])
);

perm_iota #(X_AXIS, Y_AXIS, Z_AXIS) u_perm_iota (
.a_iota_in  (a_chi_out[i]),
.a_iota_out (a_iota_out[i]),
.perm_num   (3*perm_stage+i)
);
end
endgenerate

always @(posedge clk or posedge reset) begin
   if(reset)
      a_stage_out <= 'b0;
   else begin
      if(stage_en)
         a_stage_out <= #1 a_iota_out[2];
   end
end

endmodule
