library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX32 is
    Port ( R0 : in  STD_LOGIC_VECTOR (31 downto 0);        
           R1 : in  STD_LOGIC_VECTOR (31 downto 0);
           R2 : in  STD_LOGIC_VECTOR (31 downto 0);
           R3 : in  STD_LOGIC_VECTOR (31 downto 0);
           R4 : in  STD_LOGIC_VECTOR (31 downto 0);
           R5 : in  STD_LOGIC_VECTOR (31 downto 0);
           R6 : in  STD_LOGIC_VECTOR (31 downto 0);
           R7 : in  STD_LOGIC_VECTOR (31 downto 0);
           R8 : in  STD_LOGIC_VECTOR (31 downto 0);
           R9 : in  STD_LOGIC_VECTOR (31 downto 0);
           R10 : in  STD_LOGIC_VECTOR (31 downto 0);
           R11 : in  STD_LOGIC_VECTOR (31 downto 0);
           R12 : in  STD_LOGIC_VECTOR (31 downto 0);
           R13 : in  STD_LOGIC_VECTOR (31 downto 0);
           R14 : in  STD_LOGIC_VECTOR (31 downto 0);
           R15 : in  STD_LOGIC_VECTOR (31 downto 0);
           R16 : in  STD_LOGIC_VECTOR (31 downto 0);
           R17 : in  STD_LOGIC_VECTOR (31 downto 0);
           R18 : in  STD_LOGIC_VECTOR (31 downto 0);
           R19 : in  STD_LOGIC_VECTOR (31 downto 0);
           R20 : in  STD_LOGIC_VECTOR (31 downto 0);
           R21 : in  STD_LOGIC_VECTOR (31 downto 0);
           R22 : in  STD_LOGIC_VECTOR (31 downto 0);
           R23 : in  STD_LOGIC_VECTOR (31 downto 0);
           R24 : in  STD_LOGIC_VECTOR (31 downto 0);
           R25 : in  STD_LOGIC_VECTOR (31 downto 0);
           R26 : in  STD_LOGIC_VECTOR (31 downto 0);
           R27 : in  STD_LOGIC_VECTOR (31 downto 0);
           R28 : in  STD_LOGIC_VECTOR (31 downto 0);
           R29 : in  STD_LOGIC_VECTOR (31 downto 0);
           R30 : in  STD_LOGIC_VECTOR (31 downto 0);
           R31 : in  STD_LOGIC_VECTOR (31 downto 0);
           Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0) );
end MUX32;

architecture Behavioral of MUX32 is
    signal Dout_temp : STD_LOGIC_VECTOR (31 downto 0);


begin

	process(Dout_temp, Ard, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, 
                R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31)
		begin
            case Ard is 
                        when "00000" =>
                                        Dout_temp <= R0;
                        when "00001" =>
                                        Dout_temp <= R1;
                        when "00010" =>
                                        Dout_temp <= R2;
                        when "00011" =>
                                        Dout_temp <= R3;
                        when "00100" =>
                                        Dout_temp <= R4;
                        when "00101" =>
                                        Dout_temp <= R5;
                        when "00110" =>
                                        Dout_temp <= R6;
                        when "00111" =>
                                        Dout_temp <= R7;
                        when "01000" =>
                                        Dout_temp <= R8;
                        when "01001" =>
                                        Dout_temp <= R9;
                        when "01010" =>
                                        Dout_temp <= R10;
                        when "01011" =>
                                        Dout_temp <= R11;
                        when "01100" =>
                                        Dout_temp <= R12;
                        when "01101" =>
                                        Dout_temp <= R13;
                        when "01110" =>
                                        Dout_temp <= R14;
                        when "01111" =>
                                        Dout_temp <= R15;
                        when "10000" =>
                                        Dout_temp <= R16;
                        when "10001" =>
                                        Dout_temp <= R17;
                        when "10010" =>
                                        Dout_temp <= R18;
                        when "10011" =>
                                        Dout_temp <= R19;
                        when "10100" =>
                                        Dout_temp <= R20;
                        when "10101" =>
                                        Dout_temp <= R21;
                        when "10110" =>
                                        Dout_temp <= R22;
                        when "10111" =>
                                        Dout_temp <= R23;
                        when "11000" =>
                                        Dout_temp <= R24;
                        when "11001" =>
                                        Dout_temp <= R25;
                        when "11010" =>
                                        Dout_temp <= R26;
                        when "11011" =>
                                        Dout_temp <= R27;
                        when "11100" =>
                                        Dout_temp <= R28;
                        when "11101" =>
                                        Dout_temp <= R29;
                        when "11110" =>
                                        Dout_temp <= R30;
                        when "11111" =>
                                        Dout_temp <= R31;
                        when others => 
                                        Dout_temp <= R0;
            end case;                            
		 
	end process;

    -- Assign value of Dout_temp to output Dout     
    Dout <= Dout_temp; -- after 10 ns;             
end Behavioral;


