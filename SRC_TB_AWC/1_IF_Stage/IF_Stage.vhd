-------------------------------------------------------------------------------
--
-- Title       : IF_Stage
-- Design      : Instruction_Fetch
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\Instruction_Fetch\Instruction_Fetch\src\IF_Stage.vhd
-- Generated   : Sat May  2 14:07:32 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is the top level design for the IF stage. It consists of the PC, PC Adder, and the Instruction Buffer.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity IF_Stage is
	 port(
		 CLK : in STD_LOGIC;
		 Instruction_Data : in std_logic_vector(24 downto 0);
		 Instruction_Index : in std_logic_vector(5 downto 0);
		 Instruction : out STD_LOGIC_VECTOR(24 downto 0)
	     );
end IF_Stage;

--}} End of automatically maintained section

architecture IF_Stage of IF_Stage is
signal I_PC, address : std_logic_vector(5 downto 0);
begin

	u1 : entity PC port map (CLK => CLK, PC_Next => I_PC, PC => address);
	u2 : entity PC_Incrementer port map (PC => address, PC_Next => I_PC);
	u3 : entity Instruction_Buffer port map (Instruction_Index => Instruction_Index, CLK => CLK, PC => address, Instruction => Instruction, Instruction_Data => Instruction_Data);
end IF_Stage; 


