library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Execute is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero_flag : out STD_LOGIC;
           Cout_flag : out STD_LOGIC;
           Ovf_flag : out STD_LOGIC
			 );
end Execute;

architecture Structural of Execute is

    -- Components

    --ALU
    COMPONENT alu
        Port (  A : in  STD_LOGIC_VECTOR (31 downto 0);
                B : in  STD_LOGIC_VECTOR (31 downto 0);
                Op : in  STD_LOGIC_VECTOR (3 downto 0);
                Out1 : out  STD_LOGIC_VECTOR (31 downto 0);
                Zero : out  STD_LOGIC;
                Cout : out  STD_LOGIC;
                Ovf : out  STD_LOGIC
            );
    END COMPONENT;

    -- MUX2to1 32bit
    COMPONENT MUX2_to_1
        Port ( Sel : in  STD_LOGIC;
				   A_in : in  STD_LOGIC_VECTOR (31 downto 0);
				   B_in : in  STD_LOGIC_VECTOR (31 downto 0);
				   C_out : out  STD_LOGIC_VECTOR (31 downto 0)
        ); 
    END COMPONENT;

signal mux_out_to_ALU : STD_LOGIC_VECTOR (31 downto 0);

begin    

    -- Port map of componets 
    alu_component: alu PORT MAP (
        A => RF_A,
        B => mux_out_to_ALU,
        Op => ALU_func,
        Out1 => ALU_out,
        Zero => Zero_flag,
        Cout => Cout_flag,
        Ovf => Ovf_flag
      );
        

    MUX: MUX2_to_1 PORT MAP (
        Sel => ALU_Bin_sel,
        A_in => RF_B,
        B_in => Immed,
        C_out => mux_out_to_ALU
      );


end Structural;

