function mod5(input [2:0] a);
reg [2:0] temp;
temp = a%5;
if(temp < 0)
   mod5 = temp + 5;
else
   mod5 = temp;
endfunction

function mod64(input [127:0] a);
reg [127:0] temp;
temp = a%64;
if(temp < 0)
   mod5 = temp + 64;
else
   mod5 = temp;
endfunction
