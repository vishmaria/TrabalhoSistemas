  
library ieee;
use ieee.std_logic_1164.all;

entity somador_completo is port(
	a,b,c: in std_logic;
	sum,cout: out std_logic);
end somador_completo;

architecture comportamento of somador_completo is
begin
	sum <= a xor b xor c;
	cout <= (a and c) or (b and c) or (a and b);
end comportamento;