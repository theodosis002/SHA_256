library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Data_pack is

	constant N : integer := 16;
	constant M : integer := 32;
	type array_of_16_recent_words is array (0 to N-1) of std_logic_vector(M-1 downto 0);
	type reg_file_8_32 is array (0 to 7) of std_logic_vector(31 downto 0);
    type K_array is array (0 to 63) of std_logic_vector(31 downto 0);


end package Data_pack;

