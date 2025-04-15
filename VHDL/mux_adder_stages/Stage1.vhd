library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;


entity Stage1 is
    Port ( 
        input  : in  reg_file_8_32;
        K      : in std_logic_vector(31 downto 0);
        W      : in std_logic_vector(31 downto 0);
        output : out reg_file_8_32
    );
end Stage1;


architecture rtl of Stage1 is

    component Sigma0 is
        Port ( 
            input  : in  std_logic_vector(31 downto 0);
            output : out std_logic_vector(31 downto 0)
        );
    end component;

    component Sigma1
        Port ( 
            input  : in  std_logic_vector(31 downto 0);
            output : out std_logic_vector(31 downto 0)
        );
    end component;

    component Ch
        Port ( 
            x  : in  std_logic_vector(31 downto 0);
            y  : in  std_logic_vector(31 downto 0);
            z  : in  std_logic_vector(31 downto 0);
            output : out std_logic_vector(31 downto 0)
        );
    end component;

    component Maj
        Port ( 
            x  : in  std_logic_vector(31 downto 0);
            y  : in  std_logic_vector(31 downto 0);
            z  : in  std_logic_vector(31 downto 0);
            output : out std_logic_vector(31 downto 0)
        );
    end component;

    component Adder_5
        Port ( 
            a  : in  std_logic_vector(31 downto 0);
            b  : in  std_logic_vector(31 downto 0);
            c  : in  std_logic_vector(31 downto 0);
            d  : in  std_logic_vector(31 downto 0);
            e  : in  std_logic_vector(31 downto 0);
            output : out std_logic_vector(31 downto 0)
        );
    end component;
signal T1, T2 : std_logic_vector(31 downto 0);
    signal temp1, temp2, temp3, temp4 : std_logic_vector(31 downto 0);

begin

    Sigma0_0 : Sigma0 Port map (input => input(0), output => temp1);
    Maj_0    : Maj Port map (x => input(0), y => input(1), z => input(2), output => temp2);
    T2 <= std_logic_vector(unsigned(temp1) + unsigned(temp2));
    Sigma1_0 : Sigma1 Port map (input => input(4), output => temp3);
    Ch_0    : Ch Port map (x => input(4), y => input(5), z => input(6), output => temp4);
    Adder_5_0 : Adder_5 Port map (a => temp3, b => temp4, c => input(7), d => K, e => W, output => T1);


    output(0) <= std_logic_vector(unsigned(T1) + unsigned(T2));
    output(1) <= input(0);
    output(2) <= input(1);
    output(3) <= input(2);
    output(4) <= std_logic_vector(unsigned(input(3)) + unsigned(T1));
    output(5) <= input(4);
    output(6) <= input(5);
    output(7) <= input(6);



end rtl;