----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 11:23:54
-- Design Name: 
-- Module Name: BM_instr - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BM_instr is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUT_instr : out STD_LOGIC_VECTOR (31 downto 0));
end BM_instr;

architecture Behavioral of BM_instr is

type bank_instr is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0); 
signal mem_instr : bank_instr := (
        1 => "00000110" & "00000000" & "00000111" & "00000000", 
        2 => "00000110" & "00000001" & "00001000" & "00000000", 
        3 => "00000110" & "00000010" & "00001001" & "00000000",
        4 => "00000001" & "00000011" & "00000000" & "00000001", 
        others => (others => '0'));  

begin
    
    -- READ
    OUT_instr <= mem_instr(to_integer(unsigned(ADDR)));

end Behavioral;
