--------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: Hannes Hugaert
-- 
-- Module Name: ADD - Structural
-- Course Name: Lab Digital Design
--
-- Description:
--  n-bit ripple carry adder
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ADD is
	generic(
       C_DATA_WIDTH : natural := 4
	);
	port(
                a : in  std_logic_vector((C_DATA_WIDTH-1) downto 0);
                b : in  std_logic_vector((C_DATA_WIDTH-1) downto 0);
         carry_in : in  std_logic;                                  
           result : out std_logic_vector((C_DATA_WIDTH-1) downto 0);
        carry_out : out std_logic                                    
	);
end entity;

architecture LDD1 of ADD is
	-- List of n+1 carry's for n-full adders and a single carry_out.
	signal c_i: std_logic_vector(C_DATA_WIDTH downto 0):=(others=>'0');
	
	-- 1 bit full adder component
    component FA1B is
    port(
          A : in std_logic;
		  B : in std_logic;
		  carry_in : in std_logic;
		  S : out std_logic;
		  Cout : out std_logic
        );
    end component;
    
begin

    --First carry is from outside, rest can be initiated in for-loop
    c_i(0) <= carry_in;
    
    --Generate n-1 full adders to create a Ripple Adder
    G_1: for i in 0 to C_DATA_WIDTH-1 generate
            Ripple_Adder:
                FA1B port map(a(i),b(i),c_i(i), result(i), c_i(i + 1)); 
         end generate;
    --Last carry is the carry_out
    carry_out <= c_i(C_DATA_WIDTH);
    
end LDD1;
