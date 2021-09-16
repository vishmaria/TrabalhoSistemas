-- Armazena as opções das sequências, dependendo no valor que for escolhido, será escolhida uma sequência aleatória, que deve ser preenchida pelo aluno

-----------------------------------
library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity ROM is
  port ( address : in std_logic_vector(5 downto 0);
         data : out std_logic_vector(7 downto 0) );
end entity;

architecture Rom_Arch of ROM is
  type memory is array (00 to 34) of std_logic_vector(7 downto 0);
    constant my_Rom : memory := (
        00 => "00000000", --No operation
        01 => "00000000", --valor A
        02 => "00000000", --valor B
        03 => "00000001", --soma
        04 => "00100000", --valor A
        05 => "00001001", --valor B
        06 => "00000010", --subtração
        07 => "00001010", -- valor A
        08 => "00000101", -- valor B
        09 => "00000011", -- A++
        10 => "00000111", --valor A
        11 => "00000000", --valor B
        12 => "00000100", -- A--
        13 => "10000000", -- valor A
        14 => "00000000", --valor B
        15 => "00000101", --not(A)
        16 => "00111100", --valor A
        17 => "00000000", --valor B
        18 => "00000110", --(A and B)
        19 => "00010000", --valor A
        20 => "01000010", --valor B
        21 => "00000111", --(A or B)
        22 => "11000011", --valor A
        23 => "01001100", --valor B
        24 => "00001000", --(A xor B)
        25 => "11111100", --valor A
        27 => "01100111", --Valor B
        28 => "00001001", --multiplicacao       
        29 => "00000101", --valor A
        30 => "00000010", --valor B
        31 => "00001010", --divisao
        32 => "00001010", --valor A
        33 => "00000010", --valor B
        34 => "00001111");-- halt
begin
   process (address)
   begin
     case address is
        when "000000" => data <= my_rom(00);
        when "000001" => data <= my_rom(01);
        when "000010" => data <= my_rom(02);
        when "000011" => data <= my_rom(03);
        when "000100" => data <= my_rom(04);
        when "000101" => data <= my_rom(05);
        when "000110" => data <= my_rom(06);
        when "000111" => data <= my_rom(07);
        when "001000" => data <= my_rom(08);
        when "001001" => data <= my_rom(09);
		    when "001010" => data <= my_rom(10);
		    when "001011" => data <= my_rom(11);
	      when "001100" => data <= my_rom(12);
		    when "001101" => data <= my_rom(13);
		    when "001110" => data <= my_rom(14);
		    when "001111" => data <= my_rom(15);
        when "010000" => data <= my_rom(16);
        when "010001" => data <= my_rom(17);
        when "010010" => data <= my_rom(18);
        when "010011" => data <= my_rom(19);
        when "010100" => data <= my_rom(20);
        when "010101" => data <= my_rom(21);
        when "010110" => data <= my_rom(22);
        when "010111" => data <= my_rom(23);
        when "011000" => data <= my_rom(24);
        when "011001" => data <= my_rom(25);
        when "011010" => data <= my_rom(26);
        when "011011" => data <= my_rom(27);
        when "011100" => data <= my_rom(28);
        when "011101" => data <= my_rom(29);
        when "011110" => data <= my_rom(30);
        when "011111" => data <= my_rom(31);            
        when "100000" => data <= my_rom(32);        
        when "100001" => data <= my_rom(33);                
        when others => data <= my_rom(34);
       end case;
  end process;
end architecture Rom_Arch;
