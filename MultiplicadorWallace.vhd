library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MultiplicadorWallace is port( 
	A,B: in  unsigned(3 downto 0);
	Resultado:  out unsigned(7 downto 0));
end MultiplicadorWallace;

architecture arch of MultiplicadorWallace is

	component somador_completo is port(
		A,B,Cin: in std_logic;
		S,Cout: out std_logic);
	end component;

	component meio_somador is port(
		A,B: in std_logic;
		S,Cout: out std_logic);
	end component;


	signal pp00,pp01,pp02,pp03,pp10,pp11,pp12,pp13,pp20,pp21,pp22,pp23,pp30,pp31,pp32,pp33 : std_logic;
	signal intermed00,intermed01,intermed02,intermed03,intermed04, intermed05, intermed06, intermed07, intermed08, intermed09, intermed10: std_logic;
	signal carry00,carry01,carry02,carry03,carry04,carry05,carry06,carry,carry07, carry08, carry09, carry10, carry11, carry12,carry13,carry14 : std_logic;

		begin

			-- produto parcial           exemplo: 0010 x 0011
			-- linha 1                   essa linha => 1 and (0,0,1,0) = 0010
			pp00 <= (A(0) and B(0));     		   -- 1 and 0 = 0
			pp01 <= (A(1) and B(0));				-- 1 and 1 = 1
			pp02 <= (A(2) and B(0));				-- 1 and 0 = 0
			pp03 <= (A(3) and B(0));				-- 1 and 0 = 0
			-- linha 2                   essa linha => 1 and (0,0,1,0) = 0010
			pp10 <= (A(0) and B(1));     		-- 1 and 0 = 0
			pp11 <= (A(1) and B(1));     		-- 1 and 1 = 1
			pp12 <= (A(2) and B(1));     		-- 1 and 0 = 0
			pp13 <= (A(3) and B(1));     		-- 1 and 0 = 0
			-- linha 3                   essa linha => 0 and (0,0,1,0) = 0000
			pp20 <= (A(0) and B(2));     		-- 0 and 0 = 0
			pp21 <= (A(1) and B(2));     		-- 0 and 1 = 0
			pp22 <= (A(2) and B(2));     		-- 0 and 0 = 0
			pp23 <= (A(3) and B(2));     		-- 0 and 0 = 0
			-- linha 4                   essa linha => 0 and (0,0,1,0) = 0000
			pp30 <= (A(0) and B(3));     		-- 0 and 0 = 0
			pp31 <= (A(1) and B(3));     		-- 0 and 1 = 0
			pp32 <= (A(2) and B(3));     		-- 0 and 0 = 0
			pp33 <= (A(3) and B(3));     		-- 0 and 0 = 0
			
			
			--arvore de wallace
			Resultado(0) <= pp00; -- Seguindo a árvore de Wallace, a primeira posição não tem com quem somar, portanto, vai direto para o resultado final
			MS0: meio_somador port map(pp01, pp10, Resultado(1), carry00);
			SC0: somador_completo port map(pp02, pp11, pp20, intermed00, carry01);
			SC1: somador_completo port map(pp03, pp12, pp21, intermed01, carry02);
			MS1: meio_somador port map(pp13, pp22, intermed02, carry03); -- aqui fecha o primeiro trio de linhas, pp23 vai ser chamado no próximo já que não realiza nenhuma operação nessa etapa
			
			MS2: meio_somador port map(intermed00,carry00,Resultado(2),carry04);
			SC2: somador_completo port map(intermed01,carry01,pp30, intermed03, carry05);
			SC3: somador_completo port map(intermed02, carry02,pp31, intermed04, carry06);
			SC4: somador_completo port map(pp23,carry03,pp32,intermed05, carry07);
				
			MS3: meio_somador port map(intermed03,carry04,Resultado(3),carry08);
			MS4: meio_somador port map(intermed04,carry05,intermed06,carry09);
			MS5: meio_somador port map(intermed05,carry06,intermed07,carry10);
			MS6: meio_somador port map(pp33,carry07,intermed08,carry11);
			
			MS7: meio_somador port map(intermed06,carry08,Resultado(4),carry12);
			MS8: meio_somador port map(intermed07,carry09,intermed09,carry13);
			MS9: meio_somador port map(intermed08,carry10,Resultado(6),carry14);
			
			MS10: meio_somador port map(intermed09,carry12,Resultado(5),open);
			MS11: meio_somador port map(carry11, carry14, Resultado(7), open);
			
		
end arch;
	
									

