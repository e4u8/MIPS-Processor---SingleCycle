library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
Port ( Clk_d : in  STD_LOGIC;
		Reset_d : in  STD_LOGIC;
		Reset_PC_d : in  STD_LOGIC;
		--PC_Sel_d : in  STD_LOGIC;
		PC_LdEn_d : in  STD_LOGIC;
		RF_WrData_sel_d : in  STD_LOGIC;
		RF_B_sel_d : in  STD_LOGIC;         
		Immed_Ext_d : in  STD_LOGIC_VECTOR (1 downto 0);
		ALU_Bin_sel_d : in  STD_LOGIC;
		MEM_WrEn_d : in STD_LOGIC;
		WE_RF_d : in STD_LOGIC;
		--Zero_flag_d : out std_logic;
		Cout_flag_d : out std_logic;
		Ovf_flag_d : out std_logic

);
end Datapath;

architecture Structural of Datapath is
COMPONENT Execute
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         Zero_flag : OUT  std_logic;
         Cout_flag : OUT  std_logic;
         Ovf_flag : OUT  std_logic
        );
    END COMPONENT;
	 
		  
COMPONENT IFStage
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         Reset : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Immed_Ext : IN  std_logic_vector(1 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
COMPONENT MEM
    PORT(
         a : IN  std_logic_vector(9 downto 0);
         d : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         we : IN  std_logic;
         spo : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
--COMPONENT StoreCloud
--	Port ( Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
--           Rf_rd : in  STD_LOGIC_VECTOR (31 downto 0);
--           Mem_data : out  STD_LOGIC_VECTOR (31 downto 0));
--	END COMPONENT;
	
COMPONENT ALU_Control
    PORT(
         Opcode : IN  std_logic_vector(5 downto 0);
         Func : IN  std_logic_vector(5 downto 0);
         Alu_func : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
	 
COMPONENT Branch_Control
    PORT(
         Opcode : IN  std_logic_vector(5 downto 0);
         Zero_flag : IN  std_logic;
         Pc_sel_flag : OUT  std_logic
        );
    END COMPONENT;
	 
COMPONENT LoadModule
    PORT(
         Opcode : IN  std_logic_vector(5 downto 0);
         RamOut : IN  std_logic_vector(31 downto 0);
         LoadOut : INOUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	
signal RF_A_temp, RF_B_temp, Immed_temp, Instr_temp, ALU_out_temp, MEM_out_temp, d_temp, LoadOut_temp : STD_LOGIC_VECTOR (31 downto 0);
signal Zero_flag_temp, PC_Sel_temp : STD_LOGIC;
signal Alu_func_temp : STD_LOGIC_VECTOR (3 downto 0);

begin

-- Instantiate the Unit Under Test (UUT)
   exec: Execute PORT MAP (
          RF_A => RF_A_temp,
          RF_B => RF_B_temp,
          Immed => Immed_temp,
          ALU_Bin_sel => ALU_Bin_sel_d,
          ALU_func => Alu_func_temp,
          ALU_out => ALU_out_temp,
          Zero_flag => Zero_flag_temp,
          Cout_flag => Cout_flag_d,
          Ovf_flag => Ovf_flag_d
        );
		  
-- Instantiate the Unit Under Test (UUT)
   ifst: IFStage PORT MAP (
          PC_Immed => Immed_temp,
          PC_sel => PC_Sel_temp,
          PC_LdEn => PC_LdEn_d,
          Reset => Reset_PC_d,
          Clk => Clk_d,
          Instr => Instr_temp
        );
		  
	decst: DECSTAGE PORT MAP (
          Instr => Instr_temp,
          RF_WrEn => WE_RF_d,
          Reset => Reset_d,
          ALU_out => ALU_out_temp,
          MEM_out => LoadOut_temp,
          RF_WrData_sel => RF_WrData_sel_d,
          RF_B_sel => RF_B_sel_d,
          Clk => Clk_d,
          Immed_Ext => Immed_Ext_d,
          Immed => Immed_temp, 
          RF_A => RF_A_temp,
          RF_B => RF_B_temp 
        );
		  
	memor: MEM PORT MAP (
          a => ALU_out_temp(9 downto 0),
          d => RF_B_temp,
          clk => Clk_d,
          we => MEM_WrEn_d,
          spo => MEM_out_temp
        );
		  
--	storeCl: StoreCloud PORT MAP (
--          Opcode => Instr_temp(31 downto 26),
--          Rf_rd => RF_B_temp,
--          Mem_data => d_temp
--        );
		  
	alu_contr: ALU_Control PORT MAP (
          Opcode => Instr_temp(31 downto 26),
          Func => Instr_temp(5 downto 0),
          Alu_func => Alu_func_temp
        );
		  
	branch_contr: Branch_Control PORT MAP (
          Opcode => Instr_temp(31 downto 26),
          Zero_flag => Zero_flag_temp,
          Pc_sel_flag => PC_Sel_temp
        );
		  
	load_mod: LoadModule PORT MAP (
          Opcode => Instr_temp(31 downto 26),
          RamOut => MEM_out_temp,
          LoadOut => LoadOut_temp
        );


end Structural;