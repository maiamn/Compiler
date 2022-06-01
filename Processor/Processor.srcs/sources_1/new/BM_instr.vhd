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
         1  => "00000110" & "00000000" & "00000100" & "00000000", --r0 <-4 AFC
         2 => "00000000" & "00000000" & "00000000" & "00000000",
         3 => "00000000" & "00000000" & "00000000" & "00000000",
         
         4  => "00000101" & "00000001" & "00000000" & "00000000", --r1 <- r0 (4) COP
         
         5 => "00000000" & "00000000" & "00000000" & "00000000",
         6 => "00000000" & "00000000" & "00000000" & "00000000",
         
         7 => "00000001" & "00000010" & "00000000" & "00000001", --r2 <- r0 + r1 (8) ADD
         
         8 => "00000000" & "00000000" & "00000000" & "00000000",
         9 => "00000000" & "00000000" & "00000000" & "00000000",
         
         10 => "00000011" & "00000011" & "00000010" & "00000000", --r3 <- r2 - r0 (4) SOU
         
         11 => "00000000" & "00000000" & "00000000" & "00000000",
         12 => "00000000" & "00000000" & "00000000" & "00000000",
         
         13 => "00001000" & "00000110" & "00000010" & "00000000", -- store r2 (8) at adress 6 STORE
         
         14 => "00000000" & "00000000" & "00000000" & "00000000",
         15 => "00000000" & "00000000" & "00000000" & "00000000",
         
         16 => "00000111" & "00000100" & "00000110" & "00000000", -- load @6 (8) in r4 LOAD
         
         17 => "00000000" & "00000000" & "00000000" & "00000000",
         18 => "00000000" & "00000000" & "00000000" & "00000000",
         
         19 => "00000100" & "00000101" & "00000010" & "00000000", -- r5 <- r2 (8) / 2 DIV
         
         20 => "00000000" & "00000000" & "00000000" & "00000000",
         21 => "00000000" & "00000000" & "00000000" & "00000000",
         
         22 => "00000010" & "00000110" & "00000011" & "00000010", -- r6 <- r3 (4) * r2 (8) (=32) MUL

        -- Test pour aléas
--           1 => "00000110" & "00000000" & "00000100" & "00000000", -- AFC r0 <- 4
--           2 => "00000110" & "00000001" & "00001000" & "00000000", -- AFC r1 <- 8
--           3 => "00000001" & "00000010" & "00000000" & "00000001", -- ADD r2 <- r0 +r1 (=12)
           others => (others => '0'));  

begin
    
    -- READ
    OUT_instr <= mem_instr(to_integer(unsigned(ADDR)));

end Behavioral;
