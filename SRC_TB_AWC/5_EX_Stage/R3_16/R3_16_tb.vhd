-------------------------------------------------------------------------------
--
-- Title       : R3_16_tb
-- Design      : ALU
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\ALU\ALU\src\R3_16_tb.vhd
-- Generated   : Sat Apr 25 00:26:29 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the R3 10000 Instruction. Checks if packed unsigned subtraction is carried out correctly without correction
-- 	for underflows. Each of the 8 16 bit fields are tested.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity R3_16_tb is
end R3_16_tb;

--}} End of automatically maintained section

architecture R3_16_tb of R3_16_tb is 
signal ALUop : std_logic_vector(19 downto 0);
signal Res, regA_Data, regB_Data, regC_Data : std_logic_vector(127 downto 0);
constant period : time := 20ns;
begin

	uut : entity ALU
		port map (ALUop => ALUop, Res => Res, regA_Data => regA_Data, regB_Data => regB_Data, regC_Data => regC_Data);
		
	tb : process
	begin
		wait for period/2;
		
		ALUop <= "11XXX10000XXXXXXXXXX";	 
		
		--31 downto 16 tests (3 - maximum); 15 downto 0 tests (maximum - 3)
		regB_Data <= (17 downto 16 => '1', 15 downto 0 => '1', others => '0');
		regA_Data <= (31 downto 16 => '1', 1 downto 0 => '1', others => '0');
		wait for period;  
		
		--63 downto 48 tests (3 - maximum); 47 downto 32 tests (maximum - 3)
		regB_Data <= (49 downto 48 => '1',  47 downto 32 => '1', others => '0');
		regA_Data <= (63 downto 48 => '1', 33 downto 32 => '1', others => '0');
		wait for period;
		
		
		--95 downto 80 tests (3 - maximum); 79 downto 64 tests (maximum - 3)
		regB_Data <= (81 downto 80 => '1', 79 downto 64 => '1', others => '0');
		regA_Data <= (95 downto 80 => '1', 65 downto 64 => '1', others => '0');
		wait for period;  
		
		--127 downto 112 tests (3 - maximum); 111 downto 96 tests (maximum - 3)
		regB_Data <= (113 downto 112 => '1',  111 downto 96 => '1', others => '0');
		regA_Data <= (127 downto 112 => '1', 97 downto 96 => '1', others => '0');
		wait for period;  	
		
		wait;  
	end process;

end R3_16_tb;
