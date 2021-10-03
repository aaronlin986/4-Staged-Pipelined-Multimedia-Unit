-------------------------------------------------------------------------------
--
-- Title       : IF_ID
-- Design      : IF_ID
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\IF_ID\IF_ID\src\IF_ID.vhd
-- Generated   : Fri May  1 11:45:22 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Single 25 bit register for storing Instruction between IF and ID stage.
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID is
	 port(
		 CLK : in STD_LOGIC;
		 I_Instruction : in STD_LOGIC_VECTOR(24 downto 0);
		 O_Instruction : out STD_LOGIC_VECTOR(24 downto 0)
	     );
end IF_ID;

--}} End of automatically maintained section

architecture IF_ID of IF_ID is	
begin	
	process(CLK)	 
	variable reg : std_logic_vector(24 downto 0) := (others => '0');
	begin 
		if rising_edge(CLK) then 
			reg := I_Instruction;	
			O_Instruction <= reg;		
		end if;  
	end process;
end IF_ID;
