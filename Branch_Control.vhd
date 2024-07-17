library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Branch_Control is
    Port ( Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Zero_flag : in  STD_LOGIC;
           Pc_sel_flag : out  STD_LOGIC);
end Branch_Control;

architecture Behavioral of Branch_Control is
    signal branch_flag:  STD_LOGIC;

begin

p1: process (Opcode, Zero_flag)
begin

    case Opcode is
        when "111111" =>
            branch_flag <= '1';
        when "010000" =>
            branch_flag <= Zero_flag;
        when "010001" =>
            branch_flag <= not Zero_flag;
        when others =>
            branch_flag <= '0';
    end case;

end process;

Pc_sel_flag <= branch_flag;

end Behavioral;