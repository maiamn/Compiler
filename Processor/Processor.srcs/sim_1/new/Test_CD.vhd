----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2022 10:25:48
-- Design Name: 
-- Module Name: Test_CD - Behavioral
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

entity Test_CD is
--  Port ( );
end Test_CD;

architecture Behavioral of Test_CD is

component CD 
    Port ( CD_CLK : in STD_LOGIC;
           CD_RST : in STD_LOGIC;
           OUTB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- Inputs 
signal my_CD_CLK : STD_LOGIC := '0' ; 
signal my_CD_RST : STD_LOGIC := '0' ; 

-- Outputs
signal my_OUTB : STD_LOGIC_VECTOR (7 downto 0);

constant Clock_period : time := 10 ns;

begin
Label_uut : CD PORT MAP(
    CD_CLK => my_CD_CLK, 
    CD_RST => my_CD_RST, 
    OUTB => my_OUTB
);


Clock_process : process
begin 
    my_CD_CLK <= not(my_CD_CLK);
    wait for Clock_period/2; 
end process;

-- Stimulus process 
my_CD_RST <= '1' after 10 ns;

end Behavioral;
