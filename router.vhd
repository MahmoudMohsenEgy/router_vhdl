LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity router is 
port(datai1,datai2,datai3,datai4 :in std_logic_vector(7 downto 0);
wr1,wr2,wr3,wr4,wclock,rclock,rst: in std_logic;
datao1,datao2,datao3,datao4:out std_logic_vector(7 downto 0));
end entity router;

architecture behave of router is

component reg8bits is 
port(data_in: in std_logic_vector(7 downto 0); 
clk:in std_logic; 
data_out:out std_logic_vector(7 downto 0 );
clk_en: in std_logic;
reset:in std_logic);
end component reg8bits;
for all:reg8bits use entity work.reg8bits(behave);


component deMux is 
port(d_in:in std_logic_vector(7 downto 0);
d_out1: out std_logic_vector(7 downto 0);
d_out2: out std_logic_vector(7 downto 0); 
d_out3: out std_logic_vector(7 downto 0);
d_out4: out std_logic_vector(7 downto 0);
sel:in std_logic_vector(1 downto 0);
en:in std_logic   );
end component deMux;
for all:deMux use entity work.demux(behave);

component Fifo is
port(
reset,rclk,wclk,rreq,wreq:in std_logic;
datain:in std_logic_vector(7 downto 0);
full,empty:out std_logic;
dataout:out std_logic_vector(7 downto 0)
);
end component Fifo;
for all:Fifo use entity work.fifo(behave);



component roundrobinScheduler is 
port(clk:in std_logic;
din1:in std_logic_vector(7 downto 0);
din2:in std_logic_vector(7 downto 0);
din3:in std_logic_vector(7 downto 0);
din4:in std_logic_vector(7 downto 0);
output:out std_logic_vector(7 downto 0));
end component roundRobinScheduler;
for all:roundrobinScheduler use entity work.roundrobinScheduler(behave);


signal tempoutBuffer1:std_logic_vector(7 downto 0);
signal tempoutBuffer2:std_logic_vector(7 downto 0);
signal tempoutBuffer3:std_logic_vector(7 downto 0);
signal tempoutBuffer4:std_logic_vector(7 downto 0);

signal tempoutSelector11:std_logic_vector(7 downto 0);
signal tempoutSelector12:std_logic_vector(7 downto 0);
signal tempoutSelector13:std_logic_vector(7 downto 0);
signal tempoutSelector14:std_logic_vector(7 downto 0);

signal tempoutSelector21:std_logic_vector(7 downto 0);
signal tempoutSelector22:std_logic_vector(7 downto 0);
signal tempoutSelector23:std_logic_vector(7 downto 0);
signal tempoutSelector24:std_logic_vector(7 downto 0);

signal tempoutSelector31:std_logic_vector(7 downto 0);
signal tempoutSelector32:std_logic_vector(7 downto 0);
signal tempoutSelector33:std_logic_vector(7 downto 0);
signal tempoutSelector34:std_logic_vector(7 downto 0);

signal tempoutSelector41:std_logic_vector(7 downto 0);
signal tempoutSelector42:std_logic_vector(7 downto 0);
signal tempoutSelector43:std_logic_vector(7 downto 0);
signal tempoutSelector44:std_logic_vector(7 downto 0);

signal outfifo11:std_logic_vector(7 downto 0);
signal outfifo12:std_logic_vector(7 downto 0);
signal outfifo13:std_logic_vector(7 downto 0);
signal outfifo14:std_logic_vector(7 downto 0);


signal outfifo21:std_logic_vector(7 downto 0);
signal outfifo22:std_logic_vector(7 downto 0);
signal outfifo23:std_logic_vector(7 downto 0);
signal outfifo24:std_logic_vector(7 downto 0);

signal outfifo31:std_logic_vector(7 downto 0);
signal outfifo32:std_logic_vector(7 downto 0);
signal outfifo33:std_logic_vector(7 downto 0);
signal outfifo34:std_logic_vector(7 downto 0);


signal outfifo41:std_logic_vector(7 downto 0);
signal outfifo42:std_logic_vector(7 downto 0);
signal outfifo43:std_logic_vector(7 downto 0);
signal outfifo44:std_logic_vector(7 downto 0);

--full and emty signals
signal full0:std_logic;
signal full1:std_logic;
signal full2:std_logic;
signal full3:std_logic;
signal full4:std_logic;
signal full5:std_logic;
signal full6:std_logic;
signal full7:std_logic;
signal full8:std_logic;
signal full9:std_logic;
signal full10:std_logic;
signal full11:std_logic;
signal full12:std_logic;
signal full13:std_logic;
signal full14:std_logic;
signal full15:std_logic;
signal empty0:std_logic;
signal empty1:std_logic;
signal empty2:std_logic;
signal empty3:std_logic;
signal empty4:std_logic;
signal empty5:std_logic;
signal empty6:std_logic;
signal empty7:std_logic;
signal empty8:std_logic;
signal empty9:std_logic;
signal empty10:std_logic;
signal empty11:std_logic;
signal empty12:std_logic;
signal empty13:std_logic;
signal empty14:std_logic;
signal empty15:std_logic;

--write requests
signal w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16:std_logic;

--read request
signal readRequest:std_logic_vector(3 downto 0);
signal nextState:std_logic_vector(3 downto 0);
begin
--buffers
inputBuffer1: reg8bits port map(datai1,wclock,tempoutBuffer1,wr1,rst);
inputBuffer2: reg8bits port map(datai2,wclock,tempoutBuffer2,wr2,rst);
inputBuffer3: reg8bits port map(datai3,wclock,tempoutBuffer3,wr3,rst);
inputBuffer4: reg8bits port map(datai4,wclock,tempoutBuffer4,wr4,rst);
--selectors
inputSelector1:deMux port map(tempoutBuffer1,tempoutSelector11,tempoutSelector12,tempoutSelector13,tempoutSelector14,tempoutBuffer1(1 downto 0),wr1);
inputSelector2:deMux port map(tempoutBuffer2,tempoutSelector21,tempoutSelector22,tempoutSelector23,tempoutSelector24,tempoutBuffer2(1 downto 0),wr2);
inputSelector3:deMux port map(tempoutBuffer3,tempoutSelector31,tempoutSelector32,tempoutSelector33,tempoutSelector34,tempoutBuffer3(1 downto 0),wr3);
inputSelector4:deMux port map(tempoutBuffer4,tempoutSelector41,tempoutSelector42,tempoutSelector43,tempoutSelector44,tempoutBuffer4(1 downto 0),wr4);
--queues

Fifo11:Fifo port map (rst,rclock,wclock,readRequest(0) ,w1 ,tempoutSelector11,full0,empty0,outfifo11);
Fifo12:Fifo port map (rst,rclock,wclock,readRequest(1),w2,tempoutSelector21,full1,empty1,outfifo12);
Fifo13:Fifo port map (rst,rclock,wclock,readRequest(2),w3,tempoutSelector31,full2,empty2,outfifo13);
Fifo14:Fifo port map (rst,rclock,wclock,readRequest(3),w4,tempoutSelector41,full3,empty3,outfifo14);

Fifo21:Fifo port map (rst,rclock,wclock,readRequest(0),w5,tempoutSelector12,full4,empty4,outfifo21);
Fifo22:Fifo port map (rst,rclock,wclock,readRequest(1),w6,tempoutSelector22,full5,empty5,outfifo22);
Fifo23:Fifo port map (rst,rclock,wclock,readRequest(2),w7,tempoutSelector32,full6,empty6,outfifo23);
Fifo24:Fifo port map (rst,rclock,wclock,readRequest(3),w8,tempoutSelector42,full7,empty7,outfifo24);


Fifo31:Fifo port map (rst,rclock,wclock,readRequest(0),w9,tempoutSelector13,full8,empty8,outfifo31);
Fifo32:Fifo port map (rst,rclock,wclock,readRequest(1),w10,tempoutSelector23,full9,empty9,outfifo32);
Fifo33:Fifo port map (rst,rclock,wclock,readRequest(2),w11,tempoutSelector33,full10,empty10,outfifo33);
Fifo34:Fifo port map (rst,rclock,wclock,readRequest(3),w12,tempoutSelector43,full11,empty11,outfifo34);

Fifo41:Fifo port map (rst,rclock,wclock,readRequest(0),w13,tempoutSelector14,full12,empty12,outfifo41);
Fifo42:Fifo port map (rst,rclock,wclock,readRequest(1),w14,tempoutSelector24,full13,empty13,outfifo42);
Fifo43:Fifo port map (rst,rclock,wclock,readRequest(2),w15,tempoutSelector34,full14,empty14,outfifo43);
Fifo44:Fifo port map (rst,rclock,wclock,readRequest(3),w16,tempoutSelector44,full15,empty15,outfifo44);

--outbuffers

roundrobin1:roundrobinScheduler port map (rclock,outfifo11,outfifo12,outfifo13,outfifo14,datao1);
roundrobin2:roundrobinScheduler port map (rclock,outfifo21,outfifo22,outfifo23,outfifo24,datao2);
roundrobin3:roundrobinScheduler port map (rclock,outfifo31,outfifo32,outfifo33,outfifo34,datao3);
roundrobin4:roundrobinScheduler port map (rclock,outfifo41,outfifo42,outfifo43,outfifo44,datao4);


w1<=not(full0) and wr1 and not(tempoutBuffer1(1) or tempoutBuffer1(0));
w5<= not full4 and wr1 and not tempoutBuffer1(1) and tempoutBuffer1(0);
w9<= not full8 and wr1 and tempoutBuffer1(1) and not tempoutBuffer1(0);
w13<= not full12 and wr1 and  tempoutBuffer1(1) and tempoutBuffer1(0);

w2<=not(full1) and wr2 and not(tempoutBuffer2(1) or tempoutBuffer2(0));
w6<= not full5 and wr2 and not tempoutBuffer2(1) and tempoutBuffer2(0);
w10<= not full9 and wr2 and tempoutBuffer2(1) and not tempoutBuffer2(0);
w14<= not full13 and wr2 and  tempoutBuffer2(1) and tempoutBuffer2(0);

w3<=not(full2) and wr3 and not(tempoutBuffer3(1) or tempoutBuffer3(0));
w7<= not full6 and wr3 and not tempoutBuffer3(1) and tempoutBuffer3(0);
w11<= not full10 and wr3 and tempoutBuffer3(1) and not tempoutBuffer3(0);
w15<= not full14 and wr3 and  tempoutBuffer3(1) and tempoutBuffer3(0);

w4<=not(full3) and wr4 and not(tempoutBuffer4(1) or tempoutBuffer4(0));
w8<= not full7 and wr4 and not tempoutBuffer4(1) and tempoutBuffer4(0);
w12<= not full11 and wr4 and tempoutBuffer4(1) and not tempoutBuffer4(0);
w16<= not full15 and wr4 and  tempoutBuffer4(1) and tempoutBuffer4(0);


p1:process(rst,rclock) is begin
if(rst='1') then readRequest<="0100";
elsif(rising_edge(rclock)) then readRequest<=nextState;
end if;
end process p1;

p2:process(readRequest) is begin
case readRequest is
when "0001"=> nextState<="0010";
when "0010"=>nextState<="0100"; 
when "0100"=>nextState<="1000";
when "1000"=>nextState<="0001";
when others => nextState<="0001";
end case;
end process p2;
end architecture behave;
