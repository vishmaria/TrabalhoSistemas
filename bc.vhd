LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (halt: IN STD_LOGIC;
    reset: IN STD_LOGIC;
    CLK: IN STD_LOGIC;
    en_pc, en_A, en_b, en_ulaop, ready; en_saida: OUT STD_LOGIC);
END bc;

ARCHITECTURE fsm OF bc IS
  TYPE state_type IS (S0, S1, S2, S3, S4, S5);
  SIGNAL state, next_state: state_type;
BEGIN
  -- Logica de proximo estado
  P1: PROCESS (clk, RESET)
  BEGIN
    IF(reset = '1') THEN
      state <= S0 ;
    ELSIF (CLK'EVENT AND CLK = '1') THEN
    state <= next_state;
   END IF;
  END PROCESS;

  P2: PROCESS(state, halt)
  BEGIN
      CASE state IS
        WHEN S0 =>
		   ena_operacoes <= '1';
         en_A <= '0';
			en_B <= '0';
			ena_saida<= '0';
			next_state <= S1;
			IF (halt = '1') THEN
				next_state <= S5;
			ELSE 
            next_state <= S2;
			END IF;
          
        WHEN S1 =>
         ena_operacoes <= '0';
         en_A <= '1';
			en_B <= '0';
			ena_saida<= '0';
			next_state <= S2;
              
        WHEN S2 =>
         ena_operacoes <= '0';
         en_A <= '0';
			en_B <= '1';
			ena_saida<= '0';
			next_state <= S3;
			
		  WHEN S3 =>
         ena_operacoes <= '0';
         en_A <= '0';
			en_B <= '0';
			ena_saida<= '0';
			IF (ready = '0') THEN
				next_state <= state;
			ELSE 
            next_state <= S4;
			END IF;
			
		  WHEN S4 =>
         ena_operacoes <= '0';
         en_A <= '0';
			en_B <= '0';
			ena_saida<= '1';
			next_state <= S0;
			
		  WHEN S5 =>
		   ena_operacoes <= '0';
         en_A <= '0';
			en_B <= '0';
			ena_saida<= '0';
			next_state <= S5;
 
      END CASE;
  END PROCESS;
END fsm;
