----------------------------------------------------------------------------------
-- Create Date:    22:22:14 03/21/2023 
-- Module Name:    MUX2_to_1 - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;           -- make sure if these libraries should be used in mux32 as well
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MUX2_to_1 is
    Port ( Sel : in  STD_LOGIC;
           A_in : in  STD_LOGIC_VECTOR (31 downto 0);
           B_in : in  STD_LOGIC_VECTOR (31 downto 0);
           C_out : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX2_to_1;

architecture Behavioral of MUX2_to_1 is

    signal temp_out : STD_LOGIC_VECTOR (31 downto 0);

begin
    process( A_in, B_in, temp_out, Sel)

        begin 
            case Sel is 
                        when '0' => 
                                    temp_out <= A_in;
                        when '1' =>                  
                                    temp_out <= B_in;
                        when others => 
                                    temp_out <= A_in;  -- 
            end case;                            

    end process;
        
    C_out <= temp_out;
end Behavioral;

