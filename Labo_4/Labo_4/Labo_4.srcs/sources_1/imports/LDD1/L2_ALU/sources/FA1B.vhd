----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: firstname lastname and other guy/girl/...
-- 
-- Module Name: FA1B - Behavioral
-- Course Name: Lab Digital Design
--
-- Description:
--  Full adder (1-bit)
--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FA1B IS 
	PORT(
		-- TODO: complete entity declaration
		A : in std_logic;
		B : in std_logic;
		carry_in : in std_logic;
		S : out std_logic;
		Cout : out std_logic
	);
END entity;

ARCHITECTURE LDD1 OF FA1B IS
    signal a_xor_b_result_i : std_logic := '0';
BEGIN
	-- TODO: complete architecture
	a_xor_b_result_i <= A xor B;
	S <= a_xor_b_result_i xor carry_in;
	Cout <= (A and B) or (a_xor_b_result_i and carry_in);
END LDD1;

