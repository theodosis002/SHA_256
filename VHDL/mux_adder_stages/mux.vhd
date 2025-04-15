library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;

entity mux is
    port (
        initial_hash : in reg_file_8_32;
        stage_1_output : in reg_file_8_32;
        Hash_i_1 : in reg_file_8_32;
        s0 : in std_logic_vector(1 downto 0);
        output : out reg_file_8_32
    );
end mux;

architecture rtl of mux is
begin
    with s0 select
        output <= initial_hash when "01",
                  stage_1_output when "10",
                  Hash_i_1 when others;
end rtl;
