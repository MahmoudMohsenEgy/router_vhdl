
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity myRam is 
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
end entity myRam ;

architecture behave of myRam is 
--defining the ram 2d

--word is 8 bits as data in and data out are 8bits
subtype word is std_logic_vector(7 downto 0);  
--ram is an array of words and it is height 8bits as addressA and adressB are 3 bits 2^3 = 8
type ramType is array(7 downto 0 ) of word;

signal ram : ramType;

begin
    write: process(clkA)
    begin
    if rising_edge(clkA) then
        if writeEnable = '1' then
           ram(CONV_INTEGER(writeAddress)) <= d_in;
        end if;
    end if;
    end process write;
    read: process(clkB)
    begin
    if rising_edge(clkB) then
        if readEnable='1' then
            d_out <= ram(CONV_INTEGER(readAddress));
        end if;
    end if;
        
        
    end process read;


   
end architecture behave;