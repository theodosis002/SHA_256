library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;

entity Initial_hash_reg is
    port (
        initial_hash : out reg_file_8_32
    );
end Initial_hash_reg;

architecture rtl of Initial_hash_reg is
begin
    initial_hash(0) <= X"6a09e667";  -- Initial hash values for SHA-256
    initial_hash(1) <= X"bb67ae85";
    initial_hash(2) <= X"3c6ef372";
    initial_hash(3) <= X"a54ff53a";
    initial_hash(4) <= X"510e527f";
    initial_hash(5) <= X"9b05688c";
    initial_hash(6) <= X"1f83d9ab";
    initial_hash(7) <= X"5be0cd19";
end rtl;
