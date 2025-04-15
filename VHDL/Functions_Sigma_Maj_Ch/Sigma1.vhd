library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Sigma1 is
    Port ( 
        input  : in  std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
end Sigma1;

architecture rtl of Sigma1 is
begin
    output <= std_logic_vector(rotate_right(unsigned(input), 6) xor 
                             rotate_right(unsigned(input), 11) xor 
                             rotate_right(unsigned(input), 25));

end rtl;
