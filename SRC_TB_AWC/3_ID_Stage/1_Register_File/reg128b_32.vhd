-------------------------------------------------------------------------------
--
-- Title       : reg128b_32
-- Design      : register_128b
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\register_128b\register_128b\src\reg128b_32.vhd
-- Generated   : Mon Apr 20 12:01:06 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 32 128 bits Register File that reads on a rising clock edge, and writes on a rising clock edge and W_EN on high.
--	3 registers can be read at a time, while 1 can be written to.
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.NUMERIC_STD.all;

entity reg128b_32 is
	 port(
		 CLK : in STD_LOGIC;
		 W_EN : in STD_LOGIC;
		 I_regA : in STD_LOGIC_VECTOR(4 downto 0);
		 I_regB : in STD_LOGIC_VECTOR(4 downto 0);	
		 I_regC : in STD_LOGIC_VECTOR(4 downto 0);
		 I_regD : in STD_LOGIC_VECTOR(4 downto 0);
		 I_DataIn : in STD_LOGIC_VECTOR(127 downto 0);
		 O_regA : out STD_LOGIC_VECTOR(127 downto 0);
		 O_regB : out STD_LOGIC_VECTOR(127 downto 0);
		 O_regC : out STD_LOGIC_VECTOR(127 downto 0)
	     );
end reg128b_32;

--}} End of automatically maintained section

architecture reg128b_32 of reg128b_32 is  
	
begin								 
	process(CLK)  
	type stor is array (0 to 31) of std_logic_vector(127 downto 0);
	variable reg: stor := (others => X"00000000000000000000000000000000");
	begin
		if rising_edge(CLK) then 
			if W_EN = '1' then
				reg(to_integer(unsigned(I_regD))) := I_DataIn;
			end if;
			O_regA <= reg(to_integer(unsigned(I_regA)));
			O_regB <= reg(to_integer(unsigned(I_regB)));
			O_regC <= reg(to_integer(unsigned(I_regC)));
			
		end if;
	end process;
end reg128b_32;
