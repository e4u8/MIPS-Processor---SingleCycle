-- Cloud of image 5, changes Immediate, part of DECSTAGE 
--Anastasopoulou Evgenia
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity Cloud is
    Port ( Instr15to0 : in  STD_LOGIC_VECTOR (15 downto 0);         
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);              
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end Cloud;

    -- Instr15to0 : The last 16 bits of the Instruction to be decoded
    -- Immed : It is Instr15to0 vector(16bits) extended in 32 bits long, modiefied properly, depending on ImmExt value
    -- ImmExt : 2 bit long, 2^2 = 4 different combinations
-------------------------------------------------------------------------------------------------------------------------------------  
    -- 00 -> Zero-filling : Fills bits (31 down to 16) with '0' (zeros)   [ex. andi]
    -- 01 -> Sign-Extend : Fills bits (31 down to 16) with the sign bit, '1' in case of negative, '0' in case of positive   [ex. addi]
    -- 10 -> Shift left 2bits and Sign-Extend: Shifts Instr15to0 by 2 to the left, therefore, multiply by 4 [ex. beq] and Sign-Extend the product
    -- 11 -> Shift left 16bits and Zero-fill the rest [lui]

architecture Behavioral of Cloud is
    signal Immed_temp,temp : STD_LOGIC_VECTOR (31 downto 0);
    signal sign_bit : STD_LOGIC;
    --signal debug_signal : STD_LOGIC_VECTOR (15 downto 0);

begin
    
    process(Immed_temp, Instr15to0, ImmExt)

        begin 
        
        sign_bit <= Instr15to0(15);

            case ImmExt is 
                        when "00" => 
                                Immed_temp <= "0000000000000000" & Instr15to0;
 
                        when "01" => 
                                Immed_temp <= sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit
                                & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & Instr15to0 ;
 
                        when "10" => 
                                Immed_temp <= sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit
                                & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & sign_bit & std_logic_vector(shift_left(signed(Instr15to0), 2));
 
                        when "11" => 
                                Immed_temp <=   Instr15to0 & "0000000000000000";       

                        when others =>             
                                Immed_temp <=   Instr15to0 & Instr15to0;

            end case;
    end process;

    
    Immed <= Immed_temp;   
    --debug_signal <= std_logic_vector(shift_left(signed(temp), 2));

end Behavioral;

