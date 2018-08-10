`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2018 02:48:06 PM
// Design Name: 
// Module Name: delay
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module delay(
    in, out, reset, clk, en, nodelay
    );
parameter bit = 5;
parameter delaytime = 30;
input in;
input clk;
input reset;
input en;
input nodelay;
output wire out;

reg [bit - 1:0] delay;

wire checkdelay = delay == delaytime;
assign out = nodelay ? in : en ? (in && checkdelay) : 0;

always @ (posedge clk) begin
    if(reset || !en) delay <= 0;
    else if(delay != delaytime) delay <= delay + 1;
end

endmodule
