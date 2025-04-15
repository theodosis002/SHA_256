library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;

entity SHA_256_tb is
end SHA_256_tb;

architecture Behavioral of SHA_256_tb is
    -- Component declaration
    component SHA_256 is
        Port ( 
        clk, reset 	: in std_logic;
        message 	: in std_logic_vector(31 downto 0);
        work    : in  std_logic;
        send_hash : in std_logic;
        continue : in std_logic;
        hash   : out std_logic_vector(31 downto 0);
        done      : out std_logic;
        ready : out std_logic
    );
    end component;
    
    -- Signal declarations
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal start : STD_LOGIC;
    signal message : STD_LOGIC_VECTOR(31 downto 0);
    signal done : STD_LOGIC;
    signal hash_RES : STD_LOGIC_VECTOR(31 downto 0);
    signal continue : std_logic;
    signal send_result : std_logic;
    signal ready : std_logic;
    
    -- Clock period definition
    constant clk_period : time := 10 ns;
    
    -- Message blocks array
    type message_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    constant test_message : message_array := (
        "01110100011010000110010101101111",  -- Block 0
    "01100100011011110111001101101001",  -- Block 1
    "01110011011100110110000101100001",  -- Block 2
    "01100101011001100110010101110010",  -- Block 3
    "01100111011101000111001001100111",  -- Block 4
    "01110010011101000111100101101000",  -- Block 5
    "01110100011110010110100001111001",  -- Block 6
    "01110100011010000111010000110101",  -- Block 7
    "01110100001101000011010101111001",  -- Block 8
    "00110101001101100111100100110100",  -- Block 9
    "01110010011100100111001001110010",  -- Block 10
    "01110010011100100111001001110010",  -- Block 11
    "01110010011100100111001001110010",  -- Block 12
    "01110010011100100111001001110010",  -- Block 13
    "01110010011100100111001001110010",  -- Block 14
    "01110010011100100111001001110010",  -- Block 15
    "01110010011100100111001001110010",  -- Block 16
    "01110010011100100111001001110010",  -- Block 17
    "01110010011100100111001001110010",  -- Block 18
    "01110010011100100111001001110010",  -- Block 19
    "01110010011100100111100110000000",  -- Block 20
    "00000000000000000000000000000000",  -- Block 21
    "00000000000000000000000000000000",  -- Block 22
    "00000000000000000000000000000000",  -- Block 23
    "00000000000000000000000000000000",  -- Block 24
    "00000000000000000000000000000000",  -- Block 25
    "00000000000000000000000000000000",  -- Block 26
    "00000000000000000000000000000000",  -- Block 27
    "00000000000000000000000000000000",  -- Block 28
    "00000000000000000000000000000000",  -- Block 29
    "00000000000000000000000000000000",  -- Block 30
    "00000000000000000000001010011000" 
    );

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: SHA_256 port map (
        clk => clk,
        reset => rst,
        message =>message,
        work => start,
        send_hash =>send_result,
        continue => continue,
        hash => hash_RES,
        done =>done,
        ready =>ready
    );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        wait for clk_period;
        wait for 5*clk_period;
        message <= test_message(0);
        start <= '1';
        wait for clk_period;
        start <= '0';
        message <= test_message(1);
        wait for clk_period;

        -- Combine message blocks into single 512-bit message
        for i in 2 to 15 loop
            message <= test_message(i);
            wait for clk_period;
        end loop;


       wait for 60*clk_period;
       
        message <= test_message(16);
        continue <= '1';
        wait for clk_period;
        continue <= '0';
        message <= test_message(17);
        wait for clk_period;

        -- Combine message blocks into single 512-bit message
        for i in 18 to 31 loop
            message <= test_message(i);
            wait for clk_period;
        end loop;


       wait for 60*clk_period;
       send_result <= '1';
       wait for clk_period;
       send_result<='0';
       wait for 50*clk_period;
    end process;

end Behavioral;
