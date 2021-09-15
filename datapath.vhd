LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY datapath IS PORT 
(		A, B, operacao: in std_logic_vector(7 downto 0);
		clk: in std_logic;
		Z: out std_logic;
		SAIDA: out std_logic_vector(15 downto 0));
end datapath;

architecture datap of datapath is

component bo is port(
		A, B, operacao: in std_logic_vector(7 downto 0);
		enable_a, enable_b, enable_ULA, enable_saida, clk: in std_logic;
		Z, HALT, READY: out std_logic;
		SAIDA: out std_logic_vector(15 downto 0));
end component;

component bc is port(
	 halt: IN STD_LOGIC;
    reset: IN STD_LOGIC;
    CLK: IN STD_LOGIC;
    en_pc, en_A, en_b, ena_operacoes: OUT STD_LOGIC;
	 ready: in STD_LOGIC;
	 ena_saida: OUT STD_LOGIC);
end component;

signal en_PC, en_A, en_B, en_op, en_saida, sem_operacao, halt, ready, reset: std_logic;


begin

BLOCO_DE_CONTROLE: bc port map( halt,reset, clk, en_PC, en_A, en_B, en_op, ready, en_saida);
BLOCO_OPERACIONAL: bo port map( A, B, operacao,en_A, en_B, en_op, en_saida, clk, Z, halt, ready, SAIDA);

end datap;