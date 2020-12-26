library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity testbench is 
end entity testbench;

architecture behave of testbench is
component roundrobinScheduler is 
port(clk:in std_logic;
din1:in std_logic_vector(7 downto 0);
din2:in std_logic_vector(7 downto 0);
din3:in std_logic_vector(7 downto 0);
din4:in std_logic_vector(7 downto 0);
output:out std_logic_vector(7 downto 0));
end component roundRobinScheduler;
for dut:roundrobinScheduler use entity work.roundRobinScheduler(behave);
signal clock:std_logic;
signal d1: std_logic_vector(7 downto 0);
signal d2: std_logic_vector(7 downto 0);
signal d3: std_logic_vector(7 downto 0);
signal d4: std_logic_vector(7 downto 0);
signal myout: std_logic_vector(7 downto 0);
begin

dut: roundRobinScheduler port map(clock,d1,d2,d3,d4,myout);

p1: process is begin
clock<='0','1' after 10 ns;
	wait for 20 ns;
end process p1;
p2:process is begin

d1<="00000001";
d2<="00000010";
d3<="00000011";
d4<="00000100";
wait;
end process p2;
end architecture behave;
