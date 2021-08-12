LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY bo IS PORT 
(		A, B, operacao: in std_logic_vector(3 downto 0);
		enable_entradas, enable_ULA, enable_saida, clk: in std_logic;
		sem_operacao, N,Z: out std_logic;
		SAIDA: out std_logic_vector(7 downto 0));
end bo;

architecture arch of bo is
	component ULA is port (
			A, B : IN std_LOGIC_VECTOR (3 DOWNTO 0);
         ULAop: IN STD_LOGIC_VECTOR(3 downto 0);
         S: OUT std_LOGIC_VECTOR(7 DOWNTO 0);
         N, Z, sem_operacao: OUT STD_LOGIC);
	end component;
	
	component registrador8 is port (
			CLK: in std_logic;
			RST: in std_logic;
			EN: in std_logic;
			D: in std_logic_vector(7 downto 0);
			Q: out std_logic_vector(7 downto 0));
	end component;
	
	
	component registrador4 is port (
			CLK: in std_logic;
			RST: in std_logic;
			EN: in std_logic;
			D: in std_logic_vector(3 downto 0);
			Q: out std_logic_vector(3 downto 0));
	end component;
	
	
	signal A_carregado, B_carregado, ULA_carregada: std_logic_vector(3 downto 0);
	signal saida_pro_reg: std_logic_vector(7 downto 0);
	
begin
	
	ULA_1: ula port map(A_carregado, B_carregado, ULA_carregada, saida_pro_reg, N, Z, sem_operacao);
	REG_A: registrador4 port map(clk, '0', enable_entradas, A, A_carregado);
	REG_B: registrador4 port map(clk, '0', enable_entradas, B, B_Carregado);
	REG_ULA: registrador4 port map(clk, '0', enable_ULA, operacao, ULA_carregada);
	REG_SAIDA: registrador8 port map (clk, '0', enable_saida, saida_pro_reg, SAIDA);
	
    

end arch;