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
 

 	----------------
 	-- COMPOSANTS --
 	----------------


 	 COMPONENT memoire_instructions
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         OUTPUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

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


    ---------------
    -- CONSTANTE --
    ---------------


   constant CLK_period : time := 10 ns;
	 

   	-------------
    -- SIGNAUX --
    -------------

    -- GLOBAL --

    signal CLK : std_logic := '0';
    -- signal LC : std_logic := '0';
		
	-- DI/EX - ETAGE 2--
	
	signal A_di_ex : std_logic_vector(7 downto 0) := (others => '0');
    signal OP_di_ex : std_logic_vector(7 downto 0) := (others => '0');
    signal B_di_ex : std_logic_vector(7 downto 0) := (others => '0');
    signal C_di_ex : std_logic_vector(7 downto 0) := (others => '0');


	-- DI/EX - ETAGE 3 --

	signal A_ex_mem : std_logic_vector(7 downto 0) := (others => '0');
    signal OP_ex_mem : std_logic_vector(7 downto 0) := (others => '0');
    signal B_ex_mem : std_logic_vector(7 downto 0) := (others => '0');
	

	-- EX/MEM - ETAGE 4 --

	signal A_mem_re : std_logic_vector(7 downto 0) := (others => '0');
    signal OP_mem_re : std_logic_vector(7 downto 0) := (others => '0');
    signal B_mem_re : std_logic_vector(7 downto 0) := (others => '0');
	
	-- MI --

	signal MI_a : std_logic_vector(7 downto 0) := (others => '0');
	signal MI_OUTPUT : std_logic_vector(31 downto 0) := (others => '0');

    -- BR --

    signal BR_RST : std_logic := '0';
    signal BR_aA : std_logic_vector(3 downto 0) := (others => '0');
    signal BR_aB : std_logic_vector(3 downto 0) := (others => '0');
    signal BR_QA : std_logic_vector(7 downto 0);
    signal BR_QB : std_logic_vector(7 downto 0);
	signal BR_aW : std_logic_vector(3 downto 0) := (others => '0');
	signal BR_W : std_logic := '0';
	signal BR_DATA : std_logic_vector(7 downto 0) := (others => '0');  

    -- ALU --

    signal ALU_A : std_logic_vector(7 downto 0) := (others => '0');
    signal ALU_B : std_logic_vector(7 downto 0) := (others => '0');
    signal ALU_Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');
    signal ALU_N : std_logic;
    signal ALU_O : std_logic;
    signal ALU_Z : std_logic;
    signal ALU_C : std_logic;
    signal ALU_S : std_logic_vector(7 downto 0);
	
	-- MD --

    signal MD_a : std_logic_vector(7 downto 0) := (others => '0');
    signal MD_INPUT : std_logic_vector(7 downto 0) := (others => '0');
    signal MD_RW : std_logic := '0';
    signal MD_RST : std_logic := '0';
    signal MD_OUTPUT : std_logic_vector(7 downto 0); 
	
		
	-- SIGNAUX UTILISES POUR LES ALEAS --

	signal alea_li_di_w : std_logic := '0';
	signal alea_di_ex_w : std_logic := '0';
	signal alea_r_a : std_logic := '0';
	signal alea_r_b : std_logic := '0';

