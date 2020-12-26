LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Fifo is
port(
reset,rclk,wclk,rreq,wreq:in std_logic;
datain:in std_logic_vector(7 downto 0);
full,empty:out std_logic;
dataout:out std_logic_vector(7 downto 0)
);
end entity Fifo;

architecture behave of Fifo is

component myRam is 
port(
        d_in :          IN            std_logic_vector(7 downto 0);
        d_out:          OUT           std_logic_vector(7 downto 0);
        writeEnable:    IN            std_logic;
        readEnable:     IN            std_logic;
        writeAddress:   IN            std_logic_vector(2 downto 0);
        readAddress:     IN            std_logic_vector(2 downto 0);
        clkA:           IN            std_logic;
        clkB:           IN            std_logic

);
end component myRam ;


component FifoControler is 
port(
reset,rdclk,wrclk,r_req,w_req:in std_logic;
empty,full,write_valid,read_valid:out std_logic;
wr_ptr,rd_ptr:out std_logic_vector(2 downto 0)
);
end component FifoControler;

for all:myRam use entity work.myram(behave);
for all: FifoControler use entity work.FifoControler(behave);


signal wr_ptr_signal,rd_ptr_signal:std_logic_vector(2 downto 0);
signal write_valid_signal,read_valid_signal:std_logic;
begin

myControler:FifoControler port map(reset,rclk,wclk,rreq,wreq,empty
,full,write_valid_signal,read_valid_signal,wr_ptr_signal,rd_ptr_signal);

ram:myRam port map(datain,dataout,write_valid_signal,read_valid_signal,wr_ptr_signal,rd_ptr_signal,
wclk,rclk);

end architecture behave;
