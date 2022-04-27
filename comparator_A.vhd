library ieee;
use ieee.std_logic_1164.all;
library work;
entity fulladder is
	port(a,b,cin: in std_logic;
	sum,cout: out std_logic);
end fulladder;

architecture struct of fulladder is
signal w1,w2,w3: std_logic;
begin
	g1 : entity work.xorgate(behav) port map (A,B,w1);
	g2 : entity work.xorgate(behav) port map (w1,Cin,sum);	
	g3 : entity work.andgate(behav) port map (A,B,w2);
	g4 : entity work.andgate(behav) port map (w1,Cin,w3);
	g5 : entity work.orgate(behav) port map (w2,w3,Cout);
end struct;


library ieee;
use ieee.std_logic_1164.all; 
library work;
entity fulladder8bit is
	port(a,b: in std_logic_vector(7 downto 0);
	cin: in std_logic;
	s: out std_logic_vector(7 downto 0);
	cout: out std_logic);
end fulladder8bit;

architecture struct of fulladder8bit is
signal c1,c2,c3,c4,c5,c6,c7: STD_LOGIC;
begin
	FA1 : entity work.fulladder(struct) port map (A(0),B(0),Cin,s(0),c1);
	FA2 : entity work.fulladder(struct) port map (A(1),B(1),C1,s(1),c2);	
	FA3 : entity work.fulladder(struct) port map (A(2),B(2),C2,s(2),c3);
	FA4 : entity work.fulladder(struct) port map (A(3),B(3),C2,s(3),c4);
	FA5 : entity work.fulladder(struct) port map (A(4),B(4),C2,s(4),c5);
	FA6 : entity work.fulladder(struct) port map (A(5),B(5),C2,s(5),c6);
	FA7 : entity work.fulladder(struct) port map (A(6),B(6),C2,s(6),c7);	
	FA8 : entity work.fulladder(struct) port map (A(7),B(7),C2,s(7),cout);
end struct;


library ieee;
use ieee.std_logic_1164.all; 
library work;
entity subtractor is
	port(a,b: in std_logic_vector(7 downto 0);
	bin: in std_logic;
	s: out std_logic_vector(7 downto 0);
	bout: out std_logic);
end subtractor;

architecture struct of subtractor is
signal nb: STD_LOGIC_vector(7 downto 0);
begin
	N1 : entity work.notgate(behav) port map (B(0),nb(0));
	N2 : entity work.notgate(behav) port map (B(1),nb(1));	
	N3 : entity work.notgate(behav) port map (B(2),nb(2));
	N4 : entity work.notgate(bahav) port map (B(3),nb(3));
	N5 : entity work.notgate(bahav) port map (B(4),nb(4));
	N6 : entity work.notgate(bahav) port map (B(5),nb(5));
	N7 : entity work.notgate(bahav) port map (B(6),nb(6));	
	N8 : entity work.notgate(bahav) port map (B(7),nb(7));
	adder : entity work.fulladder8bit(struct) port map (A,nb,bin,s,bout);
end struct;


library ieee;
use ieee.std_logic_1164.all; 
library work;
entity comparator8bit is
	port(a,b: in std_logic_vector(7 downto 0);
	a_less_b,a_equal_b,a_greater_b: out std_logic);
end comparator8bit;

architecture struct of comparator8bit is
signal s: STD_LOGIC_vector(7 downto 0);
signal bout, w1,w2,w3,w4,w5,w6,w7,w8,w9: std_logic;
begin
	S1 : entity work.subtractor(struct) port map (a,b,'0',s,bout);
	N2 : entity work.norgate(behav) port map (s(0),S(1),w1);	
	N3 : entity work.norgate(behav) port map (s(2),a(3),w2);
	N4 : entity work.norgate(bahav) port map (s(4),s(5),w3);
	N5 : entity work.norgate(bahav) port map (s(6),s(7),w4);
	A6 : entity work.andgate(bahav) port map (w1,w2,w5);
	A7 : entity work.andgate(bahav) port map (w3,w4,w6);	
	A8 : entity work.andgate(bahav) port map (w5,w6,w7);
	X9 : entity work.xorgate(behav) port map (bout,s(7),w8);
	O10 : entity work.orgate(behav) port map (w7,w8,w9);
	N11 : entity work.notgate(bahav) port map (w9,a_greater_b);
	a_less_b <= w7;
	a_equal_b <= w8;
end struct;	


library ieee;
use ieee.std_logic_1164.all; 
library work;
entity sync_comparator is
	port(a,b: in std_logic_vector(7 downto 0);
	clk: in std_logic;
	a_less_b,a_equal_b,a_greater_b: out std_logic);
end sync_comparator;

architecture struct of sync_comparator is
signal a_reg,b_reg: STD_LOGIC_vector(7 downto 0);
signal reg_out1,reg_out2,reg_out3: std_logic;
begin
	C1 : entity work.comparator8bit port map (a_reg,b_reg,reg_out1,reg_out2,reg_out3);
	process(CLK)
	begin
		if(rising_edge(clk)) then
			a_reg <= a;
			b_reg <= b;
			a_less_b <= reg_out1;
			a_equal_b <= reg_out2;
			a_greater_b <= reg_out3;
		end if;
	end process;
end architecture struct;	  


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all; 
library work;
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
   signal A, B : std_logic_vector(7 downto 0) := (others => '0');
   signal A_less_B, A_equal_B, A_greater_B, clk : std_logic;
   constant clock_freq : integer := 100e6;
   constant clock_period : time := 1000 ms / clock_freq; 
BEGIN
   uut: entity work.sync_comparator PORT MAP (a,b,clk,a_less_b,a_equal_b,a_greater_b);
   clk <= not Clk after clock_period / 2;
   stim_proc: process
   begin 
  -- create test cases for A_less_B
  for i in 0 to 255 loop 
	  
           A <= std_logic_vector(to_signed(i,A'length));  
           B <= std_logic_vector(to_signed(i+1,B'length));  
           wait for clock_period;
		   assert ((a_equal_b = '0') and (a_less_b = '1') and (a_greater_b = '0')) report "<error message>" severity error;
      end loop;
  -- create test cases for A_greater_B
   for i in 0 to 255 loop 
           A <= std_logic_vector(to_signed(i+1,A'length));  
           B <= std_logic_vector(to_signed(i,B'length));  
           wait for clock_period;
		   assert ((a_equal_b = '0') and (a_less_b = '0') and (a_greater_b = '1')) report "<error message>" severity error;
      end loop;
  -- create test cases for A_equal_B
  for i in 0 to 255 loop 
           A <= std_logic_vector(to_signed(i,A'length));  
           B <= std_logic_vector(to_signed(i,B'length));   
           wait for clock_period;
		   assert ((a_equal_b = '1') and (a_less_b = '0') and (a_greater_b = '0')) report "<error message>" severity error;
      end loop;
      wait;
   end process;

END;