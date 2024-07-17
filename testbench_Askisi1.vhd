LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench_Askisi1 IS
END testbench_Askisi1;
 
ARCHITECTURE behavior OF testbench_Askisi1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Askisi1
    PORT(
         Clock_a : IN  std_logic;
         Reset_a : IN  std_logic;
         Reset_PC : IN  std_logic;
         Cout_flag_a : OUT  std_logic;
         Ovf_flag_a : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock_a : std_logic := '0';
   signal Reset_a : std_logic := '0';
   signal Reset_PC : std_logic := '0';

 	--Outputs
   signal Cout_flag_a : std_logic;
   signal Ovf_flag_a : std_logic;

   -- Clock period definitions
   constant Clock_a_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Askisi1 PORT MAP (
          Clock_a => Clock_a,
          Reset_a => Reset_a,
          Reset_PC => Reset_PC,
          Cout_flag_a => Cout_flag_a,
          Ovf_flag_a => Ovf_flag_a
        );

   -- Clock process definitions
   Clock_a_process :process
   begin
		Clock_a <= '0';
		wait for Clock_a_period/2;
		Clock_a <= '1';
		wait for Clock_a_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      Reset_a <= '1';
      Reset_PC <= '1';
      wait for Clock_a_period*10;
		
		Reset_a <= '0';
      Reset_PC <= '0';
      wait;
		
   end process;

END;
