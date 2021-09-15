LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY bo IS PORT 
(		A, B, operacao: in std_logic_vector(7 downto 0);
		enable_a, enable_b, enable_ULA, enable_saida, clk: in std_logic;
		Z, HALT, READY: out std_logic;
		SAIDA: out std_logic_vector(15 downto 0));
end bo;

architecture arch of bo is
	component ULA is port (
			CLK: in std_logic;
			A, B : IN std_LOGIC_VECTOR (7 DOWNTO 0);
			ULAop: IN STD_LOGIC_VECTOR(7 downto 0);
			S: OUT std_LOGIC_VECTOR(15 DOWNTO 0);
			Z, HALT, READY: OUT STD_LOGIC);
	end component;
	
	component registrador16 is port (
			CLK: in std_logic;
			RST: in std_logic;
			EN: in std_logic;
			D: in std_logic_vector(15 downto 0);
			Q: out std_logic_vector(15 downto 0));
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
	
	
	signal A_carregado, B_carregado, ULA_carregada: std_logic_vector(7 downto 0);
	signal saida_pro_reg: std_logic_vector(15 downto 0);
	
begin
	
	ULA_1: ula port map(clk, A_carregado, B_carregado, ULA_carregada, saida_pro_reg, Z, HALT, READY);
	REG_A: registrador8 port map(clk, '0', enable_a, A, A_carregado);
	REG_B: registrador8 port map(clk, '0', enable_b, B, B_carregado);
	REG_ULA: registrador8 port map(clk, '0', enable_ULA, operacao, ULA_carregada);
	REG_SAIDA: registrador16 port map (clk, '0', enable_saida, saida_pro_reg, SAIDA);
	
    

end arch;