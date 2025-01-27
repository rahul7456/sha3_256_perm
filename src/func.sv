function automatic [5:0] mod5(
input signed [5:0] a
);
// In verilog modulo of negative number is a negative number, unlike C.
// 5 is added to make it positive.
mod5 = (a%5<0)?(a%5+5):a%5;
endfunction

function automatic [127:0] mod64(
input signed [127:0] a
);
// In verilog modulo of negative number is a negative number, unlike C.
// 64 is added to make it positive.
mod64 = (a%64<0)?(a%64+64):a%64;
endfunction

// Calculate Round Constant(Algorithm 5). Taken from web.
// Input is number of permutation.
function automatic [63:0] rc(
input integer a
);
case(a)
   32'd0  : rc = 64'h0000000000000001;
   32'd1  : rc = 64'h0000000000008082;
   32'd2  : rc = 64'h800000000000808A;
   32'd3  : rc = 64'h8000000080008000;
   32'd4  : rc = 64'h000000000000808B;
   32'd5  : rc = 64'h0000000080000001;
   32'd6  : rc = 64'h8000000080008081;
   32'd7  : rc = 64'h8000000000008009;
   32'd8  : rc = 64'h000000000000008A;
   32'd9  : rc = 64'h0000000000000088;
   32'd10 : rc = 64'h0000000080008009;
   32'd11 : rc = 64'h000000008000000A;
   32'd12 : rc = 64'h000000008000808B;
   32'd13 : rc = 64'h800000000000008B;
   32'd14 : rc = 64'h8000000000008089;
   32'd15 : rc = 64'h8000000000008003;
   32'd16 : rc = 64'h8000000000008002;
   32'd17 : rc = 64'h8000000000000080;
   32'd18 : rc = 64'h000000000000800A;
   32'd19 : rc = 64'h800000008000000A;
   32'd20 : rc = 64'h8000000080008081;
   32'd21 : rc = 64'h8000000000008080;
   32'd22 : rc = 64'h0000000080000001;
   32'd23 : rc = 64'h8000000080008008;
   default: rc = 64'h0000000000000000;
endcase
endfunction
