----------------------------------------------------------------------------------
-- Company: DRAMCO -- KU Leuven
-- Students: Hannes Hugaert
-- 
-- Module Name: driver_pwm_rgb_single - Behavioral
-- Course Name: Lab Digital Design
--
-- Description: 
--  PWM RGB LED driver
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity driver_pwm_rgb_single is
    generic(
          C_F_CLK : natural := 50000000;  -- system clock frequency
        C_F_COUNT : natural := 250000     -- count pulse frequency
    );
    port(
          clk : in  std_logic;                     -- system clock input
        reset : in  std_logic;                     -- async. system reset
         regR : in  std_logic_vector(7 downto 0);  -- PWM red value
         regG : in  std_logic_vector(7 downto 0);  -- PWM green value
         regB : in  std_logic_vector(7 downto 0);  -- PWM blue value
          rgb : out std_logic_vector(2 downto 0)   -- rgb output
    );
end driver_pwm_rgb_single;

architecture Behavioral of driver_pwm_rgb_single is
    constant C_REFRESH_COUNT_MAX : integer := (C_F_CLK / C_F_COUNT) - 1;
    constant C_BIT_RED : natural := 0;
    constant C_BIT_GREEN : natural := 1;
    constant C_BIT_BLUE : natural := 2;

    signal pulse_count_i : std_logic := '0';
    signal rgb_count_i : std_logic_vector(7 downto 0) := (others=>'0');
    signal count: integer:=0;
    signal rgb_output: std_logic_vector(2 downto 0) := (others=>'0');

begin

    -- TODO: write process to generate a count pulse
    COUNT_PULSE: process(clk)
    begin
        if(rising_edge(clk)) then
            count <= count + 1;
        end if;
        if(count = C_F_COUNT) then
            pulse_count_i <= '1';
        end if;
    end process;
    
    -- TODO: write a process to increase rgb_count_i on every count pulse
    RGB_COUNT: process(clk)
    begin
        if(pulse_count_i = '1') then
            if(rgb_count_i = "11111111") then 
                rgb_count_i <= "00000000";
            else
                rgb_count_i <= std_logic_vector( unsigned(rgb_count_i) + "1");
                pulse_count_i <= '0';
            end if;
        end if;
    end process; 
    
    -- TODO: generate pwm output signals based on rgb_count_i and regR/G/B inputs (no process!)
    rgb_output(C_BIT_RED) <= '1' when regR > rgb_count_i else '0';
    rgb_output(C_BIT_GREEN) <= '1' when regG > rgb_count_i else '0';
    rgb_output(C_BIT_BLUE) <= '1' when regB > rgb_count_i else '0';
    
    rgb <= rgb_output;
                              
    
end Behavioral;
