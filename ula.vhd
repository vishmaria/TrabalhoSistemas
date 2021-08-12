LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY ula IS 
GENERIC (M : INTEGER := 4);
PORT ( A, B : IN std_LOGIC_VECTOR (M-1 DOWNTO 0);
        ULAop: IN STD_LOGIC_VECTOR(3 downto 0);
        S: OUT std_LOGIC_VECTOR((M*2)-1 DOWNTO 0);
        N, Z, OV: OUT STD_LOGIC
        );
END ula;

ARCHITECTURE behaviour OF ula IS

component somadorsubtrator IS
PORT (a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      op: IN STD_LOGIC;
      s : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END component;

component MultiplicadorWallace is port( 
	A,B: in  std_LOGIC_VECTOR(3 downto 0);
	Resultado:  out std_LOGIC_VECTOR(7 downto 0));
end component;

signal A_auxiliar, B_auxiliar: std_LOGIC_VECTOR(M downto 0); 
signal Stest, Saux: std_LOGIC_VECTOR(2*M-1 downto 0); 
signal soma, sub, mult: std_LOGIC_VECTOR (2*M -1 downto 0);
BEGIN 

S0: somadorsubtrator port map (A, B, '0',soma);
S1: somadorsubtrator port map (A, B, '1',sub);
Multi: MultiplicadorWallace port map (A, B, mult);
A_auxiliar <= (A(M-1) & A);
B_auxiliar <= (B(M-1) & B);


WITH ULAop SELECT
    Saux <= --Logic
		("000" & not A_auxiliar) when "0000",
		("000" & not B_auxiliar) when "0001",
		("000" & A_auxiliar or "000" & B_auxiliar) when "0011",
		("000" & A_auxiliar nand "000" & B_auxiliar) when "0100",	
		("000" & A_auxiliar nor "000" & B_auxiliar) when "0101",
		("000" & A_auxiliar xor "000" & B_auxiliar) when "0110",
		("000" & A_auxiliar xnor "000" & B_auxiliar) when "0111",
		(soma) when "1000",
		(sub) when "1001",
		(mult) when others;

S <= Saux((M*2)-1 downto 0);
Stest <= Saux((M*2)-1 downto 0);



N <= '1' when Stest < 0 else '0';
Z <= '1' when Stest = 0 else '0';


OV <= '1' when
(((A_auxiliar>0 and B_auxiliar>0 and Stest<0) or (A_auxiliar < 0 and B_auxiliar < 0 and Stest > 0))) or
((A_auxiliar > 0 and Stest < 0) or (A_auxiliar < 0 and Stest > 0)) or
(((A_auxiliar>0 and B_auxiliar<0 and Stest<0) or (A_auxiliar < 0 and B_auxiliar > 0 and Stest > 0))) or
(((B_auxiliar > 0 and Stest < 0) or (B_auxiliar < 0 and Stest > 0)))
else '0';



END behaviour;