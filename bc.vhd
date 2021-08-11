LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY bc IS
PORT (reset, clk, inicio: in std_logic;
    Az, Bz: in std_logic;
    pronto, ini, CA, dec, CP: out std_logic
    );
end bc;

architecture bhv of bc is
    type STATES is (S0, S1, S2, S3, S4, S5);
    signal state_n, next_state: STATES;

begin

    P1: process (clk, reset)
    begin 
        if(reset='1') then
            state_n<= S0;
        elsif (clk'event and clk= '1') then
				state_n <= next_state;
		  end if;
	end process;
	
	P2: process(state_n, Az, Bz, inicio)
	begin
            case state_n is
                when S0 =>
                    pronto <= '0';
                    ini <= '0'; 
                    CA <= '0';
                    dec <= '0';
                    CP <= '0'; 
                    if inicio='1' then
                        next_state <= S1;
                    else
                        next_state <= S0;
                    end if;
                
                when S1 =>
                    pronto <= '0';
                    ini <= '1'; 
                    CA <= '1';
                    dec <= '0';
                    CP <= '0'; 
                    next_state <= S2;

                when S2 =>
                    pronto <= '0';
                    ini <= '1'; 
                    CA <= '1';
                    dec <= '0';
                    CP <= '0'; 
                   if Az ='0' and Bz='0' then
                        next_state <= S3;
                    elsif Az='1' or Bz='1' then
                        next_state <= S5;
                    else
                        next_state <= S2;
                    end if;

                when S3 =>
                    pronto <= '0';
                    ini <= '1'; 
                    CA <= '1';
                    dec <= '0';
                    CP <= '1'; 
                    next_state <= S4;

                when S4 =>
                    pronto <= '0';
                    ini <= '1'; 
                    CA <= '1';
                    dec <= '1';
                    CP <= '1'; 
                    next_state <= S5;

                when S5 =>
                    pronto <= '1';
                    ini <= '1'; 
                    CA <= '1';
                    dec <= '1';
                    CP <= '1'; 
                    next_state <= S0;
            end case;
	end process;
end bhv;



