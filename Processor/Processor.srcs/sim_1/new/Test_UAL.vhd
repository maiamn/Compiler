----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 14:38:43
-- Design Name: 
-- Module Name: Test_UAL - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Test_UAL is
    
end Test_UAL;

architecture Behavioral of Test_UAL is

component UAL 
Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
       B : in STD_LOGIC_VECTOR (7 downto 0);
       Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
       S : out STD_LOGIC_VECTOR (7 downto 0);
       N : out STD_LOGIC;
       O : out STD_LOGIC;
       Z : out STD_LOGIC;
       C : out STD_LOGIC);
end component;

-- Inputs
signal my_A : STD_LOGIC_VECTOR (7 downto 0) := "00000011";
signal my_B : STD_LOGIC_VECTOR (7 downto 0) := "00000010"; 
signal my_Ctrl_Alu : STD_LOGIC_VECTOR (2 downto 0) := (others => '0') ; 

-- Outputs
signal my_S : STD_LOGIC_VECTOR (7 downto 0);
signal my_N : STD_LOGIC ;
signal my_O : STD_LOGIC ;
signal my_Z : STD_LOGIC ;
signal my_C : STD_LOGIC ;


begin
Label_uut : UAL PORT MAP(
    A => my_A, 
    B => my_B, 
    Ctrl_Alu => my_Ctrl_Alu, 
    S => my_S, 
    N => my_N, 
    O => my_O, 
    Z => my_Z, 
    C => my_C
);

-- Stimulus process 
my_Ctrl_Alu <= "001" after 00ns, "010" after 40ns, "011" after 80ns, "100" after 120ns;

end;
