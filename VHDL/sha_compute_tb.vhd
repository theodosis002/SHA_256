library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;

entity tb_SHA_256_compute is
-- Testbench has no ports
end tb_SHA_256_compute;

architecture behavior of tb_SHA_256_compute is

    -- Component Declaration for the Unit Under Test (UUT)
    component SHA_256_compute is
        Port ( 
            clk, reset : in std_logic;
            W          : in std_logic_vector(31 downto 0);
            s0, s1     : in std_logic_vector(1 downto 0);
            count      : in integer range 0 to 63;
            hash       : inout reg_file_8_32
        );
    end component;
    
    -- Inputs
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal W        : std_logic_vector(31 downto 0) := (others => '0');
    signal s0       : std_logic_vector(1 downto 0) := "01";
    signal s1       : std_logic_vector(1 downto 0) := "01";
    signal count    : integer range 0 to 63 := 0;
    
    -- In/Out
    signal hash     : reg_file_8_32;
    
    -- Clock period definition
    constant clk_period : time := 10 ns;
    
    -- Message schedule for "abc" (all 64 words)
    type message_array is array (0 to 63) of std_logic_vector(31 downto 0);
    signal test_message : message_array := (
        -- Complete message schedule for "abc"
        X"61626380", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000018",
        X"61626380", X"000f0000", X"7da86405", X"600003c6",
        X"3e9d7b78", X"0183fc00", X"12dcbfdb", X"e2e2c38e",
        X"c8215c1a", X"b73679a2", X"e5bc3909", X"32663c5b",
        X"9d209d67", X"ec8726cb", X"702138a4", X"d3b7973b",
        X"93f5997f", X"3b68ba73", X"aff4ffc1", X"f10a5c62",
        X"0a8b3996", X"72af830a", X"9409e33e", X"24641522",
        X"9f47bf94", X"f0a64f5a", X"3e246a79", X"27333ba3",
        X"0c4763f2", X"840abf27", X"7a290d5d", X"065c43da",
        X"fb3e89cb", X"cc7617db", X"b9e66c34", X"a9993667",
        X"84badedd", X"c21462bc", X"1487472c", X"b20f7a99",
        X"ef57b9cd", X"ebe6b238", X"9fe3095e", X"78bc8d4b",
        X"a43fcf15", X"668b2ff8", X"eeaba2cc", X"12b1edeb"
    );
    
    -- Expected hash value for "abc" (for verification)
    constant expected_hash : reg_file_8_32 := (
        X"BA7816BF", X"8F01CFEA", X"414140DE", X"5DAE2223",
        X"B00361A3", X"96177A9C", X"B410FF61", X"F20015AD"
    );
    
    -- Function to convert std_logic_vector to hex string for reporting
    function slv_to_hex_string(slv: std_logic_vector) return string is
        variable hex_digit : string(1 to 1);
        variable result : string(1 to slv'length/4);
        variable v : std_logic_vector(3 downto 0);
    begin
        for i in 0 to slv'length/4-1 loop
            -- Take the 4 bits at the correct position
            v := slv(4*i+3 downto 4*i);
            
            -- Convert 4 bits to a hex character
            case v is
                when "0000" => hex_digit := "0";
                when "0001" => hex_digit := "1";
                when "0010" => hex_digit := "2";
                when "0011" => hex_digit := "3";
                when "0100" => hex_digit := "4";
                when "0101" => hex_digit := "5";
                when "0110" => hex_digit := "6";
                when "0111" => hex_digit := "7";
                when "1000" => hex_digit := "8";
                when "1001" => hex_digit := "9";
                when "1010" => hex_digit := "A";
                when "1011" => hex_digit := "B";
                when "1100" => hex_digit := "C";
                when "1101" => hex_digit := "D";
                when "1110" => hex_digit := "E";
                when "1111" => hex_digit := "F";
                when others => hex_digit := "X";
            end case;
            
            -- Add the digit to the result (from right to left)
            result(result'length-i) := hex_digit(1);
        end loop;
        return result;
    end function;
    
begin

    -- Instantiate the Unit Under Test (UUT)
    uut: SHA_256_compute port map (
        clk => clk,
        reset => reset,
        W => W,
        s0 => s0,
        s1 => s1,
        count => count,
        hash => hash
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
        variable hash_match : boolean := true;
    begin
        -- Reset the system
        reset <= '1';
        wait for clk_period*2;
        reset <= '0';
        wait for clk_period;
        
        -- Process the message block (64 rounds)
        for i in 0 to 63 loop
            -- Set the current message word
            W <= test_message(i);
            count <= i;
            
            if i = 0 then
                -- First round uses initial hash
                s0 <= "01";
            else
                -- Subsequent rounds use previous round output
                s0 <= "10";
            end if;
            
            -- Keep s1 as "10" during all rounds
            s1 <= "10";
            
            wait for clk_period;
        end loop;
        
        -- After all rounds complete, set s0 to select previous hash and s1 to perform final addition
        s0 <= "10";  -- Select hash_i-1
        s1 <= "00";  -- Now activate the final addition stage
        wait for clk_period;
        s1 <= "10";
        wait for clk_period;
        
        -- Verify the entire hash at once
        hash_match := true;
        for i in 0 to 7 loop
            if hash(i) /= expected_hash(i) then
                hash_match := false;
                exit;
            end if;
        end loop;
        
        -- Print a single message for the entire hash
        if hash_match then
            report "HASH MATCH" severity note;
        else
            report "HASH NO MATCH" severity error;
        end if;
        
        -- Print the final hash value for reference
        report "Final hash: " & 
               slv_to_hex_string(hash(0)) & 
               slv_to_hex_string(hash(1)) & 
               slv_to_hex_string(hash(2)) & 
               slv_to_hex_string(hash(3)) & 
               slv_to_hex_string(hash(4)) & 
               slv_to_hex_string(hash(5)) & 
               slv_to_hex_string(hash(6)) & 
               slv_to_hex_string(hash(7));
        
        report "Simulation completed";
        wait;
    end process;
end behavior;
