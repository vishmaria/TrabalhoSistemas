library ieee;
use ieee.std_logic_1164.all;

entity meio_somador is port(
	a,b: in std_logic;
	s,cout: out std_logic);
end meio_somador;

architecture comportamento of meio_somador is
begin
	s <= a xor b;
	cout <= a and b;
end comportamento;