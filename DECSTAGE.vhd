----------------------------------------------------------------------------------
-- Module Name:    DECSTAGE - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           Reset :  in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;           
           Immed_Ext : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Structural of DECSTAGE is

    -- Declaration of Components

    COMPONENT MUX2_to_1
        PORT( 

				A_in : in  STD_LOGIC_VECTOR (31 downto 0);
            B_in  : in  STD_LOGIC_VECTOR (31 downto 0);
            Sel : in  STD_LOGIC;
				C_out: out  STD_LOGIC_VECTOR (31 downto 0)
        );

    END COMPONENT;


    COMPONENT MUX2to1_5bit
        PORT(
            choice_0 : in  STD_LOGIC_VECTOR (4 downto 0);
            choice_1 : in  STD_LOGIC_VECTOR (4 downto 0);
            Sel : in  STD_LOGIC;
            Dout : out  STD_LOGIC_VECTOR (4 downto 0)

        );

    END COMPONENT;


    COMPONENT Cloud
        PORT(
            Instr15to0 : in  STD_LOGIC_VECTOR (15 downto 0);
            ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
            Immed : out  STD_LOGIC_VECTOR (31 downto 0)
        );

    END COMPONENT;


    COMPONENT RegisterFile
        PORT(
            Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
            Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
            Awr : in  STD_LOGIC_VECTOR (4 downto 0);
            Dout1  : out  STD_LOGIC_VECTOR (31 downto 0);
            Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
            Din : in  STD_LOGIC_VECTOR (31 downto 0);
            WrEn : in  STD_LOGIC;
				RST : in  STD_LOGIC;
            CLK : in  STD_LOGIC

        );

    END COMPONENT;

-- Signals 
signal write_data : STD_LOGIC_VECTOR (31 downto 0);
signal tmp_readReg1 : STD_LOGIC_VECTOR (4 downto 0);

BEGIN

-- Port map of Components

MUX_output_32bits : MUX2_to_1 PORT MAP (
    A_in => ALU_out,
    B_in => MEM_out,
    Sel => RF_WrData_sel,
    C_out => write_data
);

MUX_output_5bits: MUX2to1_5bit PORT MAP (
    choice_0 => Instr(15 downto 11),
    choice_1 => Instr(20 downto 16),
    Sel => RF_B_sel,
    Dout => tmp_readReg1
);

Cloud_component : Cloud PORT MAP (
    Instr15to0 => Instr(15 downto 0),
    ImmExt => Immed_Ext,            
    Immed => Immed
);

RegFile : RegisterFile PORT MAP( 
    Ard1 => Instr(25 downto 21),
    Ard2 => tmp_readReg1,
    Awr => Instr(20 downto 16),
    Dout1 => RF_A,
    Dout2 => RF_B,
    Din => write_data,
    WrEn => RF_WrEn,
    RST => Reset,
    CLK => Clk
);


end Structural;

