LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY bc IS
PORT (reset, clk, inicio: in std_logic;
    Az, Bz: in std_logic;
    pronto, ini, CA, dec, CP: out std_logic
    );
end bc;

architecture bhv of bc is
    type state_type is (S0, S1, S2, S3, S4, S5);
    signal state: state_type;

begin

    process (clk, reset)
    begin 
        if(reset='1') then
            state <= SO;
        elsif (clock'event and clock= '1') then
            case state is
                when S0 =>
                    if inicio='1' then
                        state <= S1;
                    else
                        state <= S0;
                    end if;


