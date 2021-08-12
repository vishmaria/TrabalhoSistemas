LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bc IS
PORT (sem_op: IN STD_LOGIC;
    reset: IN STD_LOGIC;
    CLK: IN STD_LOGIC;
    ena_entradas, ena_operacoes, ena_saida: OUT STD_LOGIC);
END bc;

ARCHITECTURE fsm OF bc IS
  TYPE state_type IS (S0, S1, S2);
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

  P2: PROCESS(state, sem_op)
  BEGIN
      CASE state IS
        WHEN S0 =>
          ena_entradas <= '1';
       ena_operacoes <= '0';
       ena_saida<= '0';
       next_state <= S1;
          
        WHEN S1 =>
          ena_entradas <= '0';
       ena_operacoes <= '1';
       ena_saida<= '0';
       IF (sem_op = '1') THEN
        next_state <= state;
       ELSE 
        next_state <= S2;
       END IF;
        
        WHEN S2 =>
          ena_entradas <= '0';
       ena_operacoes <= '0';
       ena_saida<= '1';
       next_state <= S0;
 
      END CASE;
  END PROCESS;
END fsm;