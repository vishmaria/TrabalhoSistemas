library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Divisor is port ( 
  CLK: in std_logic;
  N,D : in std_logic_vector(7 downto 0);
  Resultado: out std_logic_vector(7 downto 0);
  Ready: out std_logic
  );
end Divisor;

architecture behv of Divisor is
  signal aux: std_logic_vector(7 downto 0) := "00000000";
  signal intermed: std_logic_vector(7 downto 0) := "00000000";
begin

  process(CLK)
  begin
	 Ready <= '0';
    if (intermed < N) then
      intermed <= intermed + D;
		aux <= aux + 1;
    else
      Resultado <= aux;
		Ready <= '1';
		intermed <= "00000000";
		aux <= "00000000";
    end if;
  end process;
  
end behv;