-------------------------------------------------------------------------------
--
-- Title       : R3_5_tb
-- Design      : ALU
-- Author      : Aaron Lin and Hang Chen 
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\ALU\ALU\src\R3_5_tb.vhd
-- Generated   : Fri Apr 24 20:32:29 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the R3 00101 Instruction. Checks if the rightmost 32 bits of rs1 is copied to each of the 4 32 bits of result.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.all;

entity R3_5_tb is
end R3_5_tb;

--}} End of automatically maintained section

architecture R3_5_tb of R3_5_tb is
signal ALUop : std_logic_vector(19 downto 0);
signal Res, regA_Data, regB_Data, regC_Data : std_logic_vector(127 downto 0);
constant period : time := 20ns;
begin

	 uut : entity ALU
		port map (ALUop => ALUop, Res => Res, regA_Data => regA_Data, regB_Data => regB_Data, regC_Data => regC_Data);
	
	tb : process
	begin
		wait for period/2;
		
		ALUop <= "11XXX00101XXXXXXXXXX";	 
		
		regA_Data <= (31 downto 0 => '1', others => '0');	 
		wait for period;
		
		wait;  
	end process;

end R3_5_tb;
