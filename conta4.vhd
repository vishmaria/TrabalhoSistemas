library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity conta4 is port ( 
  CLK: in std_logic;
  CLR: in std_logic;
  EN : in std_logic;
  S: out std_logic_vector(7 downto 0)
  );
end conta4;

architecture behv of conta4 is
  signal cnt: std_logic_vector(7 downto 0) := "00000000";
  
begin

  process(CLK,CLR,EN)
  begin
  if EN='1' then
    if (cnt = "1001") then
      cnt <= "0000";
    elsif (CLK'event and CLK = '1') then 
      cnt <= cnt + "0001";
    end if;
  end if;
  end process;
  
  S <= cnt;

end behv;