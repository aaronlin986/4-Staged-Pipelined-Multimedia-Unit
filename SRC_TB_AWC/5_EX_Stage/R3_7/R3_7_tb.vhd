-------------------------------------------------------------------------------
--
-- Title       : R3_7_tb
-- Design      : ALU
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\ALU\ALU\src\R3_7_tb.vhd
-- Generated   : Fri Apr 24 22:02:07 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the R3 00111 Instruction. Checks if the absolute value of the difference of each of the 16 8 bits is calculated 
--	correctly without correction for overflows and underflows. Cases in which the output is 128 are ignored.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.NUMERIC_STD.all;

entity R3_7_tb is
end R3_7_tb;

--}} End of automatically maintained section

architecture R3_7_tb of R3_7_tb is 
signal ALUop : std_logic_vector(19 downto 0);
signal Res, regA_Data, regB_Data, regC_Data : std_logic_vector(127 downto 0);
constant period : time := 20ns;
begin

	 uut : entity ALU
		port map (ALUop => ALUop, Res => Res, regA_Data => regA_Data, regB_Data => regB_Data, regC_Data => regC_Data);
			
	tb : process
	begin
		wait for period/2;
		
		ALUop <= "11XXX00111XXXXXXXXXX";	 
		
		regB_Data <= (127 => '1', 111 => '0', 110 downto 96 => '1', 95 downto 80 => '0', 65 downto 64 => '1', others => '0');
		regA_Data <= (127 downto 113 => '0', 112 => '1', 111 downto 97 => '1', 96 => '0', 81 downto 80 => '1', 79 downto 64 => '0', others => '0'); 	
		wait for period;	 
		
		regB_Data <= (63 => '1', 48 => '0', 47 downto 32 => '1', 31 downto 16 => '0', 1 downto 0 => '1', others => '0'); 
		regA_Data <= (63 downto 49 => '0', 48 => '1', 47 downto 33 => '1', 32 => '0', 17 downto 16 => '1', 15 downto 0 => '0', others => '0'); 	
		wait for period;
		
		wait;  
	end process;

end R3_7_tb;
