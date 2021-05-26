----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:43:21 04/15/2021 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is

signal Stemp : STD_LOGIC_VECTOR (15 downto 0);
signal ADD : STD_LOGIC_VECTOR (8 downto 0);
signal SUB : STD_LOGIC_VECTOR (8 downto 0);
signal MUL : STD_LOGIC_VECTOR (15 downto 0);

begin

	ADD <= ( '0'& A ) + ( '0' & B );
	SUB <= ( '0'& A ) - ( '0' & B );
	MUL <= A * B;
	Stemp <= ("0000000" & ADD) when Ctrl_Alu = "001" else
				("0000000" & SUB) when Ctrl_Alu = "010" else
				MUL when Ctrl_Alu = "011" else
				"0000000000000000";
	N <= '1' when Ctrl_Alu = "010" and Stemp(8) = '1' else '0';
	O <= '0' when Stemp(15 downto 8) = "00000000" else '1';
	Z <= '1' when Stemp = "0000000000000000" else '0';
	C <= Stemp(8) when Ctrl_Alu = "001" else '0';

	S <= Stemp(7 downto 0);

end Behavioral;

