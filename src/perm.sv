module perm 
#(
parameter X_AXIS = 5,
          Y_AXIS = 5,
          Z_AXIS = 64
)(
input clk,
input reset,

input  [2:0] dix,
input  [199:0] din,
input  pushin,

output [2:0] doutix,
output [199:0] dout,
output pushout
);

reg [1599:0] s;
reg [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] avec;

genvar i;
generate
for (i=0; i<8; i=i+1) begin
always @(posedge clk or posedge reset) begin
   if(reset)
      s[(200+(200*i))-1:200*i] <= 0;
   else begin
      if(pushin && (dix == i))
         s[(200+(200*i))-1:200*i] <= din;
   end
end
end
endgenerate

genvar j;
generate
for (j=0; j<(X_AXIS-1); j=j+1) begin
   assign avec[j][0] = s[64+(64*j)-1:64*j];
   assign avec[j][1] = s[320+64+(64*j)-1:320+(64*j)];
   assign avec[j][2] = s[640+64+(64*j)-1:640+(64*j)];
   assign avec[j][3] = s[960+64+(64*j)-1:960+(64*j)];
   assign avec[j][4] = s[1280+64+(64*j)-1:1280+(64*j)];
end
endgenerate

perm_theta #(X_AXIS, Y_AXIS, Z_AXIS) (
.a_theta_in  (avec),
.a_theta_out ()
);

endmodule
