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
reg  [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] avec;
wire [X_AXIS-1:0][Y_AXIS-1:0][Z_AXIS-1:0] a_theta_out;

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

genvar x,y,z;
generate
for(x=0;x<X_AXIS;x=x+1) begin
   for(y=0;y<Y_AXIS;y=y+1) begin
      for(z=0;z<Z_AXIS;z=z+1) begin
assign avec[x][y][z] = s[64*(5*y+x)+z];
      end
   end
end
endgenerate

perm_theta #(X_AXIS, Y_AXIS, Z_AXIS) u_perm_theta (
.a_theta_in  (avec),
.a_theta_out (a_theta_out)
);


////// Remove for SYNTHESIS
initial begin
   wait(pushin && (dix == 7));
      $display("A");
      $display("%h %h %h %h %h",avec[0][0],avec[1][0],avec[2][0],avec[3][0],avec[4][0]);
      $display("%h %h %h %h %h",avec[0][1],avec[1][1],avec[2][1],avec[3][1],avec[4][1]);
      $display("%h %h %h %h %h",avec[0][2],avec[1][2],avec[2][2],avec[3][2],avec[4][2]);
      $display("%h %h %h %h %h",avec[0][3],avec[1][3],avec[2][3],avec[3][3],avec[4][3]);
      $display("%h %h %h %h %h",avec[0][4],avec[1][4],avec[2][4],avec[3][4],avec[4][4]);
end

initial begin
   wait(pushin && (dix == 7));
      $display("A Theta Out");
      $display("%h %h %h %h %h",a_theta_out[0][0],a_theta_out[1][0],a_theta_out[2][0],a_theta_out[3][0],a_theta_out[4][0]);
      $display("%h %h %h %h %h",a_theta_out[0][1],a_theta_out[1][1],a_theta_out[2][1],a_theta_out[3][1],a_theta_out[4][1]);
      $display("%h %h %h %h %h",a_theta_out[0][2],a_theta_out[1][2],a_theta_out[2][2],a_theta_out[3][2],a_theta_out[4][2]);
      $display("%h %h %h %h %h",a_theta_out[0][3],a_theta_out[1][3],a_theta_out[2][3],a_theta_out[3][3],a_theta_out[4][3]);
      $display("%h %h %h %h %h",a_theta_out[0][4],a_theta_out[1][4],a_theta_out[2][4],a_theta_out[3][4],a_theta_out[4][4]);
end
////// Remove for SYNTHESIS


endmodule
