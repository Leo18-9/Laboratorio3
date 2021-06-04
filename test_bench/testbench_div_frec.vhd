-- Descripcion: Simulacion funcional del Divisor de Frecuencia por medio de
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
entity testbench_div_frec is
end entity;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture beh of testbench_div_frec is
------- Declaracion de señales internas --------------------
	signal test_sel: std_logic_vector(2 downto 0);
	signal test_clk_50: std_logic := '0';
	signal test_clk_sel: std_logic := '0';
	signal test_sal1_7seg, test_sal2_7seg: std_logic_vector(6 downto 0) := "0000000";
begin

------ Instanciacion del Divisor de Frecuencia -------------
	U: entity work.div_frec port map(clk_50 => test_clk_50, sel => test_sel, clk_sel => test_clk_sel, sal1_7seg => test_sal1_7seg, sal2_7seg => test_sal2_7seg);
	
------ Generacion de Señales de simulacion -----------------
	test_clk_50 <= not test_clk_50 after 10ns;
	test_sel <= "010","011" after 4000ms, "100" after 7000ms; --"ZZ" after 400ns, "11" after 600ns;
	
end beh;