library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Ch is
    Port ( 
        x  : in  std_logic_vector(31 downto 0);
        y  : in  std_logic_vector(31 downto 0);
        z  : in  std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
end Ch;

architecture rtl of Ch is
begin
    output <= (x and y) xor ((not x) and z); 
end rtl;
