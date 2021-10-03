-------------------------------------------------------------------------------
--
-- Title       : EX_WB_tb
-- Design      : EX_WB
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\EX_WB\EX_WB\src\EX_WB_tb.vhd
-- Generated   : Fri May  1 14:34:57 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the EX/WB register for storing the W_EN signal, ALU result, and the register to write back to. 
--	Checks if the correct value is outputted from the register each clock cycle.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.NUMERIC_STD.all;

entity EX_WB_tb is
end EX_WB_tb;

--}} End of automatically maintained section

architecture EX_WB_tb of EX_WB_tb is	
signal CLK, I_W_EN, O_W_EN : std_logic;	 
signal I_Res, O_Res : std_logic_vector(127 downto 0);
signal I_regD, O_regD : std_logic_vector(4 downto 0);
constant period : time := 20ns;
begin

	uut : entity EX_WB port map (CLK => CLK, I_W_EN => I_W_EN, O_W_EN => O_W_EN, I_Res => I_Res, O_Res => O_Res, 
		I_regD => I_regD, O_regD => O_regD);
		
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
		I_Res <= (others => '1');
		I_regD <= (others => '1');
		wait for period;  
		
		I_W_EN <= '0';
		I_Res <= (127 downto 64 => '1', others => '0');
		I_regD <= (4 downto 3 => '1', others => '0');
		wait for period;
		
		I_W_EN <= '1';
		I_Res <= (63 downto 0 => '1', others => '0');
		I_regD <= (2 downto 0 => '1', others => '0');
		wait for period;
		
		I_W_EN <= '0';
		I_Res <= (others => '0');
		I_regD <= (others => '0');
		wait for period;
		
		wait;
		
	end process;

end EX_WB_tb;
