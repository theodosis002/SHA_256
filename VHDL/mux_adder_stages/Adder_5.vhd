library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Adder_5 is
    Port ( 
        a  : in  std_logic_vector(31 downto 0);
        b  : in  std_logic_vector(31 downto 0);
        c  : in  std_logic_vector(31 downto 0);
        d  : in  std_logic_vector(31 downto 0);
        e  : in  std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
    );
end Adder_5;

architecture rtl of Adder_5 is
    signal s1,s2,s3 : std_logic_vector(31 downto 0);


begin
    s1 <= std_logic_vector(unsigned(a) + unsigned(b));
    s2 <= std_logic_vector(unsigned(s1) + unsigned(c));  
    s3 <= std_logic_vector(unsigned(d) + unsigned(e));
    output <= std_logic_vector(unsigned(s2) + unsigned(s3));
end rtl;
