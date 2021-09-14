LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY ula IS 
PORT (  CLK: in std_logic;
		  A, B : IN std_LOGIC_VECTOR (7 DOWNTO 0);
        ULAop: IN STD_LOGIC_VECTOR(7 downto 0);
        S: OUT std_LOGIC_VECTOR(15 DOWNTO 0);
        Z, HALT, READY: OUT STD_LOGIC
        );
END ula;

ARCHITECTURE behaviour OF ula IS

component Divisor is port ( 
  CLK: in std_logic;
  N,D : in std_logic_vector(7 downto 0);
  Resultado: out std_logic_vector(15 downto 0);
  Ready: out std_logic
  );
end component;

component MultiplicadorWallace8 is port ( 
			  A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           prod : out  STD_LOGIC_VECTOR (15 downto 0)
	);
end component;

signal div_ready, others_ready: std_logic;
signal Stest, Saux, mult: std_LOGIC_VECTOR(15 downto 0); 
signal soma, sub, div: std_LOGIC_VECTOR (7 downto 0);
BEGIN 

Divisao: Divisor port map (CLK ,A,B, div, div_ready);
Multiplicacao: MultiplicadorWallace8 port map(A, B, mult);


WITH ULAop SELECT
    Saux <= --Logic
		(Saux) when "00000000",
		("0000000000000000" or A + B) when "00000001",
		("0000000000000000" or A - B) when "00000010",
		("0000000000000000" or A + 1) when "00000011",
		("0000000000000000" or A - 1) when "00000100",
		("0000000000000000" or (not(A))) when "00000101",
		("0000000000000000" or (A and B)) when "00000110",
		("0000000000000000" or (A or B)) when "00000111",
		("0000000000000000" or (A xor B)) when "00001000",
		(mult) when "00001001", --aqui tem que ver o que vamos fazer com a multiplicação, acho que vai ter que arrumar S e Saux dai mas problema pra outra hora.
		("0000000000000000" or (div)) when "00001010",
		("0000000000000000") when others; 
		
HALT <= '1' when ULAop > "1010"; --flag de HALT
others_ready <= '1' when ULAop /= "00001010";
READY <= div_ready or others_ready; --a única operação que REALMENTE precisa da flag READY é a divisão, todas as outras operações são resolvidas em 1 ciclo de clock.
	

S <= Saux;
Stest <= Saux;

Z <= '1' when Stest = 0 else '0';



END behaviour;