library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Data_pack.all;

entity Logic_ms is
    port (
        W_T_2 : in std_logic_vector(31 downto 0);
        W_T_7 : in std_logic_vector(31 downto 0);
        W_T_15 : in std_logic_vector(31 downto 0);
        W_T_16 : in std_logic_vector(31 downto 0);
        W_T : out std_logic_vector(31 downto 0)
    );
end Logic_ms;

architecture Behavioral of Logic_ms is

component sigma_1 is
    generic(number_of_bits_per_word: natural := 32);
    port(word_input: in std_logic_vector(number_of_bits_per_word-1 downto 0);
	 word_output: out std_logic_vector(number_of_bits_per_word-1 downto 0));
end component;

component sigma_0 is
    generic(number_of_bits_per_word: natural := 32);
    port(word_input: in std_logic_vector(number_of_bits_per_word-1 downto 0);
	 word_output: out std_logic_vector(number_of_bits_per_word-1 downto 0));
end component;


    signal s0 : std_logic_vector(31 downto 0);
    signal s1 : std_logic_vector(31 downto 0);


begin
    Sig1 : sigma_1 port map(W_T_2,s0);
    Sig0 : sigma_0 port map(W_T_15,s1);
    W_T <= std_logic_vector((unsigned(s0) + unsigned(s1))+(unsigned(W_T_16)+unsigned(W_T_7)));
end Behavioral;
