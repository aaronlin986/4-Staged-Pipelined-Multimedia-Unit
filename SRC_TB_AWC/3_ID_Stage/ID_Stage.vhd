-------------------------------------------------------------------------------
--
-- Title       : ID_Stage
-- Design      : ID_Stage
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\ID_Stage\ID_Stage\src\ID_Stage.vhd
-- Generated   : Sun May  3 13:24:39 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is the top level design of the ID stage. It consists of the control unit and the register file.
--
-------------------------------------------------------------------------------
library work;
use work.all; 
library IEEE; 
use IEEE.std_logic_1164.all;  
use IEEE.NUMERIC_STD.all;

entity ID_Stage is
	 port(
		 CLK : in STD_LOGIC;
		 I_W_EN : in STD_LOGIC;
		 O_W_EN : out STD_LOGIC;
		 I_regD : in STD_LOGIC_VECTOR(4 downto 0);
		 O_regD : out STD_LOGIC_VECTOR(4 downto 0);
		 O_ALUop : out STD_LOGIC_VECTOR(19 downto 0);
		 I_DataIn : in STD_LOGIC_VECTOR(127 downto 0);
		 Instruction : in STD_LOGIC_VECTOR(24 downto 0);
		 O_regA_Data : out STD_LOGIC_VECTOR(127 downto 0);
		 O_regB_Data : out STD_LOGIC_VECTOR(127 downto 0);
		 O_regC_Data : out STD_LOGIC_VECTOR(127 downto 0);
		 O_regA : out std_logic_vector(4 downto 0);
		 O_regB : out std_logic_vector(4 downto 0);	
		 reg1 : out std_logic_vector(127 downto 0);
		 O_regC : out std_logic_vector(4 downto 0)
	     );
end ID_Stage;

--}} End of automatically maintained section

architecture ID_Stage of ID_Stage is   
signal Register_Select : std_logic_vector(4 downto 0) := "00000";	 
signal register_Mux : std_logic := '0';
begin

	u0 : entity Register_Mux port map (Output => Register_Select, Input0 => Instruction(9 downto 5), Input1 => Instruction(4 downto 0),
		Selector => register_Mux); 
		
	u1 : entity reg128b_32 port map (CLK => CLK, W_EN => I_W_EN, I_regA => Register_Select, I_regB => Instruction(14 downto 10), 
		I_regC => Instruction(19 downto 15), I_regD => I_regD, I_DataIn => I_DataIn, O_regA => O_regA_Data, O_regB => O_regB_Data, O_regC => O_regC_Data);
	
	u2: entity decoder port map (CLK => CLK, Instruction1 => Instruction(24 downto 23), Instruction2 => Instruction(18 downto 15), W_EN => O_W_EN, register_Mux => register_Mux);
	O_regD <= Instruction(4 downto 0);
	O_ALUop <= Instruction(24 downto 5);
	O_regA <= Register_Select;
	O_regB <= Instruction(14 downto 10);
	O_regC <= Instruction(19 downto 15);

end ID_Stage;
