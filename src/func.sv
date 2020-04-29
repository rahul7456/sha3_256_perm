function [5:0] mod5(
input signed [5:0] a
);
mod5 = (a%5<0)?(a%5+5):a%5;
endfunction

function [127:0] mod64(
input signed [127:0] a
);
mod64 = (a%64<0)?(a%64+64):a%64;
endfunction
