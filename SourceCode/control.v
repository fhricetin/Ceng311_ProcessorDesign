module control(in, regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop1, aluop2,jump,benbvf);
input [5:0] in;
output regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, aluop1, aluop2,jump,benbvf;

wire rformat,lw,sw,beq;
wire j, addi,ben,bvf;


assign rformat =~| in;

assign lw = in[5]& (~in[4])&(~in[3])&(~in[2])&in[1]&in[0];

assign sw = in[5]& (~in[4])&in[3]&(~in[2])&in[1]&in[0];

assign beq = (~in[5])& (~in[4])&(~in[3])&in[2]&(~in[1])&(~in[0]);

assign j = (~in[5])& (~in[4])&(~in[3])&(~in[2])&in[1]&(~in[0]);

assign addi = (~in[5])& (~in[4])& in[3]&(~in[2])&(~in[1])&(~in[0]);

assign ben = (~in[5])& (~in[4])&(~in[3])&in[2]&in[1]&(~in[0]);

assign bvf = (~in[5])& (~in[4])&(~in[3])&in[2]&(~in[1])&in[0];


assign regdest = rformat;

assign alusrc = lw|sw|addi; // if instruction is addi, alusrc will be set to 1 and alu takes sign extented value as a second input
assign memtoreg = lw;
assign regwrite = rformat|lw;
assign memread = lw;
assign memwrite = sw;
assign branch = beq|ben|bvf;  //if instruction is ben or bvf, branch will be set to 1. I use this to update pc.
assign aluop1 = rformat|addi; // if instruction is addi, aluop1 will be set to 1 and alucontrol decides which operation alu will take
assign aluop2 = beq;
assign jump = j;  // jump will be set to 1, and pc will be updated with new address
assign benbvf = ben|bvf; // if instruction is ben or bvf, i use this to update cprs in processor.

endmodule
