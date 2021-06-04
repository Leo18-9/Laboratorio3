-- Descripcion : 	Simulacion funcional del circuito antirebote por medio de
-- 				 	un Test Bench

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Declaracion de Entidad (Vacia)
------------------------------------------------------------
entity testbench_antirebote is
end;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture tb_behave of testbench_antirebote is
------- Declaracion de señales internas --------------------
	signal test_ent, test_rst, test_sal: std_logic := '0';
	signal test_clk: std_logic := '0';
begin

------ Instanciacion del Circuito Antirebote ---------------
	U: entity work.Antirebote port map(ent => test_ent, clk => test_clk, rst => test_rst, sal => test_sal);
	
------ Generacion de Señales de simulacion -----------------
	test_clk <= not test_CLK after 10ns;
	test_ent <= '0', '1' after 50ns, '0' after 51ns,'1' after 52ns, '0' after 53ns, '1' after 54ns, '0' after 55ns,'1' after 56ns,'0' after 57ns,'0' after 58ns, '1' after 59ns, '0' after 100ns, '1' after 101ns, '0' after 102ns, '1' after 103ns, '0' after 104ns,'1' after 200ns, '0' after 201ns,'1' after 202ns, '0' after 203ns, '1' after 204ns, '0' after 205ns,'1' after 206ns,'0' after 207ns,'0' after 208ns, '1' after 209ns, '0' after 250ns, '1' after 251ns, '0' after 252ns, '1' after 253ns, '0' after 254ns ;
	test_rst <= '1', '0' after 240ns, '1' after 260ns; 
	
------ Mensajes de error dentro de la Simulacion -----------
	test_signals: process
	begin
		wait for 35ns;
			assert test_sal = '0'
				Report "salida no es correcta"
					severity ERROR;
		wait for 95ns;
			assert test_sal = '1'
				Report "salida no es correcta"
					severity ERROR;
	end process test_signals;
end tb_behave;