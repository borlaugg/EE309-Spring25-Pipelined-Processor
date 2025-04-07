## RISC Pipelined Processor

The document [ee309-project-doc.pdf](ee309-project-doc.pdf) contains the ISA to be followed. 

The skeleton code can be found in [src/](src/) where the [testbench](src/testbench.vhd) can be found. The top level entity is the [proc.vhd](src/proc.vhd) file which links all modules together. 
Inside the file, the module has ports to read and write data. The write port is used by the testbench to write data to the instruction memory and the read port is used to read data from the data
memory. 


You are free to modify the testbench to test your design. During evaluation, a mpodified testbench that contains a hidden sequence of instructions will be used and evaluation will be done on the 
contents of the data memory will be examined.  
