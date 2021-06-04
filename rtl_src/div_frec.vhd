--Descripcion	: Divisor de frecuencia con entrada de seleccion para elegir entre
--					  las frecuencias 5Hz, 2Hz, 1Hz, 0.5Hz y 0.1Hz. El mismo se implemento
--					  utilizando un contador simple. El circuito tambien cuenta con
--					  decodificadores BCD a 7 segmentos con el fin de mostrar por los display
--					  el valor de frecuencia seleccionado.					  

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
entity div_frec is
------ Generic que permite seleccionar el largo ------------
------ del contador para obtener la frecuencia -------------
------ deseada ---------------------------------------------
	generic( ancho_cont: natural := 28);   
	port( sel: in std_logic_vector(2 downto 0);
			clk_50 : in std_logic;
			clk_sel: out std_logic;
			sal1_7seg, sal2_7seg: out std_logic_vector(6 downto 0)); 
end entity;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture beh of div_frec is
------- Declaracion de señales internas --------------------
	signal clk_sel_i : std_logic := '0';
	signal clk_sel_i2 : std_logic := '0';
--	signal cont_int : unsigned (ancho_cont-1 downto 0) := (others => '0');
--	signal sal_int : std_logic_vector (ancho_cont-1 downto 0);
	---- Declaracion de un tipo especial para el deco -------
	type bcd is array(0 to 1) of std_logic_vector(3 downto 0);
	signal ent_bcd: bcd;
begin

------ Instanciacion de los decodificadores que ------------
------ permiten mostrar por display las frecuencias --------
	U1: entity work.decoBCD7seg port map(ent => ent_bcd(0) ,leds => sal1_7seg); --Unidad de la frecuencia
	U2: entity work.decoBCD7seg port map(ent => ent_bcd(1) ,leds => sal2_7seg); --Decimas de la frecuencia
	
------ Proceso que cuenta con el contador simple ----------- 
------ y que entrega los clocks de 5Hz 1Hz 2Hz 0.5Hz 0.1Hz -
	clks_proc : process(clk_50,sel)
		variable rst: std_logic := '0';
		variable cont_int : unsigned (ancho_cont-1 downto 0) := (others => '0');
		variable sal_int : std_logic_vector (ancho_cont-1 downto 0);
	begin
	--- Contador simple con reset generado internamente -----	
		if(rising_edge(clk_50)) then
			if(rst = '1') then
				cont_int := (others => '0');
			else
				cont_int := cont_int + 1;
			end if;
		end if;
		sal_int := std_logic_vector(cont_int);
		
		
		if(rising_edge(clk_50)) then
			rst := '0';
	--- Seleccion de la frecuencia del clock de salida ------
		case sel is
		when "000" => 
			if(sal_int >= "0111011100110101100101000000") then
				clk_sel_i2 <= not(clk_sel_i);
				clk_sel_i <= clk_sel_i2;
				rst := '1';
			end if;
			ent_bcd(0) <= "0000";        	--Muestra un 0 en la unidad del 7segmento
			ent_bcd(1) <= "0001";			--Muestra un 1 en las decimas del 7segmento
		when "001" =>
			if(sal_int >= "0001011111010111100001000000") then
				clk_sel_i2 <= not(clk_sel_i);
				clk_sel_i <= clk_sel_i2;
				rst := '1';
			end if;
			ent_bcd(0) <= "0000";        	--Muestra un 0 en la unidad del 7segmento
			ent_bcd(1) <= "0101";			--Muestra un 5 en las decimas del 7segmento
		when "010" => 
			if(sal_int >= "0000101111101011110000100000") then
				clk_sel_i2 <= not(clk_sel_i);
				clk_sel_i <= clk_sel_i2;
				rst := '1';
			end if;
			ent_bcd(0) <= "0001";        	--Muestra un 1 en la unidad del 7segmento
			ent_bcd(1) <= "1111";			--No muestra nada en las decimas del 7segmento
		when "011" => 
			if(sal_int >= "0000010111110101111000010000") then
				clk_sel_i2 <= not(clk_sel_i);
				clk_sel_i <= clk_sel_i2;
				rst := '1';
			end if;
			ent_bcd(0) <= "0010";        	--Muestra un 2 en la unidad del 7segmento
			ent_bcd(1) <= "1111";			--No muestra nada en las decimas del 7segmento
		when others =>
			if(sal_int >= "0000001001100010010110100000") then
				clk_sel_i2 <= not(clk_sel_i);
				clk_sel_i <= clk_sel_i2;
				rst := '1';
			end if;
			ent_bcd(0) <= "0101";        	--Muestra un 5 en la unidad del 7segmento
			ent_bcd(1) <= "1111";			--No muestra nada en las decimas del 7segmento
		end case;
		end if;
	end process clks_proc;
	
------ Asignacion del valor de salida -------------------
	clk_sel <= clk_sel_i;
end beh;