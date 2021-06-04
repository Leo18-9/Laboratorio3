-- Descripcion: Contador tipo LFSR con entrada de seleccion para elegir entre
-- 				 4, 8, 16, 32 bits. Este tipo de contador genera secuencias
--					 pseudoaleatorias.
--					 La implentacion se realiza a traves de un registro de desplazamiento
--					 realimentado a la entrada con una compuerta XOR. Las salidas no usadas
--					 (caso 4, 8 y 16 bits) se colocan en alta impedancia.

------------------------------------------------------------
--Declaracion de Librerias
------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Declaracion de Entidad
------------------------------------------------------------
entity sel_cont_lfsr is
------ Generic que parametriza el largo de los -------------
------ contadores LFSR -------------------------------------
	generic(	ancho_lfsr_a : integer := 4;
				ancho_lfsr_b : integer := 8;
				ancho_lfsr_c : integer := 16;
				ancho_lfsr_d : integer := 32);
	port(	sel: in std_logic_vector(1 downto 0);
			rst: in std_logic;
			clk: in std_logic;
			--sal_lfsr: out std_logic_vector(ancho_lfsr_d-1 downto 0);
			bcd1, bcd2, bcd3, bcd4,bcd5, bcd6, bcd7, bcd8 : out std_logic_vector(6 downto 0));
end sel_cont_lfsr;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture rtl of sel_cont_lfsr is
------- Declaracion de señales internas --------------------
	--signal initial_value: std_logic_vector(31 downto 0):= (0 => '1', others => '0');
	signal sal_lfsr_i : std_logic_vector(31 downto 0) := (0 => '1', others => '0');  
	signal serial_in : std_logic; 
	signal realim : std_logic;
	signal clk_div: std_logic;
begin

------ Instanciacion de los decodificadores ----------------
		U1: entity work.deco7seg port map(ent => sal_lfsr_i(3 downto 0), leds => bcd1);
		U2: entity work.deco7seg port map(ent => sal_lfsr_i(7 downto 4), leds => bcd2);
		U3: entity work.deco7seg port map(ent => sal_lfsr_i(11 downto 8), leds => bcd3);
		U4: entity work.deco7seg port map(ent => sal_lfsr_i(15 downto 12), leds => bcd4);
		U5: entity work.deco7seg port map(ent => sal_lfsr_i(19 downto 16), leds => bcd5);
		U6: entity work.deco7seg port map(ent => sal_lfsr_i(23 downto 20), leds => bcd6);
		U7: entity work.deco7seg port map(ent => sal_lfsr_i(27 downto 24), leds => bcd7);
		U8: entity work.deco7seg port map(ent => sal_lfsr_i(31 downto 28), leds => bcd8);
		
------ Instanciacion del Divisor de Frecuencia ----------------
		U9: entity work.div_frec port map(sel => "001", clk_50 => clk, clk_sel => clk_div, sal1_7seg => open, sal2_7seg => open);

------ Entrada Serie al Contador LFSR ----------------------
	serial_in <= realim;
	
------ Proceso de Realimentacion XOR de la -----------------
------ ecuacion de realimentacion --------------------------
	realim_proc: process (sal_lfsr_i, sel)
		begin
		case sel is
			when "00" =>
				realim <= sal_lfsr_i(1) xor sal_lfsr_i(0);				
			when "01" =>
				realim <= sal_lfsr_i(4) xor sal_lfsr_i(3) xor sal_lfsr_i(2) xor sal_lfsr_i(0);
			when "10" =>
				realim <= sal_lfsr_i(5) xor sal_lfsr_i(4) xor sal_lfsr_i(3) xor sal_lfsr_i(0);
			when others =>
				realim <= sal_lfsr_i(22) xor sal_lfsr_i(2) xor sal_lfsr_i(1) xor sal_lfsr_i(0);
		end case;
	end process realim_proc;
	
------ Proceso de seleccion de largo del ------------------
------ contador LFSR --------------------------------------
	sel_proc: Process (rst, clk_div, sel)
		variable ancho_lfsr: integer;
	begin
	--- El cambio entre un contador y otro se debe ---------
	--- realizar un reset para inicializar todas las -------
	--- salidas (Alta impedancia) --------------------------
		if(rst= '0') then 
			sal_lfsr_i <= (0 => '1', others => '0');
		elsif(rising_edge(clk_div)) then
		case sel is 
			when "00" =>
				sal_lfsr_i(31 downto ancho_lfsr_a) <= (others => 'Z');
				sal_lfsr_i(ancho_lfsr_a-1 downto 0) <= serial_in & sal_lfsr_i(ancho_lfsr_a-1 downto 1); 
			when "01" =>
				sal_lfsr_i(31 downto ancho_lfsr_b) <= (others => 'Z');
				sal_lfsr_i(ancho_lfsr_b-1 downto 0) <= serial_in & sal_lfsr_i(ancho_lfsr_b-1 downto 1); 
			when "10" =>
				sal_lfsr_i(31 downto ancho_lfsr_c) <= (others => 'Z');
				sal_lfsr_i(ancho_lfsr_c-1 downto 0) <= serial_in & sal_lfsr_i(ancho_lfsr_c-1 downto 1); 
			when others =>
				sal_lfsr_i(ancho_lfsr_d-1 downto 0) <= serial_in & sal_lfsr_i(ancho_lfsr_d-1 downto 1); 
		end case;
		end if;
	end process sel_proc;
	
---- Asignacion del valor de salida ---------------------
	--sal_lfsr <= sal_lfsr_i;
end rtl;
