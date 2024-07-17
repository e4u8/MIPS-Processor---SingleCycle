library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register32bit is
    Port ( Data : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
			  Reset : in STD_LOGIC;
           WE : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end Register32bit;

architecture Behavioral of Register32bit is

  signal Qtemp: STD_LOGIC_VECTOR (31 downto 0);
  
begin

	-- doesn't need sensitivity list since we have a CLK
    process
        begin
            wait until CLK'Event AND CLK = '1';

				IF Reset = '1' THEN 
					Qtemp <= "00000000000000000000000000000000";
				ELSE				
					IF WE = '1' THEN 
						 Qtemp <= Data;        -- Pass the new input
					ELSE
						 Qtemp <= Qtemp;       -- Do nothing
					END IF;
				END IF;
    end process;

    Dout <= Qtemp;  -- do we need to add here "  after 10 ns;  "
end Behavioral;

