library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Out1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
	signal out_and_cout: STD_LOGIC_VECTOR (32 downto 0);
	signal A_33bit, B_33bit: STD_LOGIC_VECTOR (32 downto 0);
	signal A_sign_bit, B_sign_bit, Ovf_temp, Zero_temp: STD_LOGIC;

begin
p1: process (A,B,Op,out_and_cout,A_33bit,B_33bit,Ovf_temp, Zero_temp)
begin

--	A_sign_bit <= A(31);	-- detect the sign 
--	B_sign_bit <= B(31);
	
	A_33bit <= '0' & A;		-- make A a 33bit number, still 2s compliment and same sign as before
	B_33bit <= '0' & B;
	
	--detect and do operation and cout
	case Op is
		when "0000" =>
			out_and_cout <= A_33bit + B_33bit;	-- library "use IEEE.std_logic_signed.all;" is used, so A_33bit, B_33bit are signed
		when "0001" =>
			out_and_cout <= A_33bit - B_33bit;
		when "0010" =>
			out_and_cout <= A_33bit and B_33bit;
		when "0011" =>
			out_and_cout <=  A_33bit or B_33bit;
		when "0100" =>
			out_and_cout <=  not A_33bit;
		when "1000" =>
			out_and_cout <=  std_logic_vector(shift_right(signed(A_33bit),1));		-- check if iu need to omit signed
		when "1001" =>
			out_and_cout <=  std_logic_vector(shift_right(unsigned(A_33bit),1));
		when "1010" =>
			out_and_cout <=  std_logic_vector(shift_left(unsigned(A_33bit),1));
		when "1100" =>
			out_and_cout <=  std_logic_vector(signed(A_33bit) rol 1);
		when "1101" =>
			out_and_cout <=  std_logic_vector(signed(A_33bit) ror 1);
		when others =>
			out_and_cout <=  "111111111110000111111111111111111";
	end case;	
	
	--  Zero flag
	if out_and_cout(31 downto 0) = "00000000000000000000000000000000" then
		Zero_temp <= '1';
	else
		Zero_temp <= '0';
	end if;	

	-- Ovfl flag	
	if ( (A(31) = B(31)) and (Op = "0000") and (A(31) /= out_and_cout(31)) ) then							-- when in same-sign and ADD func 
		Ovf_temp <= '1';			-- Ovf when we get the opposite sign
	elsif ((A(31) = '0') and (B(31) = '1')  and (Op = "0001") and (A(31) /= out_and_cout(31)) ) then		-- when in opposite-sign [pos. - neg.] and SUB func 
		Ovf_temp <= '1';			-- Ovf when MSB is '1' -> neg
	elsif (((A(31) = '1') and (B(31) = '0'))  and (Op = "0001") and (A(31) /= out_and_cout(31)) ) then		-- when in opposite-sign [neg. - pos.] and SUB func
		Ovf_temp <= '1';			-- Ovf when MSB is '0' -> pos
	else
		Ovf_temp <= '0';
	end if;
		
end process;

	--get Cout : 1-bit
	Cout <= out_and_cout(32);	-- Carry

	--get output
	Out1 <= out_and_cout(31 downto 0);

	Zero <= Zero_temp;
	Ovf <= Ovf_temp;

end Behavioral;