LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY ula IS 
PORT (  CLK: in std_logic;
		  A, B : IN std_LOGIC_VECTOR (7 DOWNTO 0);
        ULAop: IN STD_LOGIC_VECTOR(7 downto 0);
        S: OUT std_LOGIC_VECTOR(7 DOWNTO 0);
        Z, HALT, READY: OUT STD_LOGIC
        );
END ula;

ARCHITECTURE behaviour OF ula IS

component Divisor is port ( 
  CLK: in std_logic;
  N,D : in std_logic_vector(7 downto 0);
  Resultado: out std_logic_vector(7 downto 0);
  Ready: out std_logic
  );
end component;

signal div_ready, others_ready: std_logic;
signal Stest, Saux: std_LOGIC_VECTOR(7 downto 0); 
signal soma, sub, mult, div: std_LOGIC_VECTOR (7 downto 0);
BEGIN 

Divisao: Divisor port map (CLK ,A,B, div, div_ready);


WITH ULAop SELECT
    Saux <= --Logic
		(Saux) when "00000000",
		(A + B) when "00000001",
		(A - B) when "00000010",
		(A + 1) when "00000011",
		(A - 1) when "00000100",
		(not(A)) when "00000101",
		(A and B) when "00000110",
		(A or B) when "00000111",
		(A xor B) when "00001000",
		(A) when "00001001", --aqui tem que ver o que vamos fazer com a multiplicação, acho que vai ter que arrumar S e Saux dai mas problema pra outra hora.
		(div) when "00001010",
		(Saux) when others; 
		
HALT <= '1' when ULAop > "1010"; --flag de HALT
others_ready <= '1' when ULAop /= "00001010";
READY <= div_ready or others_ready; --a única operação que REALMENTE precisa da flag READY é a divisão, todas as outras operações são resolvidas em 1 ciclo de clock.
	

S <= Saux(7 downto 0);
Stest <= Saux(7 downto 0);

Z <= '1' when Stest = 0 else '0';



END behaviour;
