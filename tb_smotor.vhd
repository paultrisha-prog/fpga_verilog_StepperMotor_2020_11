library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_smotor is
end tb_smotor;

architecture behavior of tb_smotor is
    signal dir   : std_logic := '1';
    signal rst   : std_logic := '0';
    signal clk   : std_logic := '0';
    signal outp  : std_logic_vector(3 downto 0);
    
    component smotor
        Port ( dir : in  STD_LOGIC;
               rst : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               a1b1a2b2 : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
begin
    uut: smotor Port Map (dir => dir, rst => rst, clk => clk, a1b1a2b2 => outp);
    
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    
    stim_proc: process
    begin
        rst <= '1'; wait for 40 ns;
        rst <= '0';
        dir <= '1'; wait for 200 ns; -- CW
        dir <= '0'; wait for 200 ns; -- CCW
        wait;
    end process;
end;
