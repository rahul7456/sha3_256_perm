function [2:0] mod5(
input [2:0] a
);
mod5 = (a%5<0)?(a%5+5):a%5;
endfunction

function [127:0] mod64(
input [127:0] a
);
mod64 = (a%64<0)?(a%64+64):a%64;
endfunction
