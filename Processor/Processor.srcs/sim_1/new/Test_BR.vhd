----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 10:15:12
-- Design Name: 
-- Module Name: Test_BR - Behavioral
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

entity Test_BR is
    
end Test_BR;

architecture Behavioral of Test_BR is

component BR
    Port ( A_addr : in STD_LOGIC_VECTOR (3 downto 0);
           B_addr : in STD_LOGIC_VECTOR (3 downto 0);
           W_addr : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- Inputs
signal my_CLK : STD_LOGIC := '0' ;
signal my_A_addr : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal my_B_addr : STD_LOGIC_VECTOR (3 downto 0) := "0001";
signal my_W_addr : STD_LOGIC_VECTOR (3 downto 0);
signal my_W : STD_LOGIC := '1' ;
signal my_DATA : STD_LOGIC_VECTOR (7 downto 0);
signal my_RST : STD_LOGIC := '0' ;

-- Outputs
signal my_QA : STD_LOGIC_VECTOR (7 downto 0);
signal my_QB : STD_LOGIC_VECTOR (7 downto 0);

constant Clock_period : time := 10 ns;

begin
Label_uut : BR PORT MAP(
    CLK => my_CLK,
    A_addr => my_A_addr,
    B_addr => my_B_addr,
    W_addr => my_W_addr,
    W => my_W,
    DATA => my_DATA,
    RST => my_RST,
    QA => my_QA,
    QB => my_QB
);

Clock_process : process
begin 
    my_CLK <= not(my_CLK);
    wait for Clock_period/2; 
end process;

-- Stimulus process
my_DATA <= "00000010" after 10 ns, "00000100" after 30 ns, "00000111" after 100 ns;
my_W_addr <= "0000" after 10 ns, "0001" after 30 ns, "0010" after 100 ns;
my_W <= '0' after 50 ns, '1' after 100 ns;
my_RST <= '1' after 80 ns;
my_A_addr <= "0010" after 100 ns;

end Behavioral;
