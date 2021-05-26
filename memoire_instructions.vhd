----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:08:27 05/04/2021 
-- Design Name: 
-- Module Name:    memoire_instructions - Behavioral 
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

entity memoire_instructions is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end memoire_instructions;

architecture Behavioral of memoire_instructions is

type MEMOIRE is array (0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
SIGNAL MEM : MEMOIRE := (1 => x"06010500",
								 2 => x"06020200",
								 3 => x"06030300",
								 4 => x"01040102",
								 5 => x"02050203",
								 6 => x"03060405",
								 7 => x"080B0600",
								 8 => x"080B0500",
								 9 => x"07070B00",
							    others => x"00000000");


begin

--process begin
--	wait until CLK'EVENT and CLK = '1';
	OUTPUT <= MEM(to_integer(unsigned(a)));
--end process;

end Behavioral;

