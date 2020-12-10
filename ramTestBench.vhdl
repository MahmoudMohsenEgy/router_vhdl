
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity testbench is
end testbench;


architecture testing of testbench is 

    component myram
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
    end component;
	 for dut :myram use Entity work.myram(behave);

    signal clkA : std_logic;
    signal clkB : std_logic;
    signal writeEnable : std_logic;
    signal readEnable : std_logic;
    signal d_in : std_logic_vector(7 downto 0);
    signal writeAddress : std_logic_vector(2 downto 0);
    signal readAddress : std_logic_vector(2 downto 0);
    signal d_out : std_logic_vector(7 downto 0);
    
    -- Clock period definitions
    constant timeSlice : time := 10 ns;
begin
    dut: myram port map(d_in,d_out,writeEnable,readEnable,writeAddress,readAddress,clkA,clkB);
    
    clock : process
    begin
        clkA <='0';
	clkB <='0';
        wait for timeSlice/2;
        clkA<='1';
	clkB <='1';
        wait for timeSlice/2;
    end process clock;
    
p2: process
    begin
        writeEnable <= '1';
	readEnable <= '0';
        for i in 1 to 8 loop
            d_in <= conv_std_logic_vector(i-1,8);
            writeAddress <= conv_std_logic_vector(i-1,3);
            wait for 10 ns;
        end loop;
        writeEnable <='0';
        readEnable <='1';
        for i in 1 to 16 loop
            readAddress <= conv_std_logic_vector(i-1,3);
            wait for 10 ns;
        end loop;
	wait;
end process p2;
        

        

end architecture testing;