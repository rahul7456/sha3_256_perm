module perm_stage
(
input  clk,
input  reset,
input  stage_en,
input  [5-1:0][5-1:0][64-1:0] a_stage_in,
output reg [5-1:0][5-1:0][64-1:0] a_stage_out,
input  [31:0] perm_stage
);

wire [5-1:0][5-1:0][64-1:0] a_theta_out [2:0];
wire [5-1:0][5-1:0][64-1:0] a_pi_out [2:0];
wire [5-1:0][5-1:0][64-1:0] a_chi_out [2:0];
wire [5-1:0][5-1:0][64-1:0] a_iota_out [2:0];

genvar i;
generate
for(i=0;i<3;i=i+1) begin: gen_perm_stage
if(i == 0) begin
perm_theta u_perm_theta (
.a_theta_in  (a_stage_in),
.a_theta_out (a_theta_out[i])
);
end else begin
perm_theta u_perm_theta (
.a_theta_in  (a_iota_out[i-1]),
.a_theta_out (a_theta_out[i])
);
end

perm_rho_pi u_perm_rho_pi (
.a_rho_in  (a_theta_out[i]),
.a_pi_out (a_pi_out[i])
);

perm_chi u_perm_chi (
.a_chi_in  (a_pi_out[i]),
.a_chi_out (a_chi_out[i])
);

perm_iota u_perm_iota (
.a_iota_in  (a_chi_out[i]),
.a_iota_out (a_iota_out[i]),
.perm_num   (3*perm_stage+i)
);
end: gen_perm_stage
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
