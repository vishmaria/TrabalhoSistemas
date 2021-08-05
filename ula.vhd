LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY ula IS 
GENERIC (M : INTEGER := 4);
PORT ( A, B : IN SIGNED (M-1 DOWNTO 0);
        ULAop: IN STD_LOGIC_VECTOR(3 downto 0);
        S: OUT SIGNED (M-1 DOWNTO 0);
        N, Z, OV: OUT STD_LOGIC
        );
END ula;

ARCHITECTURE behaviour OF ula IS
signal Saux, A_auxiliar, B_auxiliar: SIGNED(M downto 0); 
signal Stest: SIGNED(M-1 downto 0); 
BEGIN 

A_auxiliar <= SIGNED(A(M-1) & A);
B_auxiliar <= SIGNED(B(M-1) & B);


WITH ULAop SELECT
    Saux <= --Logic
		(not A_auxiliar) when "0000",
		(not B_auxiliar) when "0001",
		(A_auxiliar and B_auxiliar) when "0010",
		(A_auxiliar or B_auxiliar) when "0011",
		(A_auxiliar nand B_auxiliar) when "0100",	
		(A_auxiliar nor B_auxiliar) when "0101",
		(A_auxiliar xor B_auxiliar) when "0110",
		(A_auxiliar xnor B_auxiliar) when others;

S <= Saux(M-1 downto 0);
Stest <= Saux(M-1 downto 0);



N <= '1' when Stest < 0 else '0';
Z <= '1' when Stest = 0 else '0';


OV <= '1' when
(((A_auxiliar>0 and B_auxiliar>0 and Stest<0) or (A_auxiliar < 0 and B_auxiliar < 0 and Stest > 0))) or
((A_auxiliar > 0 and Stest < 0) or (A_auxiliar < 0 and Stest > 0)) or
(((A_auxiliar>0 and B_auxiliar<0 and Stest<0) or (A_auxiliar < 0 and B_auxiliar > 0 and Stest > 0))) or
(((B_auxiliar > 0 and Stest < 0) or (B_auxiliar < 0 and Stest > 0)))
else '0';



END behaviour;