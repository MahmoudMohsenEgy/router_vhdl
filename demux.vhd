library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deMux is 
port(d_in:in std_logic_vector(7 downto 0);
d_out1: out std_logic_vector(7 downto 0);
d_out2: out std_logic_vector(7 downto 0); 
d_out3: out std_logic_vector(7 downto 0);
d_out4: out std_logic_vector(7 downto 0);
sel:in std_logic_vector(1 downto 0);
en:in std_logic   );
end entity deMux;

architecture behave of deMux is 

begin
	p1:process(en,sel,d_in) is 
	begin
		if(en='1' ) then
			case sel is
			when"00" => d_out1<= d_in; d_out2<="00000000"; d_out3<="00000000"; d_out4<="00000000";
			when"01" => d_out2<= d_in; d_out1<="00000000"; d_out3<="00000000"; d_out4<="00000000";
			when"10" => d_out3<= d_in; d_out1<="00000000"; d_out2<="00000000"; d_out4<="00000000";
			when"11" => d_out4<= d_in;d_out1<="00000000"; d_out2<="00000000"; d_out3<="00000000";
			when others => d_out1<= "00000000"; d_out2<="00000000"; d_out3<="00000000"; d_out4<="00000000";
			end case; 
		end if;
	end process p1;
end architecture behave;
