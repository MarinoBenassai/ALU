----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:35:39 05/04/2021 
-- Design Name: 
-- Module Name:    memoire_donnees - Behavioral 
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire_donnees is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end memoire_donnees;

architecture Behavioral of memoire_donnees is

type MEMOIRE is array (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
SIGNAL MEM : MEMOIRE;

begin
process begin
	wait until CLK'EVENT and CLK = '1';
	if RST = '0' 
		then MEM <= (others => X"00");
	end if;
	if RW = '0'
		then MEM(to_integer(unsigned(a))) <= INPUT;
	end if;
	end process;
	OUTPUT <= "00000000" when RST = '0' else MEM(to_integer(unsigned(a)));

end Behavioral;

