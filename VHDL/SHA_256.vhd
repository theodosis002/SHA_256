library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;


entity SHA_256 is
    Port ( 
        clk, reset 	: in std_logic;
        message 	: in std_logic_vector(31 downto 0);
        work    : in  std_logic;
        send_hash : in std_logic;
        continue : in std_logic;
        hash   : out std_logic_vector(31 downto 0);
        done      : out std_logic;
        ready : out std_logic:='0'
    );
end SHA_256;

architecture rtl of SHA_256 is

    component SHA_256_compute is
        Port ( 
            clk, reset 	: in std_logic;
            W      : in std_logic_vector(31 downto 0);
            s0, s1 : in std_logic_vector(1 downto 0);
            count  : in integer range 0 to 63;
            hash   : inout reg_file_8_32
        );
    end component;

    component W_function is
        generic(number_of_bits_per_word: natural := 32);
        port(
            message: in std_logic_vector(number_of_bits_per_word-1 downto 0);
            clk: in std_logic;
            s0 : in std_logic;
            W_t: out std_logic_vector(number_of_bits_per_word-1 downto 0)
        );
    end component;

    component SHA_256_fsm is
        port (
        clk     : in  std_logic;
        work    : in  std_logic;
        continue : in std_logic;
        done      : out std_logic;
        s0      : out std_logic :='0';
        s1      : out std_logic_vector(1 downto 0) := "01";
        s2      : out std_logic_vector(1 downto 0) := "01";
        count   : out integer range 0 to 63;
        ready   : out std_logic:='1'
    );
    end component;

    signal s0_sig : std_logic :='0';
    signal s1_sig : std_logic_vector(1 downto 0) := "01";
    signal s2_sig : std_logic_vector(1 downto 0) := "01";
    signal W_sig : std_logic_vector(31 downto 0) := (others => '0');
    signal count : integer range 0 to 63;
    signal hash_sig : reg_file_8_32;
    signal counter : integer range 0 to 15:=0;


begin

SHA_256_FSM_inst : SHA_256_fsm
    port map (
        clk     => clk,
        work    => work,
        continue => continue,
        done      => done,
        s0      => s0_sig,
        s1      => s1_sig,
        s2      => s2_sig,
        count   => count,
        ready   => ready
    );

    W_function_inst : W_function
    port map (
        message => message,
        clk => clk,
        s0 => s0_sig,
        W_t => W_sig
    );

    SHA_256_compute_inst : SHA_256_compute
    port map (
        clk => clk,
        reset => reset,
        W => W_sig,
        s0 => s1_sig,
        s1 => s2_sig,
        count => count,
        hash => hash_sig
    );
    
    process(clk)
    
    
    begin
    
    if clk'event and clk='1' then
        if (send_hash = '1') or (counter /= 0) then
            
            
            hash <= hash_sig(counter);
            
            if counter = 7 then
                counter <=0;
            else
                counter<=counter+1;
            end if;
        
        end if;
    
    end if;
    
    end process;



end rtl;
