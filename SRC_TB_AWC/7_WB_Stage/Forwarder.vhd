-------------------------------------------------------------------------------
--
-- Title       : Forwarder
-- Design      : Forwarder
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\Forwarder\Forwarder\src\Forwarder.vhd
-- Generated   : Thu Apr 30 22:29:54 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is the forwarding unit that determines if data from the WB stage needs to be forwarded to the ALU input for the
--	following instruction to use. It does this by checking the input registers of the instruction in the ALU and comparing them to the
--	register to be written to in the WB stage. 
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity Forwarder is
	 port(
		 W_EN : in STD_LOGIC;
		 Mux1_Selector : out STD_LOGIC;
		 Mux2_Selector : out STD_LOGIC;
		 Mux3_Selector : out STD_LOGIC;
		 regA : in STD_LOGIC_VECTOR(4 downto 0);
		 regB : in STD_LOGIC_VECTOR(4 downto 0);
		 regC : in STD_LOGIC_VECTOR(4 downto 0);
		 regD : in STD_LOGIC_VECTOR(4 downto 0)
	     );
end Forwarder;

--}} End of automatically maintained section

architecture Forwarder of Forwarder is
begin

	process(W_EN, regA, regB, regC, regD)
	begin
		if W_EN = '1' then
			if regD = regC then
				Mux1_Selector <= '1';	
			else
				Mux1_Selector <= '0';
			end if;	
			
			if regD = regB then
				Mux2_Selector <= '1';	
			else
				Mux2_Selector <= '0';
			end if;	
			
			if regD = regA then
				Mux3_Selector <= '1';	
			else
				Mux3_Selector <= '0';
			end if;	
		else   
			Mux1_Selector <= '0';
			Mux2_Selector <= '0';
			Mux3_Selector <= '0';				
		end if;
		end process;

end Forwarder;
