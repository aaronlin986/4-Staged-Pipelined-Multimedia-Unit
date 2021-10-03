-------------------------------------------------------------------------------
--
-- Title       : IF_ID_tb
-- Design      : IF_ID
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\IF_ID\IF_ID\src\IF_ID_tb.vhd
-- Generated   : Fri May  1 11:58:58 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the single 25 bit register for storing the Instruction from the IF stage. Checks if the correct value is 
-- 	outputted from the register each clock cycle.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.NUMERIC_STD.all;

entity IF_ID_tb is
end IF_ID_tb;

--}} End of automatically maintained section

architecture IF_ID_tb of IF_ID_tb is  
signal I_Instruction, O_Instruction : std_logic_vector(24 downto 0);
signal CLK : std_logic;
constant period : time := 20ns;
begin
	
	uut : entity IF_ID
		port map (CLK => CLK, I_Instruction => I_Instruction, O_Instruction => O_Instruction);
		
		
	clk_process : process
	begin			 
		CLK <= '0';
		wait for period/2;
		CLK <= '1';
		wait for period/2;
	end process;  
	
	tb : process
	begin
		wait for period/2;
		
		I_Instruction <= (others => '1');
		wait for period;  
		
		I_Instruction <= (24 downto 13 => '1', others => '0');
		wait for period;
		
		I_Instruction <= (12 downto 0 => '1', others => '0');
		wait for period;
		
		I_Instruction <= (others => '0');
		wait for period;
		
		wait;
		
	end process;	
end IF_ID_tb;
