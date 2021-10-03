from tkinter import *
import re
from tkinter import filedialog, Text
import os.path
import sys
import tkinter as tk

filename = "ESE345_Assembler"
fileexists = False


def asmtoint(asm):
    asm_split = re.split(" |, |\(|\)", asm)

    args = []
    for i in range(len(asm_split)):
        if (asm_split[i] != ""):
            args.append(asm_split[i])
    # print args
    opcode = 0
    rd = 0
    rs1 = 0
    rs2 = 0
    imm = 0

    # 4.1
    # load immediate
    if(args[0].upper() == "LDI"):
        # li rd,index,imm
        if(len(args) != 4):
            return 0, 0, 0, 0, 0, 0
        rd = int(args[1][1:])
        index = int(args[2])
        imm = int(args[3])
        if(imm >= 0):
            immB = f'{imm:016b}'

        else:
            twos = f'{abs(imm)-1:016b}'
            hold1 = twos.replace('0', '2')
            hold0 = hold1.replace('1', '0')
            immB = hold0.replace('2', '1')

        rdB = f'{rd:05b}'
        indexB = f'{index:03b}'
        binary = '0' + indexB + immB + rdB
        # return both binary and indicator
        return binary
    # 4.2-------------------------------------------------------
    # Multiply-Add and Multiply-Subtract R4-Instruction Format
    # instruction destination, rs3,rs2,rs1
    elif(args[0].upper() == "SIMALS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 0
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    elif(args[0].upper() == "SIMAHS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 1
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    elif(args[0].upper() == "SIMSLS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 2
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    elif(args[0].upper() == "SIMSHS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 3
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    elif(args[0].upper() == "SLIMALS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 4
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    elif(args[0].upper() == "SLIMAHS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 5
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    elif(args[0].upper() == "SLIMSLS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 6
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    elif(args[0].upper() == "SLIMSHS"):
        if(len(args) != 5):
            return f'{0: 025b}'
        LSH = 7
        (rd, rs3, rs2, rs1) = parseM(args)
        return int2BinaryM(LSH, rd, rs3, rs2, rs1)

    # 4.3----------------------------------------------------------
    # R3-Instruction format： instruction rd, rs2,rs1
    elif(args[0].upper() == "NOP"):
        return f'{0:025b}'

    elif(args[0].upper() == "A"):
        if(len(args) != 4):
            return f'{0: 025b}'

        opcode = 1
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "AH"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 2
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "AHS"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 3
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "AND"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 4

        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    # r1 is used, r2 is omit
    elif(args[0].upper() == "BCW"):
        if(len(args) != 3):
            return f'{0: 025b}'
        opcode = 5
        rd = int(args[1][1:])
        rs2 = 0
        rs1 = int(args[2][1:])
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "CLZ"):
        if(len(args) != 3):
            return f'{0: 025b}'
        opcode = 6
        rd = int(args[1][1:])
        rs2 = int(0)
        rs1 = int(args[2][1:])
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "ABSDB"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 7
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "MPYU"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 8
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "MSGN"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 9
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "MPYU"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 10
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "OR"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 11
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "POPCNTW"):
        if(len(args) != 3):
            return f'{0: 025b}'
        opcode = 12
        rd = int(args[1][1:])
        rs2 = int(0)
        rs1 = int(args[2][1:])
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "ROT"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 13
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "ROTW"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 14
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "SHLHI"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 15
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "SFH"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 16
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "SFW"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 17
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "SFHS"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 18
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    elif(args[0].upper() == "NAND"):
        if(len(args) != 4):
            return f'{0: 025b}'
        opcode = 19
        (rd, rs2, rs1) = parseR(args)
        return int2BinaryR(opcode, rd, rs2, rs1)

    else:
        return f'{0: 025b}'

# 11 opcode rs2 rs1 rd


def int2BinaryR(opcode, rd, rs2, rs1):
    rdB = f'{rd:05b}'
    rs2B = f'{rs2:05b}'
    rs1B = f'{rs1:05b}'
    opcodeB = f'{opcode:08b}'
    return "11" + opcodeB + rs2B + rs1B + rdB

# 10 LSH rs3 rs2 rs1 rd


def int2BinaryM(LSH, rd, rs3, rs2, rs1):
    LSHB = f'{LSH:03b}'
    rdB = f'{rd:05b}'
    rs3B = f'{rs3:05b}'
    rs2B = f'{rs2:05b}'
    rs1B = f'{rs1:05b}'
    return "10" + LSHB + rs3B + rs2B + rs1B + rdB


def parseR(args):
    return (int(args[1][1:]), int(args[2][1:]), int(args[3][1:]))


def parseM(args):
    # rd , rs3, rs2, rs1
    return(int(args[1][1:]), int(args[2][1:]), int(args[3][1:]), int(args[4][1:]))


def decode(asm):
    # modify here to fit binary
    instruction = asmtoint(asm)
    return instruction


def exitApp():
    frame.destroy()
    sys.exit()


def compileASM():
    global filename
    binary_out = ""
    asm_in = textArea.get("1.0", END)
    asmlines = re.split("\n", asm_in)
    for i in range(len(asmlines)):
        if (asmlines[i] != ""):
            binary_out += decode(asmlines[i]) + "\n"

    # store binary output to file
    name, ext = os.path.splitext(filename)
    binaryfilename = name + ".txt"
    binaryfile = open(binaryfilename, "w")
    binaryfile.seek(0)
    binaryfile.truncate()
    binaryfile.write(binary_out)
    binaryfile.close()


Tk().withdraw()
frame = Toplevel()

scrollbar = Scrollbar(frame)
scrollbar.pack(side=RIGHT, fill=Y)
frame.title("ESE345 Assembler [" + filename + "]")
textArea = Text(frame, height=30, width=100, padx=3,
                pady=3, yscrollcommand=scrollbar.set)
textArea.pack(side=RIGHT)
scrollbar.config(command=textArea.yview)

# menu options
menubar = Menu(frame)
optionMenu = Menu(menubar, tearoff=0)
optionMenu.add_command(label="Compile", command=compileASM)
optionMenu.add_command(label="Exit", command=exitApp)
menubar.add_cascade(label="Options", menu=optionMenu)


frame.config(menu=menubar)
frame.minsize(750, 450)
frame.maxsize(750, 450)
frame.mainloop()
