--Descripcion	: Modulo generador de señal PWM con entrada de establecimiento del ciclo
--					  de trabajo. El nuevo ciclo de trabajo ingresado se refleja en la salida
--					  a partir de la activacion de la señal LOAD. El circuito esta controlado
--					  por flanco positivo del clock y un reset asincronico.
--					  El modulo tambien cuenta con decodificador de HEX a 7 segmentos que
--					  muestra por display el valor de los 4 bits menos significativos de la 
--					  entrada del ciclo de trabajo.

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
entity pwm_8b is
	generic(cont_ancho: natural := 8);
	port(	clk, rst, load: in std_logic;
			duty_cicle: in std_logic_vector(cont_ancho-1 downto 0);
			pwm_out: out std_logic;
			bcd_sal: out std_logic_vector(6 downto 0));
end pwm_8b;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture rtl of pwm_8b is
------- Declaracion de señales internas --------------------
	signal cont_i: unsigned(cont_ancho-1 downto 0) := (others =>'0');
	signal duty: std_logic_vector(cont_ancho-1 downto 0) := (others => '0');
begin

------ Instanciacion del decodificador ---------------------
	U1: entity work.deco7seg port map(ent => duty_cicle(3 downto 0) ,leds => bcd_sal);

------ Proceso que genera el Tiempo en alto y --------------
------ Tiempo en bajo de la señal de salida (PWM) ----------
	cont_proc: process(clk, rst)
	begin
		if(rst = '1') then
			cont_i <= (others => '0');
		elsif(rising_edge(clk)) then
			cont_i <= cont_i + 1;
			if(std_logic_vector(cont_i) >= duty) then
				pwm_out <= '0';
			else
				pwm_out <= '1';
			end if;
		end if;
	end process cont_proc;

------ Proceso que verifica el cambio del -----------------
------ ciclo de trabajo con la señal LOAD -----------------
	duty_proc: process(clk, duty_cicle, load)
	begin
		if(rising_edge(clk)) then
			if(load = '1') then
				duty <= duty_cicle;
			end if;
		end if;
	end process duty_proc;

end rtl;