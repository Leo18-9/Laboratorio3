--Descripcion	: Contador ascendente simple

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
entity cont_bin_up is
	generic(cont_ancho: natural := 4);
	port(	clk, rst: in std_logic;
			bin_up: out std_logic_vector(cont_ancho-1 downto 0));
end cont_bin_up;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture rtl of cont_bin_up is
------- Declaracion de señales internas --------------------
	signal cont_i: unsigned(cont_ancho-1 downto 0) := (others =>'0');
begin

------- Proceso que describe el contador -------------------
	cont_bcd_proc: process(clk, rst)
	begin
		if(rst = '0') then
			cont_i <= (others => '0');
		elsif(rising_edge(clk)) then
			cont_i <= cont_i + 1;
		end if;
	end process cont_bcd_proc;

------- Asignacion de la salida ----------------------------
	bin_up <= std_logic_vector(cont_i);
	
end rtl;