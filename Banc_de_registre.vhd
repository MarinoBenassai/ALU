----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:27:05 04/15/2021 
-- Design Name: 
-- Module Name:    Banc_de_registre - Behavioral 
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

entity Banc_de_registre is
    Port ( aA : in  STD_LOGIC_VECTOR (3 downto 0);
           aB : in  STD_LOGIC_VECTOR (3 downto 0);
           aW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end Banc_de_registre;

architecture Behavioral of Banc_de_registre is

type REGISTRE is array (0 to 15) of STD_LOGIC_VECTOR (7 downto 0);
signal REG : REGISTRE ;

begin
	QA <= REG(to_integer(unsigned(aA))) when (aA /= aW or W = '0') else DATA;
	QB <= REG(to_integer(unsigned(aB))) when (aB /= aW or W = '0') else DATA;
	process begin
		wait until CLK'EVENT and CLK = '1';
		if RST = '0' then REG <= (others => X"00");
			
		else
			if W = '1'
				then REG(to_integer(unsigned(aW))) <= DATA ;
			end if;
			
		end if;
	end process;

end Behavioral;

