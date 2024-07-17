
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LoadModule is
    Port ( Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           RamOut : in  STD_LOGIC_VECTOR (31 downto 0);
           LoadOut : inout  STD_LOGIC_VECTOR (31 downto 0));
end LoadModule;

architecture Behavioral of LoadModule is

    signal temp : STD_LOGIC_VECTOR (31 downto 0);

begin
    load_module : process (Opcode, RamOut)
    begin

    if (Opcode = "000011") then
            temp <= "000000000000000000000000" & RamOut(7 downto 0);
        elsif (Opcode = "001111")then
            temp <= RamOut;
        else
            temp <= (others => '0');
    end if;

end process;

LoadOut <= temp;

end Behavioral; 
