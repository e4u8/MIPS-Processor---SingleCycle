LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Datapath_tb IS
END Datapath_tb;
 
ARCHITECTURE behavior OF Datapath_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Datapath
    PORT(
         Clk_d : IN  std_logic;
         Reset_d : IN  std_logic;
         Reset_PC_d : IN  std_logic;
         PC_LdEn_d : IN  std_logic;
         RF_WrData_sel_d : IN  std_logic;
         RF_B_sel_d : IN  std_logic;
         Immed_Ext_d : IN  std_logic_vector(1 downto 0);
         ALU_Bin_sel_d : IN  std_logic;
         MEM_WrEn_d : IN  std_logic;
         WE_RF_d : IN  std_logic;
         Cout_flag_d : OUT  std_logic;
         Ovf_flag_d : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk_d : std_logic := '0';
   signal Reset_d : std_logic := '0';
   signal Reset_PC_d : std_logic := '0';
   signal PC_LdEn_d : std_logic := '0';
   signal RF_WrData_sel_d : std_logic := '0';
   signal RF_B_sel_d : std_logic := '0';
   signal Immed_Ext_d : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_sel_d : std_logic := '0';
   signal MEM_WrEn_d : std_logic := '0';
   signal WE_RF_d : std_logic := '0';

 	--Outputs
   signal Cout_flag_d : std_logic;
   signal Ovf_flag_d : std_logic;

   -- Clock period definitions
   constant Clk_d_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Datapath PORT MAP (
          Clk_d => Clk_d,
          Reset_d => Reset_d,
          Reset_PC_d => Reset_PC_d,
          PC_LdEn_d => PC_LdEn_d,
          RF_WrData_sel_d => RF_WrData_sel_d,
          RF_B_sel_d => RF_B_sel_d,
          Immed_Ext_d => Immed_Ext_d,
          ALU_Bin_sel_d => ALU_Bin_sel_d,
          MEM_WrEn_d => MEM_WrEn_d,
          WE_RF_d => WE_RF_d,
          Cout_flag_d => Cout_flag_d,
          Ovf_flag_d => Ovf_flag_d
        );

   -- Clock process definitions
   Clk_d_process :process
   begin
		Clk_d <= '1';
		wait for Clk_d_period/2;
		Clk_d <= '0';
		wait for Clk_d_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Reset_d <= '1';
      Reset_PC_d <= '1';
      
      PC_LdEn_d <= '1';
      RF_WrData_sel_d <= '0';
      RF_B_sel_d <= '1';
      Immed_Ext_d <= "01";
      ALU_Bin_sel_d <= '1';
      MEM_WrEn_d <= '0';
      WE_RF_d <= '0';
      wait for Clk_d_period*10;

      -- 1st Instr (nop)
      Reset_d <= '0';
      Reset_PC_d <= '0';
      PC_LdEn_d <= '0';
      RF_WrData_sel_d <= '0';
      RF_B_sel_d <= '1';
      Immed_Ext_d <= "01";
      ALU_Bin_sel_d <= '1';
      MEM_WrEn_d <= '0';
      WE_RF_d <= '0';
      wait for Clk_d_period*3;
		
		
		-- 2nd Instr (lb)
      PC_LdEn_d <= '1';				
      
      RF_WrData_sel_d <= '1';
      RF_B_sel_d <= '0';				--X
      Immed_Ext_d <= "01";
      ALU_Bin_sel_d <= '1';
      MEM_WrEn_d <= '0';
      WE_RF_d <= '1';
      wait for Clk_d_period*1;
		
		-- 2nd Instr (lui)
      PC_LdEn_d <= '1';				
      
      RF_WrData_sel_d <= '0';
      RF_B_sel_d <= '1';
      Immed_Ext_d <= "11";
      ALU_Bin_sel_d <= '1';
      MEM_WrEn_d <= '0';
      WE_RF_d <= '1';
      wait for Clk_d_period*1;
		
		-- 4rd Instr (sw)
      PC_LdEn_d <= '1';				
      
      RF_WrData_sel_d <= '1';			--X
      RF_B_sel_d <= '1';
      Immed_Ext_d <= "01";
      ALU_Bin_sel_d <= '1';
      MEM_WrEn_d <= '1';
      WE_RF_d <= '0';
      wait for Clk_d_period*1;
		
		-- 4rd Instr (sw)
      -- PC_LdEn_d <= '1';				
      
      -- RF_WrData_sel_d <= '1';			--X
      -- RF_B_sel_d <= '1';
      -- Immed_Ext_d <= "01";
      -- ALU_Bin_sel_d <= '1';
      -- MEM_WrEn_d <= '1';
      -- WE_RF_d <= '0';
      -- wait for Clk_d_period*1;
		
		-- 3nd Instr (lw)
      PC_LdEn_d <= '1';				
      
      RF_WrData_sel_d <= '1';
      RF_B_sel_d <= '0';				--X
      Immed_Ext_d <= "01";
      ALU_Bin_sel_d <= '1';
      MEM_WrEn_d <= '0';
      WE_RF_d <= '1';
      wait for Clk_d_period*1;
		
		 -- 5th Instr (add)
       PC_LdEn_d <= '1';				
      
       RF_WrData_sel_d <= '0';
       RF_B_sel_d <= '0';
       Immed_Ext_d <= "00";
       ALU_Bin_sel_d <= '0';
       MEM_WrEn_d <= '0';
		 WE_RF_d <= '1';
		 wait for Clk_d_period*1;
		
		wait;
   end process;

END;
