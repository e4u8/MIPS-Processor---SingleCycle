library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
    Port (
        Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
        PC_LdEn_c : out  STD_LOGIC;
        RF_WrData_sel_c : out  STD_LOGIC;
        RF_B_sel_c : out  STD_LOGIC;         
        Immed_Ext_c : out  STD_LOGIC_VECTOR (1 downto 0);
        ALU_Bin_sel_c : out  STD_LOGIC;
        MEM_WrEn_c : out  STD_LOGIC;
        WE_RF_c : out  STD_LOGIC     
    );
end Control;

architecture Behavioral of Control is
begin
    process (Opcode)
    begin
        if Opcode =  "100000" then                                                 -- R_type
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '0';
            RF_B_sel_c <= '0';
            ALU_Bin_sel_c <= '0';
            MEM_WrEn_c <= '0';         
            WE_RF_c <= '1';
            Immed_Ext_c <= "00";
        elsif Opcode = "111000" or Opcode = "110000" then                          -- li_addi
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '0';
            RF_B_sel_c <= '1';    
            ALU_Bin_sel_c <= '1';
            MEM_WrEn_c <= '0'; 
            WE_RF_c <= '1'; 
            Immed_Ext_c <= "01";
        elsif Opcode = "111001" then                                               -- lui
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '0';
            RF_B_sel_c <= '1';    
            ALU_Bin_sel_c <= '1';
            MEM_WrEn_c <= '0'; 
            WE_RF_c <= '1'; 
            Immed_Ext_c <= "11";
        elsif Opcode = "110011" or Opcode = "110010" then                          -- ori_andi
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '0';
            RF_B_sel_c <= '1';    
            ALU_Bin_sel_c <= '1';
            MEM_WrEn_c <= '0'; 
            WE_RF_c <= '1';          
            Immed_Ext_c <= "00";
        elsif Opcode = "111111" or Opcode = "010000" or Opcode = "010001" then     -- branch
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '0';
            RF_B_sel_c <= '1';
            ALU_Bin_sel_c <= '0';
            MEM_WrEn_c <= '0'; 
            WE_RF_c <= '0';
            Immed_Ext_c <= "10";
        elsif Opcode = "000011" or Opcode = "001111" then                          -- load
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '1';
            RF_B_sel_c <= '1';    
            ALU_Bin_sel_c <= '1';
            MEM_WrEn_c <= '0'; 
            WE_RF_c <= '1'; 
            Immed_Ext_c <= "01";
        elsif Opcode = "011111" then                                               -- store
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '0';
            RF_B_sel_c <= '1';    
            ALU_Bin_sel_c <= '1';
            MEM_WrEn_c <= '1'; 
            WE_RF_c <= '0';
            Immed_Ext_c <= "01";
        else                                                                       -- nop 
            PC_LdEn_c <= '1';
            RF_WrData_sel_c <= '0';
            RF_B_sel_c <= '1';    
            ALU_Bin_sel_c <= '1';
            MEM_WrEn_c <= '0'; 
            WE_RF_c <= '0'; 
            Immed_Ext_c <= "11";
        end if;
    end process;
end Behavioral;
