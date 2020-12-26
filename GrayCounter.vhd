library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity GrayCounter is
port(clk,en,reset:in std_logic;
count_out:out std_logic_vector(2 downto 0));
end entity GrayCounter;

architecture behave of GrayCounter is 
type state is (a,b,c,d,e,f,g,h);
signal cs:state:=a;
signal ns:state;

begin

clockProcess:process(clk,en,reset) is 
begin
if(reset='1') then cs<=a;
elsif (rising_edge(clk)and en='1') then
cs<=ns;
end if;
end process clockProcess;

nState:process(cs) is begin
case cs is
when a => ns<=b;
when b => ns<=c;
when c => ns<=d;
when d => ns<=e;
when e => ns<=f;
when f => ns<=g;
when g => ns<=h;
when h => ns<=a;
end case;
end process nState;

output:process(cs) is
begin
case cs is 
when a=> count_out<="000";
when b=> count_out<="001";
when c=> count_out<="011";
when d=> count_out<="010";
when e=> count_out<="110";
when f=> count_out<="111";
when g=> count_out<="101";
when h=> count_out<="100";
end case;
end process output;
end architecture behave;
