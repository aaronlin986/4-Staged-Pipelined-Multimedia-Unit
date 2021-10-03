-------------------------------------------------------------------------------
--
-- Title       : Forwarder_tb
-- Design      : Forwarder
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\Forwarder\Forwarder\src\Forwarder_tb.vhd
-- Generated   : Thu Apr 30 22:43:54 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is the testbench for the Forwarding Unit. Checks if the correct Mux is triggered to select the forwarded output
--	from WB stage if the input registers to the ALU is the same as the register to be written in the WB stage.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.NUMERIC_STD.all;

entity Forwarder_tb is
end Forwarder_tb;

--}} End of automatically maintained section

architecture Forwarder_tb of Forwarder_tb is   
signal W_EN, Mux1_Selector, Mux2_Selector, Mux3_Selector : std_logic;
signal regA, regB, regC, regD : std_logic_vector(4 downto 0);
constant period : time := 20ns;
begin 
	
	uut : entity Forwarder port map (W_EN => W_EN, Mux1_Selector => Mux1_Selector, Mux2_Selector => Mux2_Selector, Mux3_Selector => Mux3_Selector,
		regA => regA, regB => regB, regC => regC, regD => regD);
		
	tb : process 
	begin
		wait for period/2;
		
		--No forwarding because prior instruction is not writing to register   
		regA <= (others => '1');
		regB <= (3 downto 0 => '1', others => '0');
		regC <= (others => '0');
		regD <= (others => '1');	
		W_EN <= '0';
		wait for period;
		
		--No forwarding	due to different registers being written back to and being used in ALU input 
	    W_EN <= '1';
		regD <= (1 => '1', others => '0');	  
		wait for period;
		
		--Forwarding to Mux1
		regD <= (others => '0');
		wait for period;	   
		
		--Forwarding to Mux2
		regD <= (3 downto 0 => '1', others => '0');
		wait for period;
		
		--Forwarding to Mux3
		regD <= (others => '1');
		wait for period;
		
		--Forwarding to Mux1 and Mux2
		regC <= (1 => '1', others => '0');
		regB <= (1 => '1', others => '0');
		regD <= (1 => '1', others => '0');
		wait for period;
		
		--Forwarding to Mux1 and Mux3
		regC <= (2 => '1', others => '0');
		regA <= (2 => '1', others => '0');
		regD <= (2 => '1', others => '0');	 
		wait for period;
		
		--Forwarding to Mux2 and Mux3
		regA <= (3 => '1', others => '0');
		regB <= (3 => '1', others => '0');
		regD <= (3 => '1', others => '0');
		wait for period;   
		
		--Forwarding to all 
		regC <= (4 => '1', others => '0');
		regB <= (4 => '1', others => '0');
		regA <= (4 => '1', others => '0');
		regD <= (4 => '1', others => '0');
		wait for period;   	
		
		wait;
		
	end process;
	
end Forwarder_tb;
