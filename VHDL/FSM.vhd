library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Data_pack.all;


entity SHA_256_fsm is
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
end SHA_256_fsm;

architecture rtl of SHA_256_fsm is

type state_type is (A, B, C, D);
signal state: state_type:= A;
signal counter: integer range 0 to 65 := 0;


begin

process(clk)
begin
	
	if clk'event and clk='1' then
	
	
	   if (counter>=1) and (counter < 65) then
	       count <= counter-1;
	   end if;
	
	
		case state is
			when A => 
			     done <= '0';
			     s2 <= "10"; -- hold previus hash
			     if work = '1' then 
					state <= B;
                    s0 <= '0'; -- keep mesaage in intact
					s1 <= "01"; -- initialize abc... with initial hash
                    s2 <= "01"; -- initialize Hash i-1 with initial hash
                    done <= '0'; 
                    ready <= '0';
                    counter <= counter + 1;
                    
                 elsif continue = '1' then
                    state <= B;
                    S0 <='0';
                    s1 <= "00"; -- abcde... = Hash i-1
                    s2 <= "10"; -- hold previus hash
                    ready <= '0';
                    counter <= counter + 1;
				  end if;
				  
				  
				         
			when B => 
			    if counter = 2 then
			        s1 <= "10"; -- feed stage 1 with previous abcde.. result
			    end if;
			 
                if counter = 15 then 
                    state <= C;
                    s0 <= '1'; -- calculate with existing messages W17-W63
                end if;
                counter <= counter + 1;
            when C => 
                if counter = 64 then 
                    state <= D;
                    s0 <= '0';
			        s1 <= "10";
                    
                    
                end if;
                counter <= counter + 1;
            when D => 
                state <=A;
                counter <=0;
                s0 <= '0'; -- keep mesaage in intact
                s1 <= "00"; -- load abcde... with H i-1
                s2 <= "00"; -- add abcde... + H i-1
                done <= '1'; 
                ready <= '1';

		  end case;
	
	end if;

end process;


end rtl;
