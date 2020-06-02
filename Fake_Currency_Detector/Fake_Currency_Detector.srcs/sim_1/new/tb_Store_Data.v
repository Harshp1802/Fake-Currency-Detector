//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Fake Currency Detector: TEST BENCH
//
//(ES 203: Digital Systems Project, Prof. Joycee Mekie, IITGN)
//
//Create Date: 11/06/2019 01:41:37 AM
// Additional Comments:
//                      PLEASE GO THROUGH THE README FILE BEFORE UNDERSTANDING THE CODE !!!
//////////////////////////////////////////////////////////////////////////////////

module tb_StoreData(

    );
    reg clk ;
    wire chk ;
    initial
    begin
    clk=0;
    end
   always #5 clk = ~clk;
Store_Data init(.clk(clk), .chk(chk)) ;

endmodule
