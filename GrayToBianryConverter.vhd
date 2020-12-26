library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity gray2binary is
Port ( gray_in : in STD_LOGIC_VECTOR (2 downto 0);
bin_out : out STD_LOGIC_VECTOR (2 downto 0));
end gray2binary;

architecture behave of gray2binary is
begin
bin_out(2)<= gray_in(2);
bin_out(1)<= gray_in(2) xor gray_in(1);
bin_out(0)<= gray_in(2) xor gray_in(1) xor gray_in(0);
end architecture;
