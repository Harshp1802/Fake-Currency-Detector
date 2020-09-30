hey please improve this project....

# Fake Currency Detector
(ES 203: Digital Systems Project, Prof. Joycee Mekie, IITGN)

# Introduction

Fake Currency Detection in Verilog using Basys3 FPGA and MATLAB.
In this project, we have implemented image processing operations
on a real currency note using MATLAB and have then sent the image in binary form to the FPGA Block Ram. This note is then used as a reference to compare few features that are present in the real notes with various fake notes which are processed into Verilog using read function. Then the final result is displayed onto the FPGA. 

We use Verilog as the hardware description language
and MATLAB for converting the given digital image into binary form.

# Block Memory
To feed the image into Verilog, we need to convert it to binary (.coe file).
We do that using MATLAB. We have processed it into BW scale. The converted image is such that it has as
many rows as the total number of pixels and the write depth is 1(Binary number). So our 256 x 144p note image will have 36864 rows.
Then a Block Memory Module is generated in the project which has as
many addresses as the number of rows. So, in our case, it will have 36864 address bits.

This Memory module, like other modules, can be instantiated and used
in the main module. The module has inputs as the clock, address, data_in, and read-write command and the data_out as output. So, for a given
address, it gives the douta at that address during that clock cycle. And
thus can give only one data set at a time (here one pixel).

For comparison with another note, we need multiple pixels at a time, that we access using a for loop on the
address.
## Background

Every currency note has certain common features such as the security thread consisting of black strips and the triangular IM (Identification mark) on an Rs. 100 note. These characteristics of the original note help to differentiate them from a fake one. Hence, we use a method to detect the absence of one or all of these features by firstly converting the note into the BW scale. Thus, there are three parts of the detection algorithm:
1) Scanning and Reading the currency note

2) Identifying its features:
* The triangular identification mark in a 100 rupee note.
* The vertical Security Thread.

3) Comparing it to an original one.


Verilog allows us to initialize memory from a text file with binary values:

$readmemb("fake.txt", memory_array, [start_address], [end_address])


## WorkFlow

1) Get the image of a real currency.

2) Process that image of the real note to a suitable form. [MATLAB]

  * Resizing: 256 x 144 pixels
  * RGB to B&W scale.


3) Store the real note and then further use it for comparison. [Generating .coe file and storing in B-RAM]

* Converted the text file to .coe file.
* Now, these values can be accessed one by one at every posedge into the module for comparison after instantiation of the BRAM.



4) Read and process the test notes and compare them with the original stored note.

5) Finally, declare it as either REAL or FAKE!! [Using 7-segment display on the FPGA]

Now, we have compared two currency notes, one stored on the Block-Ram (Original) and the other one read using $readmemb (Test Case).

The comparison algorithm for the two above mentioned features can be seen in the Verilog code. 

You can also have a look at the poster for a clear understanding.

## Acknowledgments

* We would like to thank the TAs for their constant guidance and also Prof. Joycee Mekie for having providing us an opportunity to work on this project.
