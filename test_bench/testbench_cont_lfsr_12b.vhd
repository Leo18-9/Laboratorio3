-- Descripcion: Simulacion funcional del Contador LFSR 12 bits por medio de
-- 				 un Test Bench

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Declaracion de Entidad
------------------------------------------------------------
entity testbench_cont_lfsr_12b is
end testbench_cont_lfsr_12b;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture tb_behave of testbench_cont_lfsr_12b is
------- Declaracion de señales internas --------------------
	signal test_rst: std_logic := '0';
	signal test_clk: std_logic := '0';
	signal test_q_lfsr_12b: std_logic_vector(11 downto 0);
begin

------ Instanciacion del Contador LFSR ---------------------
	U: entity work.cont_lfsr_12b port map(clk => test_clk, rst => test_rst, q_lfsr_12b => test_q_lfsr_12b);
	
------ Generacion de Señales de simulacion -----------------
	test_clk <= not test_CLK after 10ns;
	test_rst <= '0';

end tb_behave;