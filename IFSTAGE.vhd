----------------------------------------------------------------------------------
-- Instruction Fetch Stage
-- Credit: SZ
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity IFStage is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFStage;

architecture Behavioral of IFStage is

	component Register32bit is
		Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
				 Dout : out  STD_LOGIC_VECTOR (31 downto 0);
				 WE : in  STD_LOGIC;
				 RESET: in STD_LOGIC;
             CLK : in  STD_LOGIC);
	end component;
	
	component ROM is 
		PORT(
         a : IN  std_logic_vector(9 downto 0);
         spo : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;	
	 
	signal PC_Out : STD_LOGIC_VECTOR (31 downto 0);
	signal PC_In : STD_LOGIC_VECTOR (31 downto 0);

begin

-- the asychronous part
p1: process ( PC_Immed,PC_Out,PC_Sel )
begin
	case PC_Sel is
		when '0' =>
			PC_In <= PC_Out + 4;
		when '1' =>
			PC_In <= PC_Out + 4 + PC_Immed;
		when others =>
			PC_In <= "00000000000000000000000000000000"; 
		end case;
end process;
--
--<< 1 = x2
-->>2  = /4
--000001 ---- 1
--000010 ---- 2
--000100 ---- 4



-- port map to PC
pc: Register32bit PORT MAP (
          Data => PC_In,
          Dout => PC_Out,
          WE => PC_LdEn,
          RESET => Reset,
          CLK => Clk
        );


-- port map to ROM
   mem: ROM PORT MAP (
          a => PC_Out(11 downto 2),
          spo => Instr
        );


end Behavioral;
