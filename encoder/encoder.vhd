library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder is  
    generic(
        reg_size : positive := 10--register size
    );

    port (
        i_clk   : in std_logic;
        i_rst_n : in std_logic;
        i_A     : in std_logic;
        i_B     : in std_logic;
        o_cnt: out unsigned(reg_size-1 downto 0)
    );
end entity encoder;

architecture rtl of encoder is       
    signal r_A : std_logic := '0'; 
    signal r_B: std_logic := '0';

    signal r_A_sync: std_logic_vector(1 downto 0) := (others =>'0');
    signal r_B_sync: std_logic_vector(1 downto 0) := (others =>'0');

    signal r_cnt: unsigned(reg_size-1 downto 0);
begin
    process(i_clk, i_rst_n)
    begin
        if i_rst_n = '0' then
            r_A <= '0'; 
            r_B <= '0';

            r_A_sync <= (others => '0');
            r_B_sync <= (others => '0');

            r_cnt <= (others => '0');

        elsif rising_edge(i_clk) then

            r_A_sync <= r_A_sync(0) & i_A;
            r_B_sync <= r_B_sync(0) & i_B;

            if ((r_A = '0' and r_A_sync(1) ='1') and r_B_sync(1)= '0') or 
                ((r_A='1' and r_A_sync(1)='0') and r_B_sync(1)='1') then

                r_cnt <= r_cnt + 1; --increment 

            elsif ((r_B='0' and r_B_sync(1)='1') and r_A_sync(1)='0') or 
                ((r_B='1' and r_B_sync='0') and r_A_sync(1)='1') then

                r_cnt <= r_cnt - 1; --decrement

            end if;

            r_A <= r_A_sync(1);
            r_B <= r_B_sync(1);

        end if;
    end process;

    o_cnt <= r_cnt;

end architecture rtl;