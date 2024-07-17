library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1  : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end RegisterFile;

architecture Structural of RegisterFile is

    -- Components

    -- Register of 32 bit 
    COMPONENT Register32bit
    Port (       Data : in  STD_LOGIC_VECTOR (31 downto 0);
                 Dout : out  STD_LOGIC_VECTOR (31 downto 0);
                 WE : in  STD_LOGIC;
                 Reset : in  STD_LOGIC;
                 CLK : in  STD_LOGIC
        );
    END COMPONENT;

    -- Decoder 5 to 32

    COMPONENT Decoder5to32
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         DecoderOut_0 : OUT  std_logic;
         DecoderOut_1 : OUT  std_logic;
         DecoderOut_2 : OUT  std_logic;
         DecoderOut_3 : OUT  std_logic;
         DecoderOut_4 : OUT  std_logic;
         DecoderOut_5 : OUT  std_logic;
         DecoderOut_6 : OUT  std_logic;
         DecoderOut_7 : OUT  std_logic;
         DecoderOut_8 : OUT  std_logic;
         DecoderOut_9 : OUT  std_logic;
         DecoderOut_10 : OUT  std_logic;
         DecoderOut_11 : OUT  std_logic;
         DecoderOut_12 : OUT  std_logic;
         DecoderOut_13 : OUT  std_logic;
         DecoderOut_14 : OUT  std_logic;
         DecoderOut_15 : OUT  std_logic;
         DecoderOut_16 : OUT  std_logic;
         DecoderOut_17 : OUT  std_logic;
         DecoderOut_18 : OUT  std_logic;
         DecoderOut_19 : OUT  std_logic;
         DecoderOut_20 : OUT  std_logic;
         DecoderOut_21 : OUT  std_logic;
         DecoderOut_22 : OUT  std_logic;
         DecoderOut_23 : OUT  std_logic;
         DecoderOut_24 : OUT  std_logic;
         DecoderOut_25 : OUT  std_logic;
         DecoderOut_26 : OUT  std_logic;
         DecoderOut_27 : OUT  std_logic;
         DecoderOut_28 : OUT  std_logic;
         DecoderOut_29 : OUT  std_logic;
         DecoderOut_30 : OUT  std_logic;
         DecoderOut_31 : OUT  std_logic
        );
    END COMPONENT;
    

    -- MUX 32 to 1
    COMPONENT MUX32
        Port (  R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, 
                R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31 : in  STD_LOGIC_VECTOR (31 downto 0);
                Ard : in  STD_LOGIC_VECTOR (4 downto 0);
                Dout : out  STD_LOGIC_VECTOR (31 downto 0)
        );
    END COMPONENT;

--    -- MUX 2 to 1
--    COMPONENT MUX2_to_1
--        Port (  Sel : in  STD_LOGIC;
--                A_in : in  STD_LOGIC_VECTOR (31 downto 0);
--                B_in : in  STD_LOGIC_VECTOR (31 downto 0);
--                C_out : out  STD_LOGIC_VECTOR (31 downto 0)
--        );
--    END COMPONENT;

    -- Compare Module
   -- COMPONENT CompareModule	 
   --     PORT(   Addr_wr : IN  std_logic_vector(4 downto 0);
   --             Addr_rd : IN  std_logic_vector(4 downto 0);
   --             WE : in  STD_LOGIC;
   --             CompMod_out : out  STD_LOGIC         
   --     );
   -- END COMPONENT;

	--signal 
    type registerArray is array (0 to 31) of std_logic_vector(31 downto 0);
    signal Dataout_register : registerArray;
    signal WrEn_AND_DecoderOut, mux32_out_1, mux32_out_2: STD_LOGIC_VECTOR (31 downto 0);
    type decoderOut_Array is array (0 to 31) of std_logic;              -- define type of array
    signal decoder_out_R : decoderOut_Array;                           -- create a signal of type "decoderOut_Array", create an array of 32 - 1bit signals
    --signal compareM_out_1, compareM_out_2: STD_LOGIC;


begin
     
    -- Creates WE signal of each Register (0 to 31) using a For Loop
    WrEn_AND_DecOut : process (WrEn_AND_DecoderOut, WrEn,  decoder_out_R)
        begin        
            for i in 0 to 31 loop
                WrEn_AND_DecoderOut(i) <= WrEn AND decoder_out_R(i);
            end loop;  -- i            
    end process;


    -- Port map of componets 
    Decoder: 
    Decoder5to32 PORT MAP (
        Awr => Awr,
        DecoderOut_0 => decoder_out_R(0),
        DecoderOut_1 => decoder_out_R(1),
        DecoderOut_2 => decoder_out_R(2),
        DecoderOut_3 => decoder_out_R(3),
        DecoderOut_4 => decoder_out_R(4),
        DecoderOut_5 => decoder_out_R(5),
        DecoderOut_6 => decoder_out_R(6),
        DecoderOut_7 => decoder_out_R(7),
        DecoderOut_8 => decoder_out_R(8),
        DecoderOut_9 => decoder_out_R(9),
        DecoderOut_10 => decoder_out_R(10),
        DecoderOut_11 => decoder_out_R(11),
        DecoderOut_12 => decoder_out_R(12),
        DecoderOut_13 => decoder_out_R(13),
        DecoderOut_14 => decoder_out_R(14),
        DecoderOut_15 => decoder_out_R(15),
        DecoderOut_16 => decoder_out_R(16),
        DecoderOut_17 => decoder_out_R(17),
        DecoderOut_18 => decoder_out_R(18),
        DecoderOut_19 => decoder_out_R(19),
        DecoderOut_20 => decoder_out_R(20),
        DecoderOut_21 => decoder_out_R(21),
        DecoderOut_22 => decoder_out_R(22),
        DecoderOut_23 => decoder_out_R(23),
        DecoderOut_24 => decoder_out_R(24),
        DecoderOut_25 => decoder_out_R(25),
        DecoderOut_26 => decoder_out_R(26),
        DecoderOut_27 => decoder_out_R(27),
        DecoderOut_28 => decoder_out_R(28),
        DecoderOut_29 => decoder_out_R(29),
        DecoderOut_30 => decoder_out_R(30),
        DecoderOut_31 => decoder_out_R(31)
		  );

    Register_0: 
        Register32bit PORT MAP (
            Data => Din,
            Dout => Dataout_register(0),     -- CHECK THIS LATER
            WE => WrEn_AND_DecoderOut(0),
            Reset => '1',                    -- Since Reset is '1' R0 will not be written (in case of CompareModule, logic implemented)
            CLK => CLK
        );

        
    -- Some components are used multiple times, those for generate them and do the port map as well with 'i' var
    
    -- For-Generate for 31 Registers of 32-bits    
     Gen_31_registers :
        for i in 1 to 31 generate
            Register1to31: Register32bit 
                port map(
                    Data => Din,
                    Dout => Dataout_register(i),            
                    WE => WrEn_AND_DecoderOut(i),
                    Reset => RST,
                    CLK => CLK
                    
                );
        end generate; -- Gen_31_registers
 
    MUX32_1: MUX32
        port map(
            R0 => Dataout_register(0),
            R1 => Dataout_register(1),
            R2 => Dataout_register(2),	
            R3 => Dataout_register(3),
            R4 => Dataout_register(4),
            R5 => Dataout_register(5),
            R6 => Dataout_register(6),
            R7 => Dataout_register(7),
            R8 => Dataout_register(8),
            R9 => Dataout_register(9),
            R10 => Dataout_register(10),
            R11 => Dataout_register(11),
            R12 => Dataout_register(12),
            R13 => Dataout_register(13),
            R14 => Dataout_register(14),
            R15 => Dataout_register(15),
            R16 => Dataout_register(16),
            R17 => Dataout_register(17),
            R18 => Dataout_register(18),
            R19 => Dataout_register(19),
            R20 => Dataout_register(20),
            R21 => Dataout_register(21),
            R22 => Dataout_register(22),
            R23 => Dataout_register(23),
            R24 => Dataout_register(24),
            R25 => Dataout_register(25),
            R26 => Dataout_register(26),
            R27 => Dataout_register(27),
            R28 => Dataout_register(28),
            R29 => Dataout_register(29),
            R30 => Dataout_register(30),
            R31 => Dataout_register(31),            
            Ard => Ard1,
				Dout => Dout1
            --Dout => mux32_out_1
        );

    
    MUX32_2: MUX32
        port map(
            R0 => Dataout_register(0),
            R1 => Dataout_register(1),
            R2 => Dataout_register(2),	
            R3 => Dataout_register(3),
            R4 => Dataout_register(4),
            R5 => Dataout_register(5),
            R6 => Dataout_register(6),
            R7 => Dataout_register(7),
            R8 => Dataout_register(8),
            R9 => Dataout_register(9),
            R10 => Dataout_register(10),
            R11 => Dataout_register(11),
            R12 => Dataout_register(12),
            R13 => Dataout_register(13),
            R14 => Dataout_register(14),
            R15 => Dataout_register(15),
            R16 => Dataout_register(16),
            R17 => Dataout_register(17),
            R18 => Dataout_register(18),
            R19 => Dataout_register(19),
            R20 => Dataout_register(20),
            R21 => Dataout_register(21),
            R22 => Dataout_register(22),
            R23 => Dataout_register(23),
            R24 => Dataout_register(24),
            R25 => Dataout_register(25),
            R26 => Dataout_register(26),
            R27 => Dataout_register(27),
            R28 => Dataout_register(28),
            R29 => Dataout_register(29),
            R30 => Dataout_register(30),
            R31 => Dataout_register(31),            
            Ard => Ard2,
				Dout => Dout2
            --Dout => mux32_out_2
        );
        
--    CompareMod_1:
--        CompareModule PORT MAP (
--            Addr_wr => Awr,
--            Addr_rd => Ard1,
--            WE => WrEn,
--            CompMod_out => compareM_out_1
--            );            
--
--    CompareMod_2:
--        CompareModule PORT MAP (
--            Addr_wr => Awr,
--            Addr_rd => Ard2,
--            WE => WrEn,
--            CompMod_out => compareM_out_2
--            );             
--        
--    MUX2_1: 
--        MUX2_to_1 PORT MAP (
--                Sel => compareM_out_1,
--                A_in => mux32_out_1,
--                B_in => Din,
--                C_out => Dout1
--              );
--           
--    MUX2_2: 
--        MUX2_to_1 PORT MAP (
--                Sel => compareM_out_2,
--                A_in => mux32_out_2,
--                B_in => Din,
--                C_out => Dout2
--              );
--      

end Structural;

