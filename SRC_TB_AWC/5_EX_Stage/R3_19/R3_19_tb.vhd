-------------------------------------------------------------------------------
--
-- Title       : R3_19_tb
-- Design      : ALU
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\ALU\ALU\src\R3_19_tb.vhd
-- Generated   : Sat Apr 25 11:27:23 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the R3 10011 Instruction. Checks if the bitwise logical NAND is carried out correctly.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.all;

entity R3_19_tb is
end R3_19_tb;

--}} End of automatically maintained section

architecture R3_19_tb of R3_19_tb is 
signal ALUop : std_logic_vector(19 downto 0);
signal Res, regA_Data, regB_Data, regC_Data : std_logic_vector(127 downto 0);
constant period : time := 20ns;
begin

	 uut : entity ALU
		port map (ALUop => ALUop, Res => Res, regA_Data => regA_Data, regB_Data => regB_Data, regC_Data => regC_Data);
		
	tb : process
	begin
		wait for period/2;
		
		ALUop <= "11XXX10011XXXXXXXXXX";	 
		regB_Data <= (127 downto 96 => '1', 95 downto 64 => '1', 63 downto 32 => '0', 31 downto 0 => '0');
		regA_Data <= (127 downto 96 => '0', 95 downto 64 => '1', 63 downto 32 => '0', 31 downto 0 => '1');	  		
		wait for period;
		
		wait;  
	end process;

end R3_19_tb;
