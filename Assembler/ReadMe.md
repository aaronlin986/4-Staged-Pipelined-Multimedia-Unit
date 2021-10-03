# This assembler convert instructions to 25 bits binary value.

## To run the assembler, double click the Assembler.exe

## To assemble the instruction to binary, click the "options" menu and click "compile"

## To exit the application, click the "options" menu then click "exit"

## The binary result will be written to a file name "ESE345_Assembler" under the same directory

---

### The instruction can be typed into the application's text area but strict syntax and spacing are required

#### To type a load immediate value

    - ldi rd, index, imm    noticed the spacing between each elements and comma
    - syntax such as: ldi rd,index,imm would not work and result will be complied to 0s

#### To type a Multiply-Add and Multiply-Subtract R4-Instruction Format

    - instruction rd, rs3, rs2, rs1  noticed the spacing between each elements and comma
    - syntax such as instruction rd,rs3,rs2,rs1 would not work and result will be complied to 0s

#### To type a R3-Instruction Format

    - instruction rd, rs2, rs1   noticed the spacing between each elements and comma
    - syntax such as instruction rd,rs3,rs2,rs1 would not work and result will be complied to 0s
