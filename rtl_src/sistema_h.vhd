--Descripcion	: Sistema conformado por 4 diferentes contadores (contador LFSR de 4 bits,
--					  contador BCD, contador ascendente binario, contador descendente binario).
--					  Utilizando un circuito de 4 multiplexer y un decodificador de BCD a 7
--					  segmentos, se muestra por display el valor del contador seleccionado.
--					  Las señales asincronicas recibidas se sincronizan con el clock del sistema.
--					  Cuenta con un circuito de reset activado asincronicamente y desactivado
--					  sincronicamente. 

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
entity sistema_h is
	port(	clk_50, rst_asin: in std_logic;
			sel_cont: in std_logic_vector(1 downto 0);
			clk_div: out std_logic;
			num_bcd, frec_uni, frec_deci: out std_logic_vector(6 downto 0));
end sistema_h;

------------------------------------------------------------
-- Arquitectura
------------------------------------------------------------
architecture rtl of sistema_h is
------- Declaracion de señales internas --------------------
	signal rst, clk_1: std_logic;
	signal sel_cont_sincro: std_logic_vector(1 downto 0);
	signal cont_lfsr: std_logic_vector(31 downto 0) := (others => '0');
	signal cont_bcd, cont_down, cont_up, cont_lfsr_i: std_logic_vector(3 downto 0) := (others => '0');
begin
	
------ Señales auxiliares para la correcta instanciacion ---
	cont_lfsr_i <= cont_lfsr(3 downto 0);
	clk_div <= clk_1;
------ Instanciacion de todos los componentes --------------
------ necesarios para el sistema --------------------------
	U1: entity work.reset port map( clk => clk_50, rst => rst_asin, rst_a_s => rst);
	
	U2: entity work.Sincro port map(D => sel_cont(0), CLK => clk_50, RST => rst, Q => sel_cont_sincro(0));
	U3: entity work.Sincro port map(D => sel_cont(1), CLK => clk_50, RST => rst, Q => sel_cont_sincro(1));
	
	U4: entity work.div_frec port map(clk_50 => clk_50, sel => "010", clk_sel => clk_1, sal1_7seg => frec_uni, sal2_7seg => frec_deci);
	U5: entity work.sel_cont_lfsr port map(clk => clk_1, rst => rst, sal_lfsr => cont_lfsr, sel => "00");
	U6: entity work.cont_BCD port map(clk => clk_1, rst => rst, bcd => cont_bcd);
	U7: entity work.cont_bin_down port map(clk => clk_1, rst => rst, bin_down => cont_down);
	U8: entity work.cont_bin_up port map(clk => clk_1, rst => rst, bin_up => cont_up);
	U9: entity work.recver port map(selmux => sel_cont_sincro, cbcd1 => cont_lfsr_i, cbcd2 => cont_bcd, cbcd3 => cont_down, cbcd4 => cont_up, salr => num_bcd);

end rtl;