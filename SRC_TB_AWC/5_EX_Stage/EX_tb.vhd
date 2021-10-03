-------------------------------------------------------------------------------
--
-- Title       : EX_tb
-- Design      : EX
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\EX\EX\src\EX_tb.vhd
-- Generated   : Tue Apr 28 13:21:20 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the EX stage. Tests the some of the ALU's capability of 29 Instructions. Also tests if the correct input is passed
--	to the ALU inputs depending on the forwarding selector bits.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity EX_tb is
end EX_tb;

--}} End of automatically maintained section

architecture EX_tb of EX_tb is	
signal Mux1_Selector, Mux2_Selector, Mux3_Selector : std_logic;
signal I_regA, I_regB, I_regC, I_forward, Res : std_logic_vector(127 downto 0);
signal ALUop : std_logic_vector(19 downto 0);
constant period : time := 20ns;
begin

	uut : entity EX 
		port map (Mux1_Selector => Mux1_Selector, Mux2_Selector => Mux2_Selector, Mux3_Selector => Mux3_Selector, ALUop => ALUop,
		I_regA => I_regA, I_regB => I_regB, I_regC => I_regC, I_forward => I_forward, Res => Res);
		
	tb : process 
	begin  
		wait for period/2;	 
		
		--R3 5 Instruction
		ALUop <= "11XXX00101XXXXXXXXXX";	 
		--All muxes send regular output
		I_regA <= (31 downto 0 => '1', others => '0');
		I_regB <= (1 downto 0 => '1', others => '0'); 
		I_regC <= (0 => '1', others => '0');
		Mux1_Selector <= '0';
		Mux2_Selector <= '0';
		Mux3_Selector <= '0';
		I_forward <= std_logic_vector(to_unsigned(100, I_forward'length)); 		
		wait for period;
		
		--R4 2 Instruction
		ALUop <= "10010XXXXXXXXXXXXXXX";	 		
		--Mux1 forwards output
		I_forward <= std_logic_vector(to_unsigned(3, I_forward'length));
		Mux1_Selector <= '1';
		wait for period;
		
		--R4 4 Instruction
		ALUop <= "10100XXXXXXXXXXXXXXX";
		--Mux2 forwards output 
		I_regA <= (others => '0'); 
		I_forward <= std_logic_vector(to_unsigned(4, I_forward'length));
		Mux2_Selector <= '1';
		wait for period;
		
		--R3 3 Instruction
		ALUop <= "11XXX00011XXXXXXXXXX";
		--Mux3 forwards output 
		I_forward <= std_logic_vector(to_unsigned(5, I_forward'length));
		Mux3_Selector <= '1';	  
		wait for period;
		
		wait;  		
	end process;	

end EX_tb;
