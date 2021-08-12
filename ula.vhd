LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY ula IS 
PORT ( A, B : IN std_LOGIC_VECTOR (3 DOWNTO 0);
        ULAop: IN STD_LOGIC_VECTOR(3 downto 0);
        S: OUT std_LOGIC_VECTOR(7 DOWNTO 0);
        N, Z, sem_operacao: OUT STD_LOGIC
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

signal A_auxiliar, B_auxiliar: std_LOGIC_VECTOR(4 downto 0); 
signal Stest, Saux: std_LOGIC_VECTOR(7 downto 0); 
signal soma, sub, mult: std_LOGIC_VECTOR (7 downto 0);
BEGIN 

S0: somadorsubtrator port map (A, B, '0',soma);
S1: somadorsubtrator port map (A, B, '1',sub);
Multi: MultiplicadorWallace port map (A, B, mult);
A_auxiliar <= (A(3) & A);
B_auxiliar <= (B(3) & B);


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
		(mult) when "1010",
		(Saux) when others;

S <= Saux(7 downto 0);
Stest <= Saux(7 downto 0);

sem_operacao <= '1' when ULAop > "1010" else
					 '0';


N <= '1' when Stest < 0 else '0';
Z <= '1' when Stest = 0 else '0';



END behaviour;