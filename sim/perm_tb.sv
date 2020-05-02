module perm_tb();
reg clk;
reg reset;

reg  [2:0] dix;
reg  [199:0] din;
reg  pushin;

wire [2:0] doutix;
wire [199:0] dout;
wire pushout;

perm u_perm (.*);

initial begin
   clk=0;
   forever #5 clk=~clk;
end

initial begin
   reset = 1;
   dix = 0;
   din = 0;
   pushin = 0;
   #20;
   reset = 0;
   #33;
   @(posedge clk);
   pushin = 1;
   dix = 0;
   din = 200'h60a636261;
   @(posedge clk);
   pushin = 1;
   dix = 1;
   din = 0;
   @(posedge clk);
   pushin = 1;
   dix = 2;
   din = 0;
   @(posedge clk); //
   pushin = 0;//
   @(posedge clk);//
   @(posedge clk);
   pushin = 1;
   dix = 3;
   din = 0;
   @(posedge clk);
   pushin = 1;
   dix = 4;
   din = 0;
   @(posedge clk);
   pushin = 1;
   dix = 5;
   din = 200'h8000000000000000000000;
   @(posedge clk);
   pushin = 1;
   dix = 6;
   din = 0;
   @(posedge clk);
   pushin = 1;
   dix = 7;
   din = 0;
   @(posedge clk);
   pushin = 0;
   dix = 0;
   #200;
   $finish;
end

initial begin
   $monitor("D%d = %h",doutix,dout);
end

initial begin
   $dumpfile("perm.vcd");
   $dumpvars(0);
end

endmodule

