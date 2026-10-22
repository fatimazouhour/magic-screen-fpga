library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder is  
    generic(
        reg_size : positive  --register size
    )                 
    port (
        i_clk   : in std_logic;
        i_rst_n : in std_logic;
        i_A     : in std_logic;
        i_B     : in std_logic;
        o_cnt: out unsigned(9 downto 0)
    );
end entity encoder;

architecture rtl of encoder is       
    signal r_A : std_logic := '0'; 
    signal r_B: std_logic := '0';
    signal r_cnt: unsigned(9 downto 0) := (others => '0');
begin
    process(i_clk, i_rst_n)
    begin
        if i_rst_n = '0' then
            r_A <= '0'; 
            r_B <= '0';
            r_cnt <= (others => '0');
        elsif rising_edge(i_clk) then
            if ((r_A = '0' and i_A ='1') and i_B= '0') or 
                ((r_A='1' and i_A='0') and i_B='1') then
                r_cnt <= r_cnt + 1; --increment 
            elsif ((r_B='0' and i_B='1') and i_A='0') or 
                ((r_B='1' and i_B='0') and i_A='1') then
                r_cnt <= r_cnt - 1; --decrement
            end if;
            r_A <= i_A;
            r_B <= i_B;

        end if;
    end process;
    o_cnt <= r_cnt;
end architecture rtl;