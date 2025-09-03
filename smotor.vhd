library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity smotor is
    Port ( dir : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           a1b1a2b2 : out STD_LOGIC_VECTOR(3 downto 0));
end smotor;

architecture Behavioral of smotor is
signal clkdiv: std_logic_vector(15 downto 0) := (others => '0');
signal count: std_logic_vector(1 downto 0) := (others => '0');
signal sig: std_logic_vector (3 downto 0) := (others => '0');
signal clkdiv2: std_logic;
begin
process(clk)
begin
    if rising_edge(clk) then
        clkdiv <= clkdiv + 1;
    end if;
    clkdiv2 <= clkdiv(15);
end process;

process(clkdiv2, rst, dir)
begin
    if (rst='1') then
        count <= "00";
    elsif rising_edge(clkdiv2) then
        if (dir='1') then
            count <= count + 1;
        else
            count <= count - 1;
        end if;
    end if;
end process;

process(count)
begin
    if(count="00")then sig<="0011";
    elsif count="01"then sig<="0110";
    elsif count="10"then sig<="1100";
    elsif count="11"then sig<="1001";
    end if;
end process;

a1b1a2b2<=sig;
end Behavioral;
