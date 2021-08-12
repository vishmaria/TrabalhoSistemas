library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;  -- para tratamento de arquivos e texto

entity WallaceTree_tb is
end WallaceTree_tb;

architecture tb of WallaceTree_tb is
    constant clk_period: time := 100 ns;
    signal clk, rst : std_logic;
    signal A, B: std_logic_vector(3 downto 0);
    signal S: std_logic_vector(7 downto 0);
begin
    -- conectando os sinais do test bench aos sinais do contador
    UUT : entity work.MultiplicadorWallace port map 
                (clock => clk, R => rst,
                A => A, B => B, prod => S);
					 
    rst <= '0', '1' after clk_period/20;
     
	 -- processo gerador de clock
	clk_gen : process
        begin
            clk <= '1';
            wait for clk_period/25; -- 50% do periodo pra cada nivel
            clk <= '0';
            wait for clk_period/25;
        end process;

    -- processo de leitura das entradas e escrita saidas
    file_io: process
      variable read_col_from_input_buf : line; -- buffers de entrada e saida
		file input_buf : text;  -- text is keyword
      variable write_col_to_output_buf : line; 
		file output_buf : text;  -- text is keyword

        variable val_A, val_B: std_logic_vector(3 downto 0); -- entradas A e B do arquivo
        variable val_SPACE : character;  -- para espacos
    
        begin
            file_open(input_buf, "entradas.txt",  read_mode); 
            file_open(output_buf, "saidas_tb.txt",  write_mode); 

			wait until rst = '0'; -- espera reset desligar
				
            while not endfile(input_buf) loop
                readline(input_buf, read_col_from_input_buf);
                read(read_col_from_input_buf, val_A);
                read(read_col_from_input_buf, val_SPACE);           -- read in the space character
                read(read_col_from_input_buf, val_B);

                -- Pass the read values to signals
                A <= val_A;
                B <= val_B;

                wait for clk_period;
                write(write_col_to_output_buf, S);
                writeline(output_buf, write_col_to_output_buf);    -- 

            end loop;

			write(write_col_to_output_buf, string'("SIMULACAO CONCLUIDA"));
            writeline(output_buf, write_col_to_output_buf);    -- 

            file_close(input_buf);             
            file_close(output_buf);

            wait;
        end process;
end tb;