-- MUX 2 to 1, with 5 bit vectors
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2to1_5bit is
    Port ( choice_0 : in  STD_LOGIC_VECTOR (4 downto 0);
           choice_1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Sel : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX2to1_5bit;

architecture Behavioral of MUX2to1_5bit is
    signal Dout_temp : STD_LOGIC_VECTOR (4 downto 0);

begin

    process( choice_0, choice_1, Sel, Dout_temp)

		begin 
            case Sel is 
                        when  '0' => 
                                    Dout_temp <= choice_0;
                        when  '1' => 
                                    Dout_temp <= choice_1;
                        when others => 
                                    Dout_temp <= choice_0;
            end case;                            

    end process;
    -- Assign value of Dout_temp to output Dout     
    Dout <= Dout_temp;

end Behavioral;

