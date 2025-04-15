LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity sigma_1 is
    generic(number_of_bits_per_word: natural := 32);
    port(word_input: in std_logic_vector(number_of_bits_per_word-1 downto 0);
	 word_output: out std_logic_vector(number_of_bits_per_word-1 downto 0));
end sigma_1;


architecture behavior_of_sigma_1 of sigma_1 is
constant w : integer := word_input'length;
signal term_1, term_2, term_3: std_logic_vector(number_of_bits_per_word-1 downto 0);

begin

term_1 <= word_input(16 downto 0)& word_input(number_of_bits_per_word-1 downto 17);

term_2 <= word_input(18 downto 0)& word_input(number_of_bits_per_word-1 downto 19);

term_3 <= "0000000000" & word_input(number_of_bits_per_word-1 downto 10);

word_output <= term_1 xor term_2 xor term_3;


end behavior_of_sigma_1;


