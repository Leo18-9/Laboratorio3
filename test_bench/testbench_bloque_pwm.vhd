-- Descripcion: Simulacion funcional del Bloque de PWMs por medio de
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
entity testbench_bloque_pwm is
end entity;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture tb_behave of testbench_bloque_pwm is
------- Declaracion de señales internas --------------------
	signal test_rst_b, test_load_b: std_logic := '0';
	signal test_clk_50: std_logic := '0';
	signal test_bloque_pwm_out: std_logic_vector(7 downto 0);
begin

------ Instanciacion del Bloque de PWMs --------------------
	U: entity work.bloque_pwm port map(clk_50 => test_clk_50, rst_b => test_rst_b, load_b => test_load_b, bloque_pwm_out => test_bloque_pwm_out);

------ Generacion de Señales de simulacion -----------------	
	test_clk_50 <= not test_clk_50 after 10ns;
	test_load_b <= '0', '1' after 100ns, '0' after 300ns;
	test_rst_b <= '0', '1' after 1000ns, '0' after 1040ns, '1' after 5600ns, '0' after 5640ns;
	--El reset pone todo en alto para empezar el ciclo de trabajo
	
end tb_behave;