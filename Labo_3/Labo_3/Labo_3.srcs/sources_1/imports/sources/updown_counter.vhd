----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: Hannes Hugaert
-- 
-- Module Name: updown_counter - Behavioral
-- Course Name: Lab Digital Design
-- 
-- Description: 
--  n-bit up and down counter with asynchronous reset and overflow/underflow
--  indication. The count value is not further incremented/decremented when an
--  overflow/underflow occurs. 
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity updown_counter is
    generic(
        C_NR_BITS : integer := 4
    );
    port(
              clk : in  std_logic;
            reset : in  std_logic; -- async. reset
               up : in  std_logic; -- synch. count up
             down : in  std_logic; -- synch. count donw
        underflow : out std_logic; -- '1' on underflow
         overflow : out std_logic; -- '1' on overflow
            count : out std_logic_vector(C_NR_BITS-1 downto 0) -- count value
    );
end updown_counter;

architecture Behavioral of updown_counter is
    -- TODO: (optionally) declare signals
    signal output: std_logic_vector(C_NR_BITS-1 downto 0):=(others => '0');
    signal underflow_state: std_logic := '0';
    signal overflow_state: std_logic := '0';
begin
    -- TODO: write VHDL process
    Reg_Proc: process(clk, reset) is
    begin
        if(reset = '1') then
            output <= (output'range=>'0');
        elsif rising_edge(clk) then
            if(up = '1') then
                if(output = (output'range=>'1')) then
                    output <= output;
                    overflow_state <=  '1';
                    underflow_state <= '0';
                else 
                    output <= output + 1; 
                    overflow_state <=  '0';
                    underflow_state <= '0';
                end if;
            elsif (down = '1') then 
                if(output = (output'range=>'0')) then
                    output <= output;
                    underflow_state <=  '1';
                    overflow_state <=  '0';
                else 
                    output <= output - 1; 
                    underflow_state <= '0';
                    overflow_state <=  '0';
                end if;
            else 
                output <= output;
            end if;
        end if;
    end process;
    
    underflow <= underflow_state;
    overflow <= overflow_state;
    count <= output;

end Behavioral;
