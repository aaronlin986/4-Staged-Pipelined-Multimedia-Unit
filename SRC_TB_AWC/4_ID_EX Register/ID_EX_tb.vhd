-------------------------------------------------------------------------------
--
-- Title       : ID_EX_tb
-- Design      : ID_EX
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\ID_EX\ID_EX\src\ID_EX_tb.vhd
-- Generated   : Fri May  1 13:48:43 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the ID/EX register for storing the W_EN signal, registers A, B, C, and D, the data of 
--	registers A, B, and C, and ALUop. Checks if the correct value is outputted from the register each clock cycle.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.NUMERIC_STD.all;

entity ID_EX_tb is
end ID_EX_tb;

--}} End of automatically maintained section

architecture ID_EX_tb of ID_EX_tb is  
signal CLK, I_W_EN, O_W_EN : std_logic;
signal I_regA, I_regB, I_regC, I_regD, O_regA, O_regB, O_regC, O_regD : std_logic_vector(4 downto 0);
signal I_ALUop, O_ALUop : std_logic_vector(19 downto 0); 
signal I_regA_Data, I_regB_Data, I_regC_Data, O_regA_Data, O_regB_Data, O_regC_Data : std_logic_vector(127 downto 0);  
constant period : time := 20ns;
begin

	uut : entity ID_EX port map (CLK => CLK, I_W_EN => I_W_EN, O_W_EN => O_W_EN,
		I_regA => I_regA, I_regB => I_regB, I_regC => I_regC, I_regD => I_regD,
		O_regA => O_regA, O_regB => O_regB, O_regC => O_regC, O_regD => O_regD, I_ALUop => I_ALUop, O_ALUop => O_ALUop, 
		I_regA_Data => I_regA_Data, I_regB_Data => I_regB_Data, I_regC_Data => I_regC_Data,
		O_regA_Data => O_regA_Data, O_regB_Data => O_regB_Data, O_regC_Data => O_regC_Data);	
		
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
		
		I_W_EN <= '1';
		I_regA <= (others => '1');
		I_regB <= (3 downto 0 => '1', others => '0');
		I_regC <= (2 downto 0 => '1', others => '0');
		I_regD <= (others => '0');
		I_ALUop <= (0 => '1', others => '0');
		I_regA_Data <= (1 => '1', others => '0');
		I_regB_Data <= (2 => '1', others => '0');
		I_regC_Data <= (3 => '1', others => '0');
		wait for period;  
		
		I_W_EN <= '0';
		I_regA <= (3 downto 0 => '1', others => '0');
		I_regB <= (2 downto 0 => '1', others => '0');
		I_regC <= (others => '0'); 
		I_regD <= (others => '1');
		I_ALUop <= (1 => '1', others => '0');
		I_regA_Data <= (4 => '1', others => '0');
		I_regB_Data <= (1 downto 0 => '1', others => '0');
		I_regC_Data <= (2 downto 0 => '1', others => '0');
		wait for period;
		
		I_W_EN <= '1';
		I_regA <= (2 downto 0 => '1', others => '0');
		I_regB <= (others => '0');
		I_regC <= (others => '1'); 
		I_regD <= (3 downto 0 => '1', others => '0');
		I_ALUop <= (2 => '1', others => '0');
		I_regA_Data <= (3 downto 0 => '1', others => '0');
		I_regB_Data <= (4 downto 0 => '1', others => '0');
		I_regC_Data <= (2 downto 1 => '1', others => '0');
		wait for period;
		
		I_W_EN <= '0';
		I_regA <= (others => '0');
		I_regB <= (others => '1');
		I_regC <= (3 downto 0 => '1', others => '0');
		I_regD <= (2 downto 0 => '1', others => '0');
		I_ALUop <= (3 => '1', others => '0');
		I_regA_Data <= (3 downto 2 => '1', others => '0');
		I_regB_Data <= (4 downto 3 => '1', others => '0');
		I_regC_Data <= (others => '0');
		wait for period;
		
		wait;
		
	end process;

end ID_EX_tb;
