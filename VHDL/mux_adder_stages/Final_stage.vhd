library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;

entity Final_stage is
    port (
        clk : in std_logic;
        abcdefg : in reg_file_8_32;
        initial_hash : in reg_file_8_32;
        s2 : in std_logic_vector(1 downto 0);
        hash : out reg_file_8_32
    );
end Final_stage;


architecture rtl of Final_stage is

    signal H_i_1,add : reg_file_8_32;
    signal H_i : reg_file_8_32;

begin

gen:
for i in 0 to 7 generate
    add(i) <= std_logic_vector( unsigned(H_i(i)) + unsigned(abcdefg(i)) );
end generate;

with s2 select
H_i_1 <= add when "00",
       initial_hash when "01",
       H_i when others;


hash <= H_i;

proccess:
process(clk)
begin

if clk'event and clk='1' then


	H_i <= H_i_1;

end if;

end process;



end rtl;