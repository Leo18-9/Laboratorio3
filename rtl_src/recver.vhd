library ieee;
use ieee.std_logic_1164.all;

entity recver is
	port(cbcd1, cbcd2, cbcd3, cbcd4: in std_logic_vector(3 downto 0);
		  selmux: in std_logic_vector(1 downto 0);
		  salr: out std_logic_vector(6 downto 0));
end recver;

architecture behav of recver is
	signal salmux: std_logic_vector(3 downto 0);
begin

U2: entity work.deco7seg port map(ent => salmux, leds => salr);

mux_gen: for i in 3 downto 0 generate
	U1: entity work.mux41 port map(I0 => cbcd1(i), I1 => cbcd2(i), I2 => cbcd3(i), I3 => cbcd4(i), sel => selmux, salm => salmux(i));
end generate;

end behav;