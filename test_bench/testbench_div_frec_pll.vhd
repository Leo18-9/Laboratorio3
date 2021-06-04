-- Descripcion: Simulacion funcional del Divisor de Frecuencia con PLL por medio de
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
entity testbench_div_frec_pll is
end entity;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture beh of testbench_div_frec_pll is
------- Declaracion de señales internas --------------------
	signal test_sel: std_logic_vector(2 downto 0);
	signal test_inclk0_sig, test_areset_sig: std_logic := '0';
	signal test_clk_sel, test_led_lock: std_logic := '0';
	signal test_sal1_7seg, test_sal2_7seg: std_logic_vector(6 downto 0) := "0000000";
begin

------ Instanciacion del Divisor de Frecuencia -------------
	U: entity work.div_frec_pll port map(inclk0_sig => test_inclk0_sig, areset_sig => test_areset_sig, sel => test_sel, clk_sel => test_clk_sel, sal1_7seg => test_sal1_7seg, sal2_7seg => test_sal2_7seg, led_lock => test_led_lock);
	
------ Generacion de Señales de simulacion -----------------
	test_inclk0_sig <= not test_inclk0_sig after 10ns;
	test_sel <= "100","001" after 10000ms; --"ZZ" after 400ns, "11" after 600ns;
	test_areset_sig <= '0', '1' after 150ms, '0' after 151ms;
	
end beh;