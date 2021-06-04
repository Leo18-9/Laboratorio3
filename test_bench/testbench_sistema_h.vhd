
-- Descripcion: Simulacion funcional del Bloque de Contadores por medio de
-- 				 un Test Bench

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Declaracion de Entidad (Vacia)
------------------------------------------------------------
entity testbench_sistema_h is
end testbench_sistema_h;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture beh of testbench_sistema_h is
------- Declaracion de señales internas --------------------
	signal test_sel_cont: std_logic_vector(1 downto 0);
	signal test_clk_50: std_logic := '0';
	signal test_clk_div: std_logic;
	signal test_rst_asin: std_logic := '0';
	signal test_frec_uni, test_frec_deci, test_num_bcd: std_logic_vector(6 downto 0);
begin

------ Instanciacion del Bloque de Contadores -------------
	U: entity work.sistema_h port map(clk_50 => test_clk_50, sel_cont => test_sel_cont, rst_asin => test_rst_asin, frec_uni => test_frec_uni, frec_deci => test_frec_deci, num_bcd => test_num_bcd, clk_div => test_clk_div);
	
------ Generacion de Señales de simulacion -----------------	
	test_clk_50 <= not test_clk_50 after 10ns;
	test_sel_cont <= "00","01" after 5000ms, "10" after 11000ms, "11" after 16000ms; --"ZZ" after 400ns, "11" after 600ns;
	test_rst_asin <= '0','1' after 500ns, '0' after 8500ms, '1' after 8501ms;
	
end beh;