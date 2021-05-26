--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:24:08 05/04/2021
-- Design Name:   
-- Module Name:   /home/benassai/4A/nouveau dossier/ALU/pipeline.vhd
-- Project Name:  ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY pipeline IS
END pipeline;
 
ARCHITECTURE behavior OF pipeline IS 
 

	 COMPONENT Banc_de_registre
    PORT(
         aA : IN  std_logic_vector(3 downto 0);
         aB : IN  std_logic_vector(3 downto 0);
         aW : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	 
    
	 COMPONENT memoire_instructions
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         OUTPUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         Ctrl_Alu : IN  std_logic_vector(2 downto 0);
         N : OUT  std_logic;
         O : OUT  std_logic;
         Z : OUT  std_logic;
         C : OUT  std_logic;
         S : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT memoire_donnees
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         INPUT : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         OUTPUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	 

		--LI/DI
   signal a : std_logic_vector(7 downto 0) := (others => '0');
	signal CLK : std_logic := '0';
	signal OUTPUT : std_logic_vector(31 downto 0) := (others => '0');
	
	signal Adi : std_logic_vector(7 downto 0) := (others => '0');
   signal OPdi : std_logic_vector(7 downto 0) := (others => '0');
   signal Bdi : std_logic_vector(7 downto 0) := (others => '0');
   signal Cdi : std_logic_vector(7 downto 0) := (others => '0');


	--DI/EX

	signal Aex : std_logic_vector(7 downto 0) := (others => '0');
   signal OPex : std_logic_vector(7 downto 0) := (others => '0');
   signal Bex : std_logic_vector(7 downto 0) := (others => '0');
	
	--EX/MEM

	signal Amem : std_logic_vector(7 downto 0) := (others => '0');
   signal OPmem : std_logic_vector(7 downto 0) := (others => '0');
   signal Bmem : std_logic_vector(7 downto 0) := (others => '0');
	
	--MEM/RE
	signal LC : std_logic := '0';
	
	   --Inutilisés
   signal aA : std_logic_vector(3 downto 0) := (others => '0');
   signal aB : std_logic_vector(3 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);
	
		--ALU
	signal ALU_A : std_logic_vector(7 downto 0) := (others => '0');
   signal ALU_B : std_logic_vector(7 downto 0) := (others => '0');
   signal Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');
   signal ALU_N : std_logic;
   signal ALU_O : std_logic;
   signal ALU_Z : std_logic;
   signal ALU_C : std_logic;
   signal ALU_S : std_logic_vector(7 downto 0);
	
		--Mémoire données
   signal MD_a : std_logic_vector(7 downto 0) := (others => '0');
   signal MD_INPUT : std_logic_vector(7 downto 0) := (others => '0');
   signal MD_RW : std_logic := '0';
   signal MD_RST : std_logic := '0';

	signal aW : std_logic_vector(3 downto 0) := (others => '0');
	signal W : std_logic := '0';
	signal DATA : std_logic_vector(7 downto 0) := (others => '0');
 	--Outputs
   signal MD_OUTPUT : std_logic_vector(7 downto 0);
	
	-- Clock period definitions
   constant CLK_period : time := 10 ns;
	
	
	signal alea_di_w : std_logic := '0';
	signal alea_ex_w : std_logic := '0';
	signal alea_r_a : std_logic := '0';
	signal alea_r_b : std_logic := '0';

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   LI: memoire_instructions PORT MAP (
          a => a,
          CLK => CLK,
			 OUTPUT => OUTPUT
        );
		  
	DI: Banc_de_registre PORT MAP (
		 aW => aW,
		 W => W,
		 DATA => DATA,
       aA => aA,
		 aB => aB,
		 RST => RST,
		 CLK => CLK,
		 QA => QA,
		 QB => QB
	  );
	  
	  UAL: ALU PORT MAP (
		 A => ALU_A,
		 B => ALU_B,
		 Ctrl_Alu => Ctrl_Alu,
		 N => ALU_N,
		 O => ALU_O,
		 Z => ALU_Z,
		 C => ALU_C,
		 S => ALU_S
	  );
	  
	  MEM: memoire_donnees PORT MAP (
		 a => MD_a,
		 INPUT => MD_INPUT,
		 RW => MD_RW,
		 RST => MD_RST,
		 CLK => CLK,
		 OUTPUT => MD_OUTPUT
	  );


   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
	
	
	IP :process
   begin
		wait until CLK'EVENT and CLK = '1';
		if RST = '0' then
			a <= x"00";
		else
			if (((OUTPUT(31 downto 24) >= 1 and OUTPUT(31 downto 24) <= 5) or OUTPUT(31 downto 24) = 8) 
				and
				((alea_di_w = '1' and Adi = OUTPUT(15 downto 8)) or (alea_ex_w = '1' and Aex = OUTPUT(15 downto 8))))
				or
				((OUTPUT(31 downto 24) >= 1 and OUTPUT(31 downto 24) <= 4)
				and
				((alea_di_w = '1' and Adi = OUTPUT(7 downto 0)) or (alea_ex_w = '1' and Aex = OUTPUT(7 downto 0))))
				then
					a <= a;
			else 
				a <= a +1;
			end if;
		end if;
	end process;
	
	MI_BR_process :process
   begin
		wait until CLK'EVENT and CLK = '1';
		
		--Gestion des aléas		
		if (((OUTPUT(31 downto 24) >= 1 and OUTPUT(31 downto 24) <= 5) or OUTPUT(31 downto 24) = 8) 
				and
				((alea_di_w = '1' and Adi = OUTPUT(15 downto 8)) or (alea_ex_w = '1' and Aex = OUTPUT(15 downto 8))))
				or
				((OUTPUT(31 downto 24) >= 1 and OUTPUT(31 downto 24) <= 4)
				and
				((alea_di_w = '1' and Adi = OUTPUT(7 downto 0)) or (alea_ex_w = '1' and Aex = OUTPUT(7 downto 0))))
				then
				Adi <= x"00";
				OPdi <= x"00";
				Bdi <= x"00";
			else
				OPdi <= OUTPUT(31 downto 24);
				Adi <= OUTPUT(23 downto 16);
				Cdi <= Qb;
				if OUTPUT(31 downto 24)=x"06" or OUTPUT(31 downto 24) = x"07"
					then Bdi <= OUTPUT(15 downto 8);
				else Bdi <=  Qa;
				end if;
		end if;
				
				
		--if OPdi = x"08" or OPdi = x"00"
			--then  alea_di_w <= '0';
		--else
			--alea_di_w <= '1';
		--end if;
   end process;
	aA <= OUTPUT(11 downto 8);
	aB <= OUTPUT(3 downto 0);
	alea_di_w <= '0' when OPdi = x"08" or OPdi = x"00" else '1';
	
	
	UAL_process :process
   begin
		wait until CLK'EVENT and CLK = '1';
		--if OPex = x"08" or OPex = x"00"
			--then  alea_ex_w <= '0';
		--else
			--alea_ex_w <= '1';
		--end if;
		OPex <= OPdi;
		Aex <= Adi;
		if OPdi <= x"03" and OPdi >= x"01"
			then Bex <= ALU_S;
		else
			Bex <= Bdi;
		end if;
   end process;
	ALU_A <= Bdi;
	ALU_B <= Cdi;
	Ctrl_alu <= "001" when OPdi = x"01" else "011" when Opdi = x"02" else "010" when Opdi = x"03" else "000";
	alea_ex_w <= '0' when OPex = x"08" or OPex = x"00" else '1';
	
	MD_process :process
   begin
		wait until CLK'EVENT and CLK = '1';
		OPmem <= OPex;
		Amem <= Aex;
		if OPex = x"07"
			then Bmem <= MD_OUTPUT;
		else
			Bmem <= Bex;
		end if;			
   end process;
	MD_RW <= '0' when OPex = x"08" else '1';
	MD_INPUT <= Bex;
	MD_a <= Aex when OPex = x"08" else Bex;
		

	
	W <= '0' when OPmem = x"08" or OPmem = x"00" else '1';
	aW <= Amem(3 downto 0);
	DATA <= Bmem;

	
   -- Stimulus process
   stim_proc: process
   begin		
		RST <= '0' after 0 ns, '1' after 10 ns;
		md_RST <= '0' after 0 ns, '1' after 10 ns;
      wait;
   end process;

END;
