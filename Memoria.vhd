-- Armazena as opções das sequências, dependendo no valor que for escolhido, será escolhida uma sequência aleatória, que deve ser preenchida pelo aluno

-----------------------------------
library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity ROM is
  port ( address : in std_logic_vector(4 downto 0);
         data : out std_logic_vector(7 downto 0) );
end entity;

architecture Rom_Arch of ROM is
  type memory is array (00 to 34) of std_logic_vector(31 downto 0);
    constant my_Rom : memory := (
        00 => "00000000", --No operation
        01 => "00000000", --valor A
        02 => "00000000", --valor B
        03 => "00000001", --soma
        04 => "00100000", --valor A
        05 => "00001001", --valor B
        06 => "00000010", --subtração
        07 => "00001010", -- valor A
        08 => "0000001", -- valor B
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
        when "00000" => data <= my_rom(00);
        when "00001" => data <= my_rom(01);
        when "00010" => data <= my_rom(02);
        when "00011" => data <= my_rom(03);
        when "00100" => data <= my_rom(04);
        when "00101" => data <= my_rom(05);
        when "00110" => data <= my_rom(06);
        when "00111" => data <= my_rom(07);
        when "01000" => data <= my_rom(08);
        when "01001" => data <= my_rom(09);
		when "01010" => data <= my_rom(10);
		when "01011" => data <= my_rom(11);
	    when "01100" => data <= my_rom(12);
		when "01101" => data <= my_rom(13);
		when "01110" => data <= my_rom(14);
		when "01111" => data <= my_rom(15);
        when "10000" => data <= my_rom(16);
        when "10001" => data <= my_rom(17);
        when "10010" => data <= my_rom(18);
        when "10011" => data <= my_rom(19);
        when "10100" => data <= my_rom(20);
        when "10101" => data <= my_rom(21);
        when "10110" => data <= my_rom(22);
        when "10111" => data <= my_rom(23);
        when "11000" => data <= my_rom(24);
        when "11001" => data <= my_rom(25);
        when "11010" => data <= my_rom(26);
        when "11011" => data <= my_rom(27);
        when "11100" => data <= my_rom(28);
        when "11101" => data <= my_rom(29);
        when "11110" => data <= my_rom(30);
        when others => data <= my_rom(31);
       end case;
  end process;
end architecture Rom_Arch;
