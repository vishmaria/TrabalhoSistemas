library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity conta8 is port ( 
  CLK: in std_logic;
  CLR: in std_logic;
  EN : in std_logic;
  S: out std_logic_vector(5 downto 0)
  );
end conta8;

architecture behv of conta8 is
  signal cnt: std_logic_vector(5 downto 0) := "000000";
begin

  process(CLK,CLR,EN)
  begin
  if EN='1' then
    if rising_edge(CLK) then 
      cnt <= cnt + "000001";
    end if;
  end if;
  end process;
  
  S <= cnt;

end behv;