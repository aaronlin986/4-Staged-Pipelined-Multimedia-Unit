-------------------------------------------------------------------------------
--
-- Title       : EX_WB
-- Design      : EX_WB
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\EX_WB\EX_WB\src\EX_WB.vhd
-- Generated   : Fri May  1 14:30:19 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Register between EX and WB stage for storing the W_EN signal, result from ALU, and the register to write back to.
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity EX_WB is
	 port(
		 I_W_EN : in STD_LOGIC;
		 O_W_EN : out STD_LOGIC;
		 CLK : in STD_LOGIC;
		 I_Res : in STD_LOGIC_VECTOR(127 downto 0);
		 I_regD : in STD_LOGIC_VECTOR(4 downto 0);
		 O_Res : out STD_LOGIC_VECTOR(127 downto 0);
		 O_regD : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end EX_WB;

--}} End of automatically maintained section

architecture EX_WB of EX_WB is 
begin

	process(CLK)
	variable W_EN : std_logic := '0';
	variable Res : std_logic_vector(127 downto 0) := (others => '0');
	variable regD : std_logic_vector(4 downto 0) := (others => '0');
	begin
		if rising_edge(CLK) then
			W_EN := I_W_EN;
			Res := I_Res;
			regD := I_regD;
			O_W_EN <= W_EN;
			O_Res <= Res;
			O_regD <= regD;
		end if;
	end process;
end EX_WB;
