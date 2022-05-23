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
signal mem_instr : bank_instr; 

begin

  mem_instr(0) <= "00000110000000000000011100000000";
  mem_instr(1) <= "00000110000000010000100000000000";
  mem_instr(2) <= "00000110000000100000100100000000";
  mem_instr(3) <= "00000101000000010000001100000000";
        
  -- READ
  OUT_instr <= mem_instr(to_integer(unsigned(ADDR)));

end Behavioral;
