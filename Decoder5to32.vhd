library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all;

entity Decoder5to32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           DecoderOut_0 : out  STD_LOGIC;
           DecoderOut_1 : out  STD_LOGIC;
           DecoderOut_2 : out  STD_LOGIC;
           DecoderOut_3 : out  STD_LOGIC;
           DecoderOut_4 : out  STD_LOGIC;
           DecoderOut_5 : out  STD_LOGIC;
           DecoderOut_6 : out  STD_LOGIC;
           DecoderOut_7 : out  STD_LOGIC;
           DecoderOut_8 : out  STD_LOGIC;
           DecoderOut_9 : out  STD_LOGIC;
           DecoderOut_10 : out  STD_LOGIC;
           DecoderOut_11 : out  STD_LOGIC;
           DecoderOut_12 : out  STD_LOGIC;
           DecoderOut_13 : out  STD_LOGIC;
           DecoderOut_14 : out  STD_LOGIC;
           DecoderOut_15 : out  STD_LOGIC;
           DecoderOut_16 : out  STD_LOGIC;
           DecoderOut_17 : out  STD_LOGIC;
           DecoderOut_18 : out  STD_LOGIC;
           DecoderOut_19 : out  STD_LOGIC;
           DecoderOut_20 : out  STD_LOGIC;
           DecoderOut_21 : out  STD_LOGIC;
           DecoderOut_22 : out  STD_LOGIC;
           DecoderOut_23 : out  STD_LOGIC;
           DecoderOut_24 : out  STD_LOGIC;
           DecoderOut_25 : out  STD_LOGIC;
           DecoderOut_26 : out  STD_LOGIC;
           DecoderOut_27 : out  STD_LOGIC;
           DecoderOut_28 : out  STD_LOGIC;
           DecoderOut_29 : out  STD_LOGIC;
           DecoderOut_30 : out  STD_LOGIC;
           DecoderOut_31 : out  STD_LOGIC);
end Decoder5to32;

architecture Behavioral of Decoder5to32 is

	-- signals
	type decoderOut_Array is array (0 to 31) of std_logic;              -- define type of array
    signal decoder_out_R : decoderOut_Array;                           -- create a signal of type "decoderOut_Array", create an array of 32 - 1bit signals
	
begin
    
    -- Detect which Register should be written
    decoder5to32 : process (Awr, decoder_out_R)
    begin        
        for i in 0 to 31 loop
            if(to_integer(unsigned(Awr)) = i) then                       -- cast std_logic_vector to compare it to an integer            
                decoder_out_R(i) <= '1';
            else 
                decoder_out_R(i) <= '0';
            end if;

        end loop;  -- i            
   end process;

   DecoderOut_0 <= decoder_out_R(0);
   DecoderOut_1 <= decoder_out_R(1);
   DecoderOut_2 <= decoder_out_R(2);
   DecoderOut_3 <= decoder_out_R(3);
   DecoderOut_4 <= decoder_out_R(4);
   DecoderOut_5 <= decoder_out_R(5);
   DecoderOut_6 <= decoder_out_R(6);
   DecoderOut_7 <= decoder_out_R(7);
   DecoderOut_8 <= decoder_out_R(8);
   DecoderOut_9 <= decoder_out_R(9);
   DecoderOut_10 <= decoder_out_R(10);
   DecoderOut_11 <= decoder_out_R(11);
   DecoderOut_12 <= decoder_out_R(12);
   DecoderOut_13 <= decoder_out_R(13);
   DecoderOut_14 <= decoder_out_R(14);
   DecoderOut_15 <= decoder_out_R(15);
   DecoderOut_16 <= decoder_out_R(16);
   DecoderOut_17 <= decoder_out_R(17);
   DecoderOut_18 <= decoder_out_R(18);
   DecoderOut_19 <= decoder_out_R(19);
   DecoderOut_20 <= decoder_out_R(20);
   DecoderOut_21 <= decoder_out_R(21);
   DecoderOut_22 <= decoder_out_R(22);
   DecoderOut_23 <= decoder_out_R(23);
   DecoderOut_24 <= decoder_out_R(24);
   DecoderOut_25 <= decoder_out_R(25);
   DecoderOut_26 <= decoder_out_R(26);
   DecoderOut_27 <= decoder_out_R(27);
   DecoderOut_28 <= decoder_out_R(28);
   DecoderOut_29 <= decoder_out_R(29);
   DecoderOut_30 <= decoder_out_R(30);
   DecoderOut_31 <= decoder_out_R(31);

end Behavioral;

