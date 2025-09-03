library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity smotor_halfstep is
    Port ( dir  : in  STD_LOGIC;
           rst  : in  STD_LOGIC;
           clk  : in  STD_LOGIC;
           a1b1a2b2 : out STD_LOGIC_VECTOR(3 downto 0));
end smotor_halfstep;

architecture Behavioral of smotor_halfstep is
    signal clkdiv  : std_logic_vector(15 downto 0) := (others => '0');
    signal count   : std_logic_vector(2 downto 0) := (others => '0');
    signal sig     : std_logic_vector(3 downto 0) := (others => '0');
    signal clkdiv2 : std_logic;
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
    if (rst = '1') then
        count <= "000";
    elsif rising_edge(clkdiv2) then
        if (dir = '1') then
            count <= count + 1;
        else
            count <= count - 1;
        end if;
    end if;
end process;

process(count)
begin
    case count is
        when "000" => sig <= "0001"; -- A1 ON
        when "001" => sig <= "0011";
        when "010" => sig <= "0010";
        when "011" => sig <= "0110";
        when "100" => sig <= "0100";
        when "101" => sig <= "1100";
        when "110" => sig <= "1000";
        when "111" => sig <= "1001";
        when others => sig <= "0000";
    end case;
end process;

a1b1a2b2 <= sig;

end Behavioral;
