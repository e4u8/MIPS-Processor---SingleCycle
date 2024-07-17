library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_Control is
    Port (
        Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
        Func : in  STD_LOGIC_VECTOR (5 downto 0);
        Alu_func : out  STD_LOGIC_VECTOR (3 downto 0)
    );
end ALU_Control;

architecture Behavioral of ALU_Control is
    signal temp_out: STD_LOGIC_VECTOR (3 downto 0);

begin

p1: process (Opcode, Func)
begin

    --detect and do operation and cout
    case Opcode is
        when "100000" =>                                    -- R-type
            temp_out <= Func(3 downto 0);
        when "111000" =>             -- li, lui, addi, Lb, Lw, Sw
            temp_out <= "0000";
        when "111001" =>
                temp_out <= "0000";
        when "110000" =>
                temp_out <= "0000";
        when "000011" =>
                temp_out <= "0000";
        when "001111" =>
                temp_out <= "0000";
        when "011111" =>
                temp_out <= "0000";
        when "110010" =>                                    -- andi
                temp_out <= "0010";
        when "110011" =>                                    -- ori
            temp_out <= "0011";
        when "010000" =>                                    -- beq, bne
            temp_out <= "0001";
        when "010001" =>
                temp_out <= "0001";
      when others =>
            temp_out <= "1111";
    end case;

end process;

Alu_func <= temp_out;

end Behavioral;