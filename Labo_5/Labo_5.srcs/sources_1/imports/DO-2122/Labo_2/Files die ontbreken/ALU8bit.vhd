----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: Hannes Hugaert
-- 
-- Module Name: ALU8bit - Behavioral
-- Course Name: Lab Digital Design
--
-- Description: 
--  8-bit ALU that supports several logic and arithmetic operations
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU8bit is
    generic(
        C_DATA_WIDTH : natural := 8
    );
    port(
         X : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
         Y : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
         Z : out std_logic_vector(C_DATA_WIDTH-1 downto 0);
        -- operation select
        op : in std_logic_vector(3 downto 0);
        -- flags
        zf : out std_logic;
        cf : out std_logic;
        ef : out std_logic;
        gf : out std_logic;
        sf : out std_logic
    );
end ALU8bit;

architecture Behavioral of ALU8bit is
    -- operations defined in processor_pkg
    -- ALU_OP_NOT  
    -- ALU_OP_AND  
    -- ALU_OP_OR   
    -- ALU_OP_XOR  
    -- ALU_OP_ADD  
    -- ALU_OP_CMP  
    -- ALU_OP_RR   
    -- ALU_OP_RL   
    -- ALU_OP_SWAP 

    -- operation results
    signal result_i      : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal not_result_i  : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal and_result_i  : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal or_result_i   : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal xor_result_i  : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal rr_result_i   : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal rl_result_i   : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal add_result_i  : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal swap_result_i : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    -- help signals
    signal add_secondary_input_i : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others=>'0');
    signal add_carry_in_i: std_logic := '0';
    signal add_carry_i   : std_logic := '0';
    signal rl_carry_i : std_logic := '0';
    signal rr_carry_i : std_logic := '0';

    
    -- we use a separate module for the addition/subtraction
    component ADD is
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
    end component;
begin
    
    -- implementation of some operations
    -- and
    and_result_i <= X and Y ;
    -- or
    or_result_i <= X or Y ;
    -- xor
    xor_result_i <= X xor Y ;
    -- not
    not_result_i <= not X ;
    -- rr
    rr_result_i <= '0' & X(7 downto 1);
    -- rl
    rl_result_i <= X(6 downto 0) & '0';
    -- swap
    swap_result_i <= X(3 downto 0) & X(7 downto 4); 
    
    -- Ripple carry adder instantiation
    ADDER : ADD
    generic map(
        -- changes the default width of the adder to the width specified here
        C_DATA_WIDTH => C_DATA_WIDTH
    )
    port map(
                a => X,
                b => add_secondary_input_i,
         carry_in => add_carry_in_i,
           result => add_result_i,
        carry_out => add_carry_i
    );

    -- addition and subtraction
    add_secondary_input_i <= Y when (op="0101") else not Y;
    add_carry_in_i <= '1' when (op="0110") else '0';
    
    -- result_i mux: => selects corresponding output based on operation code
    with op select
        result_i <= not_result_i  when "0001",
                    and_result_i  when "0010",
                    or_result_i   when "0011",
                    xor_result_i  when "0100",
                    add_result_i  when "0101",
                    add_result_i  when "0110",
                    rr_result_i   when "1000",
                    rl_result_i   when "1001",
                    swap_result_i when "1010",
                    "00000000" when others;

    Z <= result_i;                    
    
    -- Carry's created by the rr and rl shift
    rl_carry_i <= X(7);
    rr_carry_i <= X(0);
    
    -- Using "with op select" to make sure the different carry signals do not
    -- interfere with each other
    with op select
        cf <= rr_carry_i when "1000",
              rl_carry_i when "1001",
              add_carry_i  when "0101",
              not add_carry_i  when "0110",
              '0' when others;

    -- zero flag
    -- to easily check for an all zero signal we use te attribute range=>'0'
    -- this gives us an all zero signal with the width of result_i 
    -- (in this case C_DATA_WIDTH-1 to 0)
    zf <= '1' when result_i = (result_i'range=>'0') else '0';
    
    -- equal, smaller, greater flag
    ef <= '1' when X = Y else '0';
    gf <= '1' when X > Y else '0';
    sf <= '1' when X < Y else '0';

end Behavioral;
