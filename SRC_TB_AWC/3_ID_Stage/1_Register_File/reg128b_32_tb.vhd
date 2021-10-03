-------------------------------------------------------------------------------
--
-- Title       : reg128b_32_tb
-- Design      : register_128b
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\register_128b\register_128b\src\reg128b_32_tb.vhd
-- Generated   : Mon Apr 20 12:29:21 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the 32 128 bit registers. Tests if registers are written to when W_EN is low, if registers are written to when
--	W_EN is high, repeated again to see if multiple writes work, and if reads on the same register at the same time work.
--
-------------------------------------------------------------------------------	 
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.all;  
use IEEE.NUMERIC_STD.all;

entity reg128b_32_tb is
end reg128b_32_tb;

--}} End of automatically maintained section

architecture reg128b_32_tb of reg128b_32_tb is 
	signal CLK, W_EN : STD_LOGIC;
	signal I_regA, I_regB, I_regC, I_regD : STD_LOGIC_VECTOR(4 downto 0);
	signal I_DataIn, O_regA, O_regB, O_regC : STD_LOGIC_VECTOR(127 downto 0);
	constant period : time := 20ns;
begin

	uut : entity reg128b_32
		port map (CLK => CLK, W_EN => W_EN, 
		I_regA => I_regA, I_regB => I_regB, I_regC => I_regC, I_regD => I_regD, I_DataIn => I_DataIn, O_regA => O_regA, O_regB => O_regB, O_regC => O_regC);
		
		
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
		
		
		--Checks if registers are written to even though W_EN is low
		W_EN <= '0';
		I_regA <= std_logic_vector(to_unsigned(0, I_regA'length));
		I_regB <= std_logic_vector(to_unsigned(1, I_regB'length));
		I_regC <= std_logic_vector(to_unsigned(2, I_regC'length));
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));
		I_DataIn <= std_logic_vector(to_unsigned(100, I_DataIn'length)); 
		wait for period;											 
		
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length));
		wait for period;
		
		I_regD <= std_logic_vector(to_unsigned(2, I_regD'length));
		wait for period;
		
		--Checks if registerA is written to when W_EN is high 
		W_EN <= '1';  
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));
		wait for period; 
		
		--Checks if registerB is written to when W_EN is high
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length));	
		wait for period;
		
		--Checks if registerC is written to when W_EN is high
		I_regD <= std_logic_vector(to_unsigned(2, I_regD'length));
		wait for period;
		
		--Checks if registers are written again even when W_EN is low
		W_EN <= '0';
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));
		I_DataIn <= std_logic_vector(to_unsigned(1, I_DataIn'length));
		wait for period;
		
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length));
		I_DataIn <= std_logic_vector(to_unsigned(2, I_DataIn'length));
		wait for period;
		
		I_regD <= std_logic_vector(to_unsigned(2, I_regD'length));
		I_DataIn <= std_logic_vector(to_unsigned(3, I_DataIn'length)); 
		wait for period;  
		
		--Checks if registers are written to again when W_EN is high
		W_EN <= '1';	   
		I_DataIn <= std_logic_vector(to_unsigned(1, I_DataIn'length));
		wait for period;
				
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length));	
		I_DataIn <= std_logic_vector(to_unsigned(3, I_DataIn'length));
		wait for period; 	   
		
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));
		I_DataIn <= std_logic_vector(to_unsigned(2, I_DataIn'length));
		wait for period;	
		
		I_regD <= std_logic_vector(to_unsigned(100, I_regD'length));
		I_DataIn <= std_logic_vector(to_unsigned(16, I_DataIn'length));
		wait for period;
		
		--Read the same registers at the same time
		I_regA <= std_logic_vector(to_unsigned(100, I_regA'length));	
		I_regB <= std_logic_vector(to_unsigned(100, I_regB'length));
		I_regC <= std_logic_vector(to_unsigned(100, I_regC'length));
		
		wait;	
		end process;			
end reg128b_32_tb;
