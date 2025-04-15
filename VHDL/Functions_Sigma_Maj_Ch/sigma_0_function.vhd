LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity sigma_0 is
    generic(number_of_bits_per_word: natural := 32);
    port(word_input: in std_logic_vector(number_of_bits_per_word-1 downto 0);
	 word_output: out std_logic_vector(number_of_bits_per_word-1 downto 0));
end sigma_0;


architecture behavior_of_sigma_0 of sigma_0 is

signal term_1, term_2, term_3: std_logic_vector(number_of_bits_per_word-1 downto 0);

begin

term_1 <= word_input(6 downto 0)& word_input(number_of_bits_per_word-1 downto 7);

term_2 <= word_input(17 downto 0)& word_input(number_of_bits_per_word-1 downto 18);

term_3 <= "000" & word_input(number_of_bits_per_word-1 downto 3);

word_output <= term_1 xor term_2 xor term_3;


end behavior_of_sigma_0;


