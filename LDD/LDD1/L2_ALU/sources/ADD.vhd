----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: firstname lastname and other guy/girl/...
-- 
-- Module Name: ADD - Structural
-- Course Name: Lab Digital Design
--
-- Description:
--  n-bit ripple carry adder
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ADD is
	generic(
       C_DATA_WIDTH : natural := 4
	);
	port(
                a : in  std_logic_vector((C_DATA_WIDTH-1) downto 0); -- input var 1
                b : in  std_logic_vector((C_DATA_WIDTH-1) downto 0); -- input var 2
         carry_in : in  std_logic;                                   -- input carry
           result : out std_logic_vector((C_DATA_WIDTH-1) downto 0); -- alu operation result
        carry_out : out std_logic                                    -- carry
	);
end entity;

architecture LDD1 of ADD is
	-- TODO: list of signals and components

	-- signals
	signal c_i: std_logic_vector(C_DATA_WIDTH downto 0):=(others=>'0');
	
	-- components
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
	-- TODO: complete architecture description
    G_1: for i in 0 to C_DATA_WIDTH-1 generate
            Ripple_Adder:
                FA1B port map(a(i),b(i),c_i(i), result(i), c_i(i + 1)); 
         end generate;
    
end LDD1;
