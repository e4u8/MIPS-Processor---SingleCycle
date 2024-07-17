LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY testbench_Control IS
END testbench_Control;
 
ARCHITECTURE behavior OF testbench_Control IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         Opcode : IN  std_logic_vector(31 downto 0);
         PC_LdEn_c : OUT  std_logic;
         RF_WrData_sel_c : OUT  std_logic;
         RF_B_sel_c : OUT  std_logic;
         Immed_Ext_c : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel_c : OUT  std_logic;
         MEM_WrEn_c : OUT  std_logic;
         WE_RF_c : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Opcode : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC_LdEn_c : std_logic;
   signal RF_WrData_sel_c : std_logic;
   signal RF_B_sel_c : std_logic;
   signal Immed_Ext_c : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel_c : std_logic;
   signal MEM_WrEn_c : std_logic;
   signal WE_RF_c : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          Opcode => Opcode,
          PC_LdEn_c => PC_LdEn_c,
          RF_WrData_sel_c => RF_WrData_sel_c,
          RF_B_sel_c => RF_B_sel_c,
          Immed_Ext_c => Immed_Ext_c,
          ALU_Bin_sel_c => ALU_Bin_sel_c,
          MEM_WrEn_c => MEM_WrEn_c,
          WE_RF_c => WE_RF_c
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


      -- insert stimulus here 

      wait;
   end process;

END;
