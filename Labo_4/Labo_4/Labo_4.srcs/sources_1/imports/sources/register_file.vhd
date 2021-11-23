----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: Hannes Hugaert
-- 
-- Module Name: register_file - Behavioral
-- Course Name: Lab Digital Design
--
-- Description:
--  Generic register file description. The number of registers and the data width
--  can be set with C_NR_REGS and C_DATA_WIDTH respectively.
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is
    generic(
        C_DATA_WIDTH : natural := 8;
           C_NR_REGS : natural := 8
    );
    port(
                 clk : in  std_logic;
               reset : in  std_logic;
                  le : in  std_logic;
              in_sel : in  std_logic_vector(C_NR_REGS-1 downto 0);
             out_sel : in  std_logic_vector(C_NR_REGS-1 downto 0);
             data_in : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
            data_out : out std_logic_vector(C_DATA_WIDTH-1 downto 0)
    );
end register_file;

architecture Behavioral of register_file is
    -- TODO: declare what will be used
    type register_array is array(0 to C_NR_REGS) of std_logic_vector(C_DATA_WIDTH-1 downto 0);
    -- signal types
    signal data_outputs: register_array;
    signal mux_outputs: std_logic_vector(C_NR_REGS-1 downto 0):=(others => '0');
    signal or_outputs: std_logic_vector(C_NR_REGS-1 downto 0):=(others => '0');
    -- signals
    signal output: std_logic_vector(C_DATA_WIDTH-1 downto 0):=(others => '0');

    -- components
    component basic_register is
    generic(
        C_DATA_WIDTH : natural := 8
    );
    port(
                 clk : in  std_logic;
               reset : in  std_logic;
                  le : in  std_logic;
             data_in : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
            data_out : out std_logic_vector(C_DATA_WIDTH-1 downto 0)
    );
    end component;
begin
    -- TODO: describe how it's all connected and how it behaves
    GEN_REG:
    for I in 0 to register_array'range-1 generate
        single_register: basic_register port map (clk => clk,
                                                  reset => reset, 
                                                  le => in_sel(I), 
                                                  data_in => data_in, 
                                                  data_out => data_outputs(I));
   end generate GEN_REG;
   
   OUT_INIT: process is
    begin
        ADD_D_OUT:
        for i in 0 to register_array'range-1 generate
            if out_sel(i) = '1' then
                data_out(i) <= data_outputs(i) or data_outputs(i + 1);
            else
                data_output(i) <= (data_out(i)'range=>'0') or data_out(i + 1);
            end if;
        end generate;
    end process;
   
   data_out <= output;
   
end Behavioral;
