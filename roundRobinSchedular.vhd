library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity roundrobinScheduler is 
port(clk:in std_logic;
din1:in std_logic_vector(7 downto 0);
din2:in std_logic_vector(7 downto 0);
din3:in std_logic_vector(7 downto 0);
din4:in std_logic_vector(7 downto 0);
output:out std_logic_vector(7 downto 0));
end entity roundRobinScheduler;

architecture behave of roundRobinScheduler is
type state is (a,b,c,d);
signal cs:state:=a;
signal ns:state;

begin


p1:process(clk) is
begin
	if rising_edge(clk) then cs<=ns;
	end if;
end process p1;

p2:process(cs) is 
begin
	case cs is
	when a => ns<=b;
	when b=> ns<=c;
	when c=> ns<=d;
	when d=> ns<=a;
end case;
end process p2;

p3:process(cs) is
begin
	case cs is 
	when a=> output<=din1;
	when b=> output<= din2;
	when c=> output<= din3;
	when d=> output<= din4;
end case;
end process p3;
end architecture behave;


