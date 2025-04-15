library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;

entity SHA_256_compute is
    Port ( 
        clk, reset 	: in std_logic;
        W      : in std_logic_vector(31 downto 0);
        s0, s1 : in std_logic_vector(1 downto 0);
        count  : in integer range 0 to 63;
        hash   : inout reg_file_8_32
    );
end SHA_256_compute;

architecture rtl of SHA_256_compute is

    component Stage1 is
        Port ( 
            input  : in  reg_file_8_32;
            K      : in std_logic_vector(31 downto 0);
            W      : in std_logic_vector(31 downto 0);
            output : out reg_file_8_32
        );
    end component;


    component Constant_reg is
     port (
        t : in integer range 0 to 63;
        K : out std_logic_vector(31 downto 0)
    );
    end component;

    component Initial_hash_reg is
        port (
            initial_hash : out reg_file_8_32
        );
    end component;

    component mux is
    port (
        initial_hash : in reg_file_8_32;
        stage_1_output : in reg_file_8_32;
        Hash_i_1 : in reg_file_8_32;
        s0 : in std_logic_vector(1 downto 0);
        output : out reg_file_8_32
    );
    end component;

    component Final_stage is
    port (
        clk : in std_logic;
        abcdefg : in reg_file_8_32;
        initial_hash : in reg_file_8_32;
        s2 : in std_logic_vector(1 downto 0);
        hash : out reg_file_8_32
    );
end component;

    signal K : std_logic_vector(31 downto 0);
    signal inital_hash : reg_file_8_32;
    signal stage_1_output, stage_1_reg, output_mux, final_abcdefg: reg_file_8_32;

  
begin

    IH1: Initial_hash_reg port map(inital_hash); --Contains H0 Constant
    C1 : Constant_reg port map(count, K);            --K constants select based on t
    St1 : Stage1 port map(output_mux, K, W, stage_1_output);  --Calcultates each round (64 times per hash)
    M1 : mux port map(inital_hash,stage_1_reg, hash, s0, output_mux); --Selects the output based on s0 (from FSM) S0=1 initial hash, S0=0 stage 1 output, S0=2 hash_i-1

    Final : Final_stage port map(clk, final_abcdefg, inital_hash, s1, hash); -- Does the a+H and stores the new hash value

    
    process(clk, reset)
	
    begin
	
        if reset = '1' then 

           
			
		elsif rising_edge(clk) then	
            stage_1_reg <= stage_1_output; --abcdefgh reg for each round
            final_abcdefg <= stage_1_output;




		end if;
		
	end process;
	


end rtl;


