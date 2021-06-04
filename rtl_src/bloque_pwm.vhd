--Descripcion	: Bloque de 8 generadores de señales PWM con ciclos
--					  de trabajo fijos.

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Declaracion de Entidad
------------------------------------------------------------
entity bloque_pwm is
------ Generic que establece los valores fijos -------------
------ de los ciclos de trabajo (en porcentaje)-------------
	generic(	bloque_ancho: natural := 8;
				duty_cicle8: std_logic_vector(7 downto 0) := "11111110";--99%
				duty_cicle7: std_logic_vector(7 downto 0) := "11100101";--90%
				duty_cicle6: std_logic_vector(7 downto 0) := "11001100";--80%
				duty_cicle5: std_logic_vector(7 downto 0) := "10110010";--70%
				duty_cicle4: std_logic_vector(7 downto 0) := "01111111";--50%
				duty_cicle3: std_logic_vector(7 downto 0) := "01001100";--30%
				duty_cicle2: std_logic_vector(7 downto 0) := "00110011";--20%
				duty_cicle1: std_logic_vector(7 downto 0) := "00010110");--10%
	port(	clk_50, rst_b, load_b: in std_logic;
			bloque_pwm_out: out std_logic_vector(bloque_ancho-1 downto 0));
end bloque_pwm;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture rtl of bloque_pwm is
---- Declaracion de un tipo especial para la asignacion ----
---- de los ciclos de trabajos -----------------------------
	type duty is array(0 to 7) of std_logic_vector(7 downto 0);
	signal duty_opc: duty := (	0 => duty_cicle1,
										1 => duty_cicle2,
										2 => duty_cicle3,
										3 => duty_cicle4,
										4 => duty_cicle5,
										5 => duty_cicle6,
										6 => duty_cicle7,
										7 => duty_cicle8);
begin

---- Instanciacion de los 8 generadores de PWM con sus -----
---- respectivos ciclos de trabajo -------------------------
	pwm_gen: for i in bloque_pwm_out'range generate
		U: entity work.pwm_8b port map(clk => clk_50 ,rst => rst_b, load => load_b, duty_cicle => duty_opc(i), pwm_out => bloque_pwm_out(i));
	end generate;	

end rtl;
