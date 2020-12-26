library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;
entity FifoControler is 
port(
reset,rdclk,wrclk,r_req,w_req:in std_logic;
empty,full,write_valid,read_valid:out std_logic;
wr_ptr,rd_ptr:out std_logic_vector(2 downto 0)
);
end entity FifoControler;

architecture behave of FifoControler is 
signal temp_rd_ptr: std_logic_vector(2 downto 0);
signal temp_wr_ptr: std_logic_vector(2 downto 0);
signal next_wr_ptr:std_logic_vector(2 downto 0);
signal full_temp:std_logic;
signal empty_temp:std_logic;

component GrayCounter is
port(clk,en,reset:in std_logic;
count_out:out std_logic_vector(2 downto 0));
end component GrayCounter;
for all:GrayCounter use entity work.graycounter(behave);

Component gray2binary is
Port ( gray_in : in STD_LOGIC_VECTOR (2 downto 0);
bin_out : out STD_LOGIC_VECTOR (2 downto 0));
end component gray2binary;
for all:gray2binary use entity work.gray2binary(behave);

signal readTemp:std_logic_vector(2 downto 0);
signal writeTemp:std_logic_vector(2 downto 0);
signal validRead:std_logic;
signal validWrite:std_logic;
begin 
validRead<= '1' when r_req='1' and empty_temp='0' else '0';
validWrite<= '1'when  w_req='1' and full_temp ='0' else '0';

rCounter:GrayCounter port map(rdclk,validRead,reset,readTemp);
rConvert:gray2binary port map(readTemp,temp_rd_ptr);

wCounter:GrayCounter port map(wrclk,validWrite,reset,writeTemp);
wConvert:gray2binary port map(writeTemp,temp_wr_ptr);

full<=full_temp;
empty<=empty_temp;
write_valid<= validWrite;
read_valid<= validRead;

p1:process(temp_rd_ptr,temp_wr_ptr) is
begin
if temp_wr_ptr+1 = temp_rd_ptr then
full_temp<='1';
empty_temp<= '0';
elsif temp_rd_ptr= temp_wr_ptr then
full_temp <='0'; empty_temp <= '1';
else 
full_temp<='0';
empty_temp<='0';
end if;
next_wr_ptr<= temp_wr_ptr+1;
end process p1;

wr_ptr<=temp_wr_ptr;
rd_ptr<=temp_rd_ptr;




end architecture behave;