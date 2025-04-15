library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Maj is
    Port ( 
        x  : in  std_logic_vector(31 downto 0);
        y  : in  std_logic_vector(31 downto 0);
        z  : in  std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
end Maj;

architecture rtl of Maj is
begin
    output <= (x and y) xor (x and z) xor (y and z); 
end rtl;
