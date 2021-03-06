LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY somadorsubtrator IS
PORT (a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      op: IN STD_LOGIC;
      s : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END somadorsubtrator;

ARCHITECTURE estrutura OF somadorsubtrator IS
BEGIN
	WITH op SELECT
         s <= ("0000" & a) + b WHEN '0',
              ("0000" & a) - b WHEN OTHERS;
END estrutura;