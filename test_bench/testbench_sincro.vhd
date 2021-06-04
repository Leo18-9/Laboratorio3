-- Descripcion: Simulacion funcional del sincronizador por medio de
-- 				 un Test Bench

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Declaracion de Entidad (Vacia)
------------------------------------------------------------
entity testbench_sincro is
end;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture tb_behave of testbench_sincro is
------- Declaracion de señales internas --------------------
	signal test_D, test_RST, test_Q: std_logic := '0';
	signal test_CLK: std_logic := '0';
begin

------ Instanciacion del Sincronizador ---------------------
	U: entity work.Sincro port map(D => test_D, CLK => test_CLK, RST => test_RST, Q => test_Q);
	
------ Generacion de Señales de simulacion -----------------
	test_CLK <= not test_CLK after 10ns;
	test_D <= '0', '1' after 23ns, '0' after 42ns, '1' after 47ns, '0' after 77ns, '1' after 82ns, '0' after 95ns, '1' after 100ns, '0' after 117ns, '1' after 129ns, '0' after 137ns, '1' after 146ns, '0' after 179ns;
	test_RST <= '1', '0' after 53ns, '1' after 103ns; 
	
end tb_behave;