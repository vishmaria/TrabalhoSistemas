LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY datapath IS PORT 
(		A, B, operacao: in std_logic_vector(3 downto 0);
		clk: in std_logic;
		N,Z: out std_logic;
		SAIDA: out std_logic_vector(7 downto 0));
end datapath;

architecture arch of datapath is

component bo is port(
		A, B, operacao: in std_logic_vector(3 downto 0);
		enable_entradas, enable_ULA, enable_saida, clk: in std_logic;
		N,Z: out std_logic;
		sem_operacao: buffer std_logic; 
		SAIDA: out std_logic_vector(7 downto 0));
end component;

component bc is port(
	   sem_op: IN STD_LOGIC;
      reset: IN STD_LOGIC;
      CLK: IN STD_LOGIC;
      ena_entradas, ena_operacoes, ena_saida: OUT STD_LOGIC);
end component;

signal en_entradas, en_op, en_saida, sem_operacao, reset: std_logic;

begin

BLOCO_DE_CONTROLE: bc port map(sem_operacao,reset, clk, en_entradas, en_op, en_saida);
BLOCO_OPERACIONAL: bo port map(A,B,operacao,en_entradas,en_op, en_saida, clk, N,Z, sem_operacao, SAIDA);

end arch;