--Descripcion	: Contador BCD ascendente simple

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
entity cont_BCD is
	generic(cont_ancho: natural := 4);
	port(	clk, rst: in std_logic;
			bcd: out std_logic_vector(cont_ancho-1 downto 0));
end cont_BCD;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture rtl of cont_BCD is
------- Declaracion de señales internas --------------------
	signal cont_i: unsigned(cont_ancho-1 downto 0) := (others =>'0');
begin

------- Proceso que describe el contador -------------------
	cont_bcd_proc: process(clk, rst)
	begin
		if(rst = '0') then
			cont_i <= (others => '0');
		elsif(rising_edge(clk)) then
			if(cont_i = "1001") then
				cont_i <= (others => '0');
			else
				cont_i <= cont_i + 1;
			end if;
		end if;
	end process cont_bcd_proc;

------- Asignacion de la salida ----------------------------
	bcd <= std_logic_vector(cont_i);
	
end rtl;