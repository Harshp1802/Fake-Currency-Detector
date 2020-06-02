`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Fake Currency Detector
//
//(ES 203: Digital Systems Project, Prof. Joycee Mekie, IITGN)
//
//Create Date: 11/06/2019 01:41:37 AM
// Additional Comments:
//                      PLEASE GO THROUGH THE README FILE BEFORE UNDERSTANDING THE CODE !!!
//////////////////////////////////////////////////////////////////////////////////

// Here we have generated a module named Store_Data.

module Store_Data(
input clk,
output reg chk,
output reg [6:0]seg      
);

integer flag;
integer k,l ;
integer number = 0;
integer fakenumber = 0;
integer i,j;  
 
// Here we have generated a 2D Array named 'ram' that stores the binary values of the pre-processed image that is uploaded as a '.txt' file in the Simulation Sources. TEST CASES checked: 1) 100.txt (REAL), 2) fake.txt, 3) fake2.txt, 4) fake3.txt
 
reg [0:0] ram [0:143][0:255] ;

    initial
      begin
        $readmemb("fake3.txt", ram);// The text files are added into the Simulation Sources. To check, just change the name here.
      end
 

// Here we are generating an array that stores the binary values of the real currency note accessed from the BRAM.
reg store [0:36863];
wire douta;
wire dina;
reg [15:0] addra = 0;
integer count=-2; // This count starts from -2 because after storing the values in the 'ram', we realized that it lags around 2 clock cycles to access the value from the BRAM and store it into the array named 'store'.

//Instantiation the Block memory!!

 
blk_mem_gen_0 inst(
           .addra(addra),  
           .clka(clk),
           .dina(dina),
          .douta(douta),
          .ena(1),
          .wea(0)
        );
 

always@(posedge clk)
   
begin
  if(addra<36864) begin // As the values of addra change, the corresponding douta takes the value that lies at that particular address in the BRAM.
   
        store[count] = douta ;
        addra = addra + 1;
    //$display("value of douta is %d",store[count]);
        count = count +1;
        if (count == 36862) begin
        flag = 1;  // Here the flag variable is used. Since, at every posedge, only one value can be accessed from the BRAM, to do any process on the array named 'store', we need to wait until the all the values in the BRAM are accessed.
        end
        end
        store[36862] = 1;
        store[36863] = 1;
// Since count started from -2, the last values were to be stored manually.
end

// Now, till this point, we have the array named 'store' ready with all the values of the original image stored in it. And also, we have the test note stored in the 2D array named 'ram'.
 
//Furthernow, we will be doing the comparison:
 
 
  always @(flag) // Here this flag ensures that all the data from the BRAM is successfully accessed.
begin
 
//CHECKING THE Vertical STRIP:
     
      //This loop calulates the no. of zeroes(i.e. the number of black pixels on the Vertical Security Thread of the original 100 rupee note. 142 is the column which consists of the thread in the note.
     
     
for(k=0;k<144;k=k+1) begin
    if (store[142 + 256*k] == 0) begin
        number = number + 1;
        end
         
         
      //This loop calulates the no. of zeroes(i.e. the number of black pixels on the Vertical Security Thread of the TEST CASE note. 142 is the column which consists of the thread in the note.
         
         
         
    if (ram[k][142] == 0) begin
        fakenumber = fakenumber +1;
        end

end

// CHECKING the presence of the Identification Mark (Triangle in the 100 rupee note)
     
      // The following are the locations which needs to compared from both the notes for comparing the presence of the IM.
//       (230,80)
//      (232,77) to (232,80)
//      (236,77) to (236,80)
//       (238,80)
     
     
if (store[230 + 256*80] == ram[80][230] && store[20718]==ram[80][238]) begin
                for(l=0;l<4;l=l+1) begin
                    if( store[232+256*(77+l)] == ram[77+l][232] &&   store[236+256*(77+l)] == ram[77+l][236]) begin
                            if  (fakenumber < number + 3 && fakenumber > number - 3)begin
                                                         chk = 1; end
                                else begin
                                    chk = 0;
                                    end
                             end
               
                        else begin
                            chk = 0;
                        end
                end                
end
     
else begin
    chk = 0;
    end    
 //If any of the two the parameters do not satisfy the conditions,the note can be declared as fake.(If chk=0 FAKE,chk=1 REAL)
//To display the output on the 7-segment Display
     
   
if (chk == 1) begin
    seg = 7'b1001110;
    end

else if (chk == 0) begin
    seg = 7'b0001110;
    end

     
     
end

endmodule