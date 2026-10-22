library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder_tb is
end entity encoder_tb;

architecture uut of encoder_tb is
    signal s_clk   : std_logic := '0';
    signal s_rst_n : std_logic := '0';
    signal s_A     : std_logic := '0';
    signal s_B     : std_logic := '0';
    signal s_cnt   : unsigned(9 downto 0);
    constant c_period : time := 20 ns;
begin
    uut : entity work.encoder
        port map (
            i_clk   => s_clk,
            i_rst_n => s_rst_n,
            i_A     => s_A,
            i_B     => s_B,
            o_cnt   => s_cnt
        );

    s_clk <= not s_clk after c_period / 2;

    process
    begin
        -- reset
        s_rst_n <= '0';
        wait for 100 ns;
        s_rst_n <= '1';
        wait for 100 ns;

        -- right turn
        s_A <= '1'; wait for 100 ns;
        s_B <= '1'; wait for 100 ns;
        s_A <= '0'; wait for 100 ns;
        s_B <= '0'; wait for 100 ns;
        assert s_cnt = to_unsigned(2, 10);
          

        -- left turn: 00 -> 01 -> 11 -> 10 -> 00
        s_B <= '1'; wait for 100 ns;
        s_A <= '1'; wait for 100 ns;
        s_B <= '0'; wait for 100 ns;
        s_A <= '0'; wait for 100 ns;
        assert s_cnt = to_unsigned(0, 10);

        wait;
    end process;
end architecture uut;
