library ieee;
use ieee.std_logic_1164.all;

entity mux41 is
	port(I0, I1, I2, I3: in std_logic;
		  sel: in std_logic_vector(1 downto 0);
		  salm: out std_logic);
end mux41;

architecture behav of mux41 is
begin
	with sel select
		salm <= I0 when "00",--I0
				  I1 when "01",--I1
				  I2 when "10",--I2
				  I3 when "11",--I3
				  '-' when others;
end behav;