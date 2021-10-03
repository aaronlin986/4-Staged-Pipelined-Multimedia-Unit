-------------------------------------------------------------------------------
--
-- Title       : ID_Stage_tb
-- Design      : ID_Stage
-- Author      : Aaron Lin and Hang Chen
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : c:\my_designs\ID_Stage\ID_Stage\src\ID_Stage_tb.vhd
-- Generated   : Sun May  3 13:29:31 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Testbench for the ID stage. Tests if registers are written to when I_W_EN is low, if registers are written to when
--	I_W_EN is high, repeated again to see if multiple writes work, and if reads on the same register at the same time work.
--	Also, checks if the I_W_EN signal is asserted for the correct set of instructions.
--
-------------------------------------------------------------------------------
library work;
use work.all; 
library IEEE; 
use IEEE.std_logic_1164.all;   
use IEEE.NUMERIC_STD.all;

entity ID_Stage_tb is
end ID_Stage_tb;

--}} End of automatically maintained section

architecture ID_Stage_tb of ID_Stage_tb is  
signal CLK, I_W_EN, O_W_EN : std_logic;
signal I_DataIn, O_regA_Data, O_regB_Data, O_regC_Data : std_logic_vector(127 downto 0);
signal O_regA, O_regB, O_regC, O_regD, I_regD : std_logic_vector(4 downto 0);
signal O_ALUop : std_logic_vector(19 downto 0);
signal Instruction : std_logic_vector(24 downto 0);	
constant period : time := 20ns;
begin

	 uut : entity ID_Stage
		port map (CLK => CLK, I_W_EN => I_W_EN, O_W_EN => O_W_EN, O_ALUop => O_ALUop, O_regD => O_regD, I_regD => I_regD,
		I_DataIn => I_DataIn, Instruction => Instruction, O_regA => O_regA, O_regB => O_regB, O_regC => O_regC,
		O_regA_Data => O_regA_Data, O_regB_Data => O_regB_Data, O_regC_Data => O_regC_Data);
		
		
	clk_process : process
	begin			 
		CLK <= '0';
		wait for period/2;
		CLK <= '1';
		wait for period/2;
	end process;
			
	tb : process	 
	variable I_regA : std_logic_vector(4 downto 0);	
	variable I_regB : std_logic_vector(4 downto 0);
	variable I_regC : std_logic_vector(4 downto 0);
	variable regD : std_logic_vector(4 downto 0);
	begin					
		wait for period/2; 
		
		--Checks if registers are written to even though I_W_EN is low
		I_W_EN <= '0';		  
		I_regA := std_logic_vector(to_unsigned(0, I_regA'length));
		I_regB := std_logic_vector(to_unsigned(1, I_regB'length));
		I_regC := std_logic_vector(to_unsigned(2, I_regC'length));
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));
		Instruction(24 downto 20) <= "0XXXX";	
		Instruction(19 downto 15) <= I_regC;
		Instruction(14 downto 10) <= I_regB;
		Instruction(9 downto 5) <= I_regA;	
		Instruction(4 downto 0) <= (others => '1');
		I_DataIn <= std_logic_vector(to_unsigned(100, I_DataIn'length)); 
		wait for period;											 
		
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length));
		Instruction(4 downto 0) <= (4 => '1', others => '0');
		wait for period;
		
		I_regD <= std_logic_vector(to_unsigned(2, I_regD'length));
		Instruction(4 downto 0) <= (3 => '1', others => '0');
		wait for period;
		
		--Checks if registerA is written to when I_W_EN is high 
		I_W_EN <= '1';  
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));
		Instruction(4 downto 0) <= (2 => '1', others => '0');
		wait for period; 
		
		--Checks if registerB is written to when I_W_EN is high
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length)); 
		Instruction(4 downto 0) <= (1 => '1', others => '0');
		wait for period;
		
		--Checks if registerC is written to when I_W_EN is high	
		I_regD <= std_logic_vector(to_unsigned(2, I_regD'length));
		Instruction(4 downto 0) <= (others => '0');
		wait for period;
		
		--Checks if registers are written again even when I_W_EN is low
		I_W_EN <= '0';
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));	 
		Instruction(4 downto 0) <= (4 downto 3 => '1', others => '0');
		I_DataIn <= std_logic_vector(to_unsigned(1, I_DataIn'length));
		wait for period;
		
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length));	
		Instruction(4 downto 0) <= (3 downto 2 => '1', others => '0');
		I_DataIn <= std_logic_vector(to_unsigned(2, I_DataIn'length));
		wait for period;
		
		I_regD <= std_logic_vector(to_unsigned(2, I_regD'length));	 
		Instruction(4 downto 0) <= (2 downto 1 => '1', others => '0');
		I_DataIn <= std_logic_vector(to_unsigned(3, I_DataIn'length)); 
		wait for period;  
		
		--Checks if registers are written to again when I_W_EN is high
		I_W_EN <= '1';	   
		I_DataIn <= std_logic_vector(to_unsigned(1, I_DataIn'length));
		wait for period;
				
		I_regD <= std_logic_vector(to_unsigned(1, I_regD'length)); 
		Instruction(4 downto 0) <= (1 downto 0 => '1', others => '0');
		I_DataIn <= std_logic_vector(to_unsigned(3, I_DataIn'length));
		wait for period; 	   
		
		I_regD <= std_logic_vector(to_unsigned(0, I_regD'length));	
		Instruction(4 downto 0) <= (2 downto 0 => '1', others => '0');
		I_DataIn <= std_logic_vector(to_unsigned(2, I_DataIn'length));
		wait for period;	
		
		I_regD <= std_logic_vector(to_unsigned(100, I_regD'length));
		Instruction(4 downto 0) <= (4 => '1', 2 => '1', others => '0');
		I_DataIn <= std_logic_vector(to_unsigned(16, I_DataIn'length));
		wait for period;
		
		--Read the same registers at the same time
		I_regA := std_logic_vector(to_unsigned(100, I_regA'length));	
		I_regB := std_logic_vector(to_unsigned(100, I_regB'length));
		I_regC := std_logic_vector(to_unsigned(100, I_regC'length));
		Instruction(19 downto 15) <= I_regC;
		Instruction(14 downto 10) <= I_regB;
		Instruction(9 downto 5) <= I_regA;
		wait for period;
		
		--Ldi
		Instruction(24 downto 23) <= "0X";
		Instruction(18 downto 15) <= "XXXX";	
		wait for period;
		
		--R4 
		Instruction(24 downto 23) <= "10";
		Instruction(18 downto 15) <= "XXXX";
		wait for period;
		
		--R3
		--BCW
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "0101";
		wait for period;
		
		--CLZ
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "0110";
		wait for period;	  
		
		--ABSDB
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "0111";
		wait for period;	 
		
		--MPYU
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "1000";
		wait for period;
		
		--MSGN
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "1001";
		wait for period;	 
		
		--MPYU
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "1010";
		wait for period;   
		
		--POPCNTW
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "1100";
		wait for period;   
		
		--ROT
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "1101";
		wait for period;	 
		
		--ROTW
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "1110";
		wait for period;	 
		
		--SHLHI
		Instruction(24 downto 23) <= "11";
		Instruction(18 downto 15) <= "1111";
		wait for period;  
		
		--Instructions with no I_W_EN
		Instruction(24 downto 23) <= "11";	
		Instruction(18 downto 15) <= "0000";
		wait for period;
			
		Instruction(24 downto 23) <= "11";	
		Instruction(18 downto 15) <= "0001";
		wait for period;	 
		
		Instruction(24 downto 23) <= "11";	
		Instruction(18 downto 15) <= "0010";
		wait for period; 
		
		Instruction(24 downto 23) <= "11";	
		Instruction(18 downto 15) <= "0011";
		wait for period;	  
		
		Instruction(24 downto 23) <= "11";	
		Instruction(18 downto 15) <= "0100";
		wait for period; 
		
		Instruction(24 downto 23) <= "11";	
		Instruction(18 downto 15) <= "1011";
		wait for period; 
		
		wait;
	end process;

end ID_Stage_tb;
