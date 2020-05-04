module perm_chi
(
input  [5-1:0][5-1:0][64-1:0] a_chi_in,
output [5-1:0][5-1:0][64-1:0] a_chi_out
);
  
`include "func.sv"

genvar i,j,k;
generate
  for(i=0;i<5;i=i+1) begin: gen_a_chi_out_x
    for(j=0;j<5;j=j+1)begin: gen_a_chi_out_y
      for(k=0;k<64;k=k+1) begin: gen_a_chi_out_z
assign  a_chi_out[i][j][k] = (a_chi_in[i][j][k] ^ ((a_chi_in[mod5(i+1)][j][k] ^ 1'b1) & a_chi_in[mod5(i+2)][j][k]));
      end: gen_a_chi_out_z
    end: gen_a_chi_out_y
  end: gen_a_chi_out_x
endgenerate
  
endmodule
