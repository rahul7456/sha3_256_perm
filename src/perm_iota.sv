module perm_iota
(
input  [5-1:0][5-1:0][64-1:0] a_iota_in,
output [5-1:0][5-1:0][64-1:0] a_iota_out,
input  [31:0] perm_num
);
`include "func.sv"

genvar i, j, k;
generate
for(i=0;i<5;i=i+1) begin: gen_a_iota_out_x
   for(j=0;j<5;j=j+1) begin: gen_a_iota_out_y
      if(i == 0 && j == 0)
assign a_iota_out[0][0] = a_iota_in[0][0] ^ rc(perm_num);
      else
assign a_iota_out[i][j] = a_iota_in[i][j];
   end: gen_a_iota_out_y
end: gen_a_iota_out_x
endgenerate

endmodule
