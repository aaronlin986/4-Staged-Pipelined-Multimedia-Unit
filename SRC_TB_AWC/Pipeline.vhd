-------------------------------------------------------------------------------
--
-- Title       : Pipeline
-- Design      : Pipeline
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\Pipeline\Pipeline\src\Pipeline.vhd
-- Generated   : Fri May  1 15:23:57 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is the top level design of the pipeline.
--				  
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity Pipeline is
	 port(	 
	 ALU_Output : out std_logic_vector(127 downto 0); 
	 Input_rs3 : out std_logic_vector(127 downto 0);
	 Input_rs2 : out std_logic_vector(127 downto 0);
	 Input_rs1 : out std_logic_vector(127 downto 0);
	 W_En_inWB : out std_logic;
	 Forward_Mux1 : out std_logic;
	 Forward_Mux2 : out std_logic;
	 Forward_Mux3 : out std_logic;	
	 Instruction_inIF : out std_logic_vector(24 downto 0);
	 Instruction_inID : out std_logic_vector(24 downto 0);
	 ALUop_inID : out std_logic_vector(7 downto 0);	
	 ALUop_inEX : out std_logic_vector(7 downto 0);
	 Data_inWB : out std_logic_vector(127 downto 0);
	 
	 Instruction_Index : in std_logic_vector(5 downto 0);
	 Instruction : in std_logic_vector(24 downto 0);
	 CLK : in STD_LOGIC 
	 );
end Pipeline;

--}} End of automatically maintained section

architecture Pipeline of Pipeline is 
signal Instruction_toReg, Instruction_toIF : std_logic_vector(24 downto 0); 
signal W_EN_toIDReg, W_EN_toEXReg, W_EN_toForwarder, forward_Selector1, forward_Selector2, forward_Selector3 : std_logic;	 	
signal regA_Data, regB_Data, regC_Data, ALU_regA, ALU_regB, ALU_regC, Res_toEXReg, forward_Data: std_logic_vector(127 downto 0);
signal regA_toIDReg, regB_toIDReg, regC_toIDReg, regD_toEXReg, regD_toIDReg, regD_WB, regA_Forward, regB_Forward, regC_Forward : std_logic_vector(4 downto 0);
signal data_WB : std_logic_vector(127 downto 0); 
signal ALUop_toIDReg, ALUop_toEX : std_logic_vector(19 downto 0); 
begin
	ALU_Output <= Res_toEXReg;	
	Input_rs3 <= ALU_regC;
	Input_rs2 <= ALU_regB;
	Input_rs1 <= ALU_regA;
	W_En_inWB <= W_EN_toForwarder;
	Forward_Mux1 <= forward_Selector1;
	Forward_Mux2 <=	forward_Selector2;
	Forward_Mux3 <=	forward_Selector3; 
	Instruction_inIF <= Instruction_toIF;
	Instruction_inID <= Instruction_toReg; 
	ALUop_inID <= ALUop_toIDReg(17 downto 10);
	ALUop_inEX <= ALUop_toEx(17 downto 10);	   
	Data_inWB <= data_WB;
	 
	
	u0 : entity IF_Stage port map (CLK => CLK, Instruction => Instruction_toIF, Instruction_Data => Instruction, Instruction_Index => Instruction_Index);
	u1 : entity IF_ID port map (CLK => CLK, I_Instruction => Instruction_toIF, O_Instruction => Instruction_toReg);	  
	
	u2 : entity ID_Stage port map (CLK => CLK, Instruction => Instruction_toReg, I_W_EN => W_EN_toForwarder, I_DataIn => data_WB, I_regD => regD_WB,
		O_ALUop => ALUop_toIDReg, O_regD => regD_toIDReg, O_W_EN => W_EN_toIDReg, O_regA_Data => regA_Data, O_regB_Data => regB_Data, 
		O_regC_Data => regC_Data, O_regA => regA_toIDReg, O_regB => regB_toIDReg, O_regC => regC_toIDReg); 
									  
	   
    u3 : entity ID_EX port map (CLK => CLK, I_W_EN => W_EN_toIDReg, I_regA => regA_toIDReg, 
		I_regB => regB_toIDReg, I_regC => regB_toIDReg, I_regD => regD_toIDReg,
		I_ALUop => ALUop_toIDReg, I_regA_Data => regA_Data, I_regB_Data => regB_Data, I_regC_Data => regC_Data, O_W_EN => W_EN_toEXReg, 
		O_regA => regA_Forward, O_regB => regB_Forward, O_regC => regC_Forward, O_regD => regD_toEXReg, O_ALUop => ALUop_toEX, 
		O_regA_Data => ALU_regA, O_regB_Data => ALU_regB, O_regC_Data => ALU_regC);
	
	u4 : entity EX port map (I_regA => ALU_regA, I_regB => ALU_regB, I_regC => ALU_regC, ALUop => ALUop_toEX, Res => Res_toEXReg,
		I_forward => forward_Data, Mux1_Selector => forward_Selector1, Mux2_Selector => forward_Selector2, Mux3_Selector => forward_Selector3);
		
	u5 : entity EX_WB port map (CLK => CLK, I_W_EN => W_EN_toEXReg, I_Res => Res_toEXReg, I_regD => regD_toEXReg, O_W_EN => W_EN_toForwarder,
		O_Res => data_WB, O_regD => regD_WB); 
	
	u6 : entity Forwarder port map (W_EN => W_EN_toForwarder, regA => regA_Forward, regB => regB_Forward, 
		regC => regC_Forward, regD => regD_WB, 
		Mux1_Selector => forward_Selector1, Mux2_Selector => forward_Selector2, Mux3_Selector => forward_Selector3);	
end Pipeline;
