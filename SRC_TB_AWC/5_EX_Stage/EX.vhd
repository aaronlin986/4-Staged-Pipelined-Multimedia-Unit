-------------------------------------------------------------------------------
--
-- Title       : EX
-- Design      : EX
-- Author      : Aaron Lin and Hang Chen	
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\my_designs\EX\EX\src\EX.vhd
-- Generated   : Tue Apr 28 12:57:47 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This is the top level design for the EX stage. It consists of the Forwarding Muxes and the ALU.
--
-------------------------------------------------------------------------------
library work;
use work.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity EX is
	 port(
		 Mux1_Selector : in STD_LOGIC;
		 Mux2_Selector : in STD_LOGIC;
		 Mux3_Selector : in STD_LOGIC;
		 I_regA : in STD_LOGIC_VECTOR(127 downto 0);
		 I_regB : in STD_LOGIC_VECTOR(127 downto 0);
		 I_regC : in STD_LOGIC_VECTOR(127 downto 0);
		 I_forward : in STD_LOGIC_VECTOR(127 downto 0);
		 Res : out STD_LOGIC_VECTOR(127 downto 0);
		 ALUop : in STD_LOGIC_VECTOR(19 downto 0)
	     );
end EX;

--}} End of automatically maintained section

architecture EX of EX is   
signal O_regA_Inter, O_regB_Inter, O_regC_Inter : std_logic_vector(127 downto 0);
begin
	
	 u1 : entity Forwarding_Muxes port map (Mux1_Select => Mux1_Selector, Mux2_Select => Mux2_Selector, Mux3_Select => Mux3_Selector, 
		I_regA => I_regA, I_regB => I_regB, I_regC => I_regC, I_forward => I_forward, O_mux1 => O_regC_Inter, O_mux2 => O_regB_Inter, O_mux3 => O_regA_Inter);
	 u2 : entity ALU port map (ALUop => ALUop, Res => Res, regA_Data => O_regA_Inter, regB_Data => O_regB_Inter, regC_Data => O_regC_Inter);

end EX;
