library ieee;
use ieee.std_logic_1164.all;
entity notgate is
	port(a: in std_logic; o: out std_logic);
end	notgate;

architecture behav of notgate is		  
begin
	o <= not a after 2 ns;
end behav;

library ieee;
use ieee.std_logic_1164.all;
entity nandgate is
	port(a,b: in std_logic; o: out std_logic);
end	nandgate;

architecture behav of nandgate is		  
begin
	o <= a nand b after 5 ns;
end behav;			  

library ieee;
use ieee.std_logic_1164.all;
entity norgate is
	port(a,b: in std_logic; o: out std_logic);
end	norgate;

architecture behav of norgate is		  
begin
	o <= a nor b after 5 ns;
end behav;

library ieee;
use ieee.std_logic_1164.all;
entity andgate is
	port(a,b: in std_logic; o: out std_logic);
end	andgate;

architecture behav of andgate is		  
begin
	o <= a and b after 7 ns;
end behav; 

library ieee;
use ieee.std_logic_1164.all;
entity orgate is
	port(a,b: in std_logic; o: out std_logic);
end	orgate;

architecture behav of orgate is		  
begin
	o <= a or b after 7 ns;
end behav;			

library ieee;
use ieee.std_logic_1164.all;
entity xorgate is
	port(a,b: in std_logic; o: out std_logic);
end	xorgate;

architecture behav of xorgate is		  
begin
	o <= a xor b after 9 ns;
end behav;			   

library ieee;
use ieee.std_logic_1164.all;
entity xnorgate is
	port(a,b: in std_logic; o: out std_logic);
end	xnorgate;

architecture behav of xnorgate is		  
begin
	o <= a xnor b after 12 ns;
end behav;