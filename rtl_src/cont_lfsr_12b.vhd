------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all; 

------------------------------------------------------------------ 
-- Enitidad -- 
------------------------------------------------------------------ 
entity cont_lfsr_12b is 
	generic(	initial_value: std_logic_vector(11 downto 0):= "100000000000"; 
				lfsr_width : integer := 12); 
	port( clk : in std_logic; 
			rst : in std_logic; 
			q_lfsr_12b: out std_logic_vector(lfsr_width-1 downto 0) ); 
end cont_lfsr_12b; 

------------------------------------------------------------------- 
-- Architectura -- 
------------------------------------------------------------------- 
architecture beh of cont_lfsr_12b is 
	signal q_lfsr_12b_i: std_logic_vector(lfsr_width-1 downto 0); 
begin
	-- Shifter Process 
	lfsr_cnt_proc: process(rst, clk) 
	begin 
		if(rst= '1' ) then 
			q_lfsr_12b_i <= initial_value; 
		elsif (rising_edge(clk)) then 			 
		shifter_loop: for i in 11 downto 1 loop 
			q_lfsr_12b_i(i-1) <= q_lfsr_12b_i(i); 
		end loop shifter_loop;  					 
			q_lfsr_12b_i(11) <= q_lfsr_12b_i(6) xor q_lfsr_12b_i(4) xor q_lfsr_12b_i(1) xor q_lfsr_12b_i(0); 
		end if; 
	end process lfsr_cnt_proc; 
	q_lfsr_12b <= q_lfsr_12b_i; 
end architecture beh;
