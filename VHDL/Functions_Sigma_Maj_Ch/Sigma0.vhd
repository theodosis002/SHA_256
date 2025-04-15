library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Sigma0 is
    Port ( 
        input  : in  std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
end Sigma0;

architecture rtl of Sigma0 is
begin
    output <= std_logic_vector(rotate_right(unsigned(input), 2) xor 
                             rotate_right(unsigned(input), 13) xor 
                             rotate_right(unsigned(input), 22));

end rtl;
