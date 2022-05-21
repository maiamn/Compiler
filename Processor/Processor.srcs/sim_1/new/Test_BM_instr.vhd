----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 10:50:28
-- Design Name: 
-- Module Name: Test_BM_instr - Behavioral
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

entity Test_BM_instr is

end Test_BM_instr;

architecture Behavioral of Test_BM_instr is

component BM_instr 
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUT_instr : out STD_LOGIC_VECTOR (31 downto 0));
end component;

--Inputs
signal my_ADDR : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal my_CLK : STD_LOGIC := '0' ; 

--Output
signal my_OUT_instr : STD_LOGIC_VECTOR (31 downto 0);

constant Clock_period : time := 10 ns;

begin
Label_uut : BM_instr PORT MAP(
    CLK => my_CLK,
    ADDR => my_ADDR, 
    OUT_instr => my_OUT_instr
);

Clock_process : process
begin 
    my_CLK <= not(my_CLK);
    wait for Clock_period/2; 
end process;

-- Stimulus process 
my_ADDR <= "00000010" after 00 ns, "00000011" after 20ns ;

end Behavioral;
