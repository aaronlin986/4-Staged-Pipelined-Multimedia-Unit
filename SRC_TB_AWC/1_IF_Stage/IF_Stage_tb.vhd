-------------------------------------------------------------------------------
--
-- Title       : IF_Stage_tb
-- Design      : Instruction_Fetch
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\Instruction_Fetch\Instruction_Fetch\src\IF_Stage_tb.vhd
-- Generated   : Sat May  2 21:01:38 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description :  Testbench for the IF stage. After loading the Instruction Buffer with the instructions from the text file,
--	checks if the instructions from the buffer are being outputted at each clock cycle.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;   
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity IF_Stage_tb is
end IF_Stage_tb;

--}} End of automatically maintained section

architecture IF_Stage_tb of IF_Stage_tb is 	 
signal Instruction_Index : std_logic_vector(5 downto 0);
signal CLK : std_logic;
signal Instruction_Data, Instruction : std_logic_vector(24 downto 0);
constant period : time := 20ns;
begin

	uut : entity IF_Stage port map (Instruction_Index => Instruction_Index, CLK => CLK, Instruction_Data => Instruction_Data, Instruction => Instruction);
		
	store : process	
	file F : TEXT open READ_MODE is "ESE345_Assembler.txt";
	variable L : LINE;	 
	variable temp : std_logic_vector(24 downto 0);	
	variable count : unsigned(5 downto 0) := "000000";
	begin		    
	if not ENDFILE(F) then
			READLINE(F, L);
			READ(L, temp);	   
			Instruction_Data <= temp;
			Instruction_Index <= std_logic_vector(count);
			count := count + 1;
		end if;	 
		wait for period;
	end process;	 
	
	clk_process : process
	begin
		CLK <= '0';
		wait for period/2;
		CLK <= '1';
		wait for period/2;
	end process;

end IF_Stage_tb;
