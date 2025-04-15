library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Data_pack.all;

entity Reg_file is
    port (
        clk : in std_logic;
        func : in std_logic;
        message : in std_logic_vector(M-1 downto 0);
        W : in std_logic_vector(M-1 downto 0);
        array_of_words : inout array_of_16_recent_words
    );
end Reg_file;

architecture Behavioral of Reg_file is

begin

process(clk)
begin

if clk'event and clk='1' then

    if func = '1' then
        array_of_words(N-1) <= W;
    else
        array_of_words(N-1) <= message;
    end if;

   	for i in 0 to array_of_words'length - 2 loop
		array_of_words(i) <= array_of_words(i+1);
	end loop;
        
end if;

end process;

end Behavioral;