BEGIN
 
    MI: memoire_instructions PORT MAP (
        a => MI_a,
        CLK => CLK,
		OUTPUT => MI_OUTPUT
    );
		  
	BR: Banc_de_registre PORT MAP (
		aW => BR_aW,
		W => BR_W,
		DATA => BR_DATA,
        aA => BR_aA,
		aB => BR_aB,
		RST => BR_RST,
		CLK => CLK,
		QA => BR_QA,
		QB => BR_QB
	);
	  
	ALU: ALU PORT MAP (
		A => ALU_A,
		B => ALU_B,
		Ctrl_Alu => ALU_Ctrl_Alu,
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

   -----------------------
   -- PROCESS - HORLOGE --
   -----------------------

   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
	

   ------------------------------------------
   -- TRAITEMENT - POINTEUR D'INSTRUCTIONS --
   ------------------------------------------


   IP :process
   begin
		wait until CLK'EVENT and CLK = '1';

		if BR_RST = '0' then
			MI_a <= x"00";
		else
			if (((MI_OUTPUT(31 downto 24) >= 1 and MI_OUTPUT(31 downto 24) <= 5) or MI_OUTPUT(31 downto 24) = 8) 
				and
				((alea_li_di_w = '1' and A_di_ex = MI_OUTPUT(15 downto 8)) or (alea_di_ex_w = '1' and A_ex_mem = MI_OUTPUT(15 downto 8))))
				or
				((MI_OUTPUT(31 downto 24) >= 1 and MI_OUTPUT(31 downto 24) <= 4)
				and
				((alea_li_di_w = '1' and A_di_ex = MI_OUTPUT(7 downto 0)) or (alea_di_ex_w = '1' and A_ex_mem = MI_OUTPUT(7 downto 0))))
				then
					MI_a <= MI_a;
			else 
				MI_a <= MI_a +1;
			end if;
		end if;

	end process;
	
   
   ------------------------------------
   -- TRAITEMENT - MI --> BR (ETAGE 2) --
   ------------------------------------


   MI_BR_process :process
   begin
		wait until CLK'EVENT and CLK = '1';
		
		if (((MI_OUTPUT(31 downto 24) >= 1 and MI_OUTPUT(31 downto 24) <= 5) or MI_OUTPUT(31 downto 24) = 8) 
				and
				((alea_li_di_w = '1' and A_di_ex = MI_OUTPUT(15 downto 8)) or (alea_di_ex_w = '1' and A_ex_mem = MI_OUTPUT(15 downto 8))))
				or
				((MI_OUTPUT(31 downto 24) >= 1 and MI_OUTPUT(31 downto 24) <= 4)
				and
				((alea_li_di_w = '1' and A_di_ex = MI_OUTPUT(7 downto 0)) or (alea_di_ex_w = '1' and A_ex_mem = MI_OUTPUT(7 downto 0))))
				then
			A_di_ex <= x"00";
			OP_di_ex <= x"00";
			B_di_ex <= x"00";
		else
			OP_di_ex <= MI_OUTPUT(31 downto 24);
			A_di_ex <= MI_OUTPUT(23 downto 16);
			C_di_ex <= BR_QB;
			if MI_OUTPUT(31 downto 24)=x"06" or MI_OUTPUT(31 downto 24) = x"07" then
				B_di_ex <= MI_OUTPUT(15 downto 8);
			else
				B_di_ex <=  BR_QA;
			end if;
		end if;

   end process;

	BR_aA <= MI_OUTPUT(11 downto 8);
	BR_aB <= MI_OUTPUT(3 downto 0);
	alea_li_di_w <= '0' when OP_di_ex = x"08" or OP_di_ex = x"00" else '1';
	

   --------------------------------
   -- TRAITEMENT - ALU (ETAGE 3) --
   --------------------------------


   ALU_process :process
   begin
		wait until CLK'EVENT and CLK = '1';

		OP_ex_mem <= OP_di_ex;
		A_ex_mem <= A_di_ex;
		if OP_di_ex <= x"03" and OP_di_ex >= x"01" then
			B_ex_mem <= ALU_S;
		else
			B_ex_mem <= B_di_ex;
		end if;

   end process;

	ALU_A <= B_di_ex;
	ALU_B <= C_di_ex;
	ALU_Ctrl_alu <= "001" when OP_di_ex = x"01" else "011" when OP_di_ex = x"02" else "010" when OP_di_ex = x"03" else "000";
	alea_di_ex_w <= '0' when OP_ex_mem = x"08" or OP_ex_mem = x"00" else '1';
	

   -------------------------------
   -- TRAITEMENT - MD (ETAGE 4) --
   -------------------------------


   MD_process :process
   begin
		wait until CLK'EVENT and CLK = '1';

		OP_mem_re <= OP_ex_mem;
		A_mem_re <= A_ex_mem;
		if OP_ex_mem = x"07" then
		    B_mem_re <= MD_OUTPUT;
		else
			B_mem_re <= B_ex_mem;
		end if;

   end process;

	MD_RW <= '0' when OP_ex_mem = x"08" else '1';
	MD_INPUT <= B_ex_mem;
	MD_a <= A_ex_mem when OP_ex_mem = x"08" else B_ex_mem;
		

   ----------------------------
   -- TRAITEMENT - MD --> BR --
   ----------------------------
	

	BR_W <= '0' when OP_mem_re = x"08" or OP_mem_re = x"00" else '1';
	BR_aW <= A_mem_re(3 downto 0);
	BR_DATA <= B_mem_re;

	
   --------------------------
   -- PROCESS - SIMULATION --
   --------------------------


   stim_proc: process
   begin		
		BR_RST <= '0' after 0 ns, '1' after 10 ns;
		MD_RST <= '0' after 0 ns, '1' after 10 ns;
      wait;
   end process;

END;
