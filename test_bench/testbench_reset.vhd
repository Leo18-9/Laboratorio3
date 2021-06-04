-- Descripcion: Simulacion funcional del circuito de reset por medio de
-- 				 un Test Bench

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Declaracion de Entidad (Vacia)
------------------------------------------------------------
entity testbench_reset is
end;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture tb_behave of testbench_reset is
------- Declaracion de señales internas --------------------
	signal test_rst, test_rst_a_s: std_logic := '0';
	signal test_clk: std_logic := '0';
begin

------ Instanciacion del Circuito de Reset -----------------
	U: entity work.reset port map(clk => test_clk, rst => test_rst, rst_a_s => test_rst_a_s);
	
------ Generacion de Señales de simulacion -----------------
	test_clk <= not test_clk after 10ns;
	test_rst <= '1', '0' after 53ns, '1' after 68ns, '0' after 96ns, '1' after 108ns, '0' after 176ns, '1' after 188ns;
	
------ Mensajes de error dentro de la Simulacion -----------
	test_signals: process
	begin
		wait for 35ns;
			assert test_rst_a_s = '1'
				Report "salida no es correcta"
					severity ERROR;
		wait for 100ns;
			assert test_rst_a_s = '0'
				Report "salida no es correcta"
					severity ERROR;
	end process test_signals;
end tb_behave;