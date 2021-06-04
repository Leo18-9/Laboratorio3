-- Descripcion : 	Circuito antirebote conformado por compuertas NAND, 
-- 					donde sus salidas se encuentran interconectadas entre si permitiendo 
--						obtener una señal estable para llaves mecanicas.
--						El circuito es controlado por flanco positivo del reloj y reset activo
--						en bajo.

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Declaracion de Entidad 
------------------------------------------------------------
entity Antirebote is
	port(ent, clk, rst: in std_logic;
			sal: out std_logic);
end entity;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture beh of Antirebote is
------- Declaracion de señales internas --------------------
	signal sal1_i, sal2_i : std_logic;
	signal vcc1 : std_logic := '1';
begin
	
------- Compuertas OR con entradas negadas (NAND) ----------
	sal1_i <= not(ent) or not(sal2_i);
	sal2_i <= ent or not(sal1_i);
	
------- Proceso sincronizador --------------------
	anti_r: process(clk, rst)
	begin
		if(rst = '0') then
			sal <= '0';
		elsif(rising_edge(clk)) then
			sal <= sal2_i;
		end if;		
	end process anti_r;
end beh;