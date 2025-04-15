library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Data_pack.all;


entity W_function is
    generic(number_of_bits_per_word: natural := 32);
    port(
	message: in std_logic_vector(number_of_bits_per_word-1 downto 0);
	clk: in std_logic;
	s0 : in std_logic;
	W_t: out std_logic_vector(number_of_bits_per_word-1 downto 0)
	);
end W_function;


architecture message_scheduler_W_function of W_function is

	component Logic_ms is
		port (
			W_T_2 : in std_logic_vector(31 downto 0);
			W_T_7 : in std_logic_vector(31 downto 0);
			W_T_15 : in std_logic_vector(31 downto 0);
			W_T_16 : in std_logic_vector(31 downto 0);
			W_T : out std_logic_vector(31 downto 0)
		);
	end component;


	component Reg_file is
	    port (
        clk : in std_logic;
        func : in std_logic;
        message : in std_logic_vector(M-1 downto 0);
        W : in std_logic_vector(M-1 downto 0);
        array_of_words : inout array_of_16_recent_words
    );
	end component;

	signal W_T_2, W_T_7, W_T_15, W_T_16, W: std_logic_vector(number_of_bits_per_word-1 downto 0);
	signal array_of_words: array_of_16_recent_words;
begin


Reg_file_1 : Reg_file port map (clk, s0, message, W, array_of_words);

logic : Logic_ms port map (W_T_2, W_T_7, W_T_15, W_T_16, W);

W_T_2 <= array_of_words(N-2);
W_T_7 <= array_of_words(N-7);
W_T_15 <= array_of_words(N-15);
W_T_16 <= array_of_words(N-16);



processs:
process(clk)
begin


if clk'event and clk='1' then

    W_t <= array_of_words(N-1);
        
end if;

end process;

end message_scheduler_W_function;


