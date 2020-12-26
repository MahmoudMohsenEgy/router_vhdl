library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity myEntity is 
port(data_in: in std_logic_vector(7 downto 0); 
clk:in std_logic; 
data_out:out std_logic_vector(7 downto 0 );
clk_en: in std_logic;
reset:in std_logic);
end entity myEntity;

architecture behave of myEntity is

begin
	p1:process(clk, reset,clk_en,data_in) is 
	begin
		if(reset='1') then data_out<="00000000";
		elsif (rising_edge(clk) and clk_en='1') then data_out<=data_in ;
		end if;
	end process p1;
end architecture behave;