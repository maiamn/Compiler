----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 10:20:28
-- Design Name: 
-- Module Name: Test_BM_data - Behavioral
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

entity Test_BM_data is
    
end Test_BM_data;

architecture Behavioral of Test_BM_data is

component BM_data 
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           IN_data : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUT_data : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--Inputs
signal my_ADDR : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal my_IN_data : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;  
signal my_RW : STD_LOGIC := '0';
signal my_RST : STD_LOGIC := '1' ;  
signal my_CLK : STD_LOGIC := '0' ; 

--Output
signal my_OUT_data : STD_LOGIC_VECTOR (7 downto 0);

constant Clock_period : time := 10 ns;

begin
Label_uut : BM_data PORT MAP(
    CLK => my_CLK,
    ADDR => my_ADDR, 
    IN_data => my_IN_data, 
    RW => my_RW, 
    RST => my_RST, 
    OUT_data => my_OUT_data
);

Clock_process : process
begin 
    my_CLK <= not(my_CLK);
    wait for Clock_period/2; 
end process;

-- Stimulus process 
my_IN_data <= "00000010" after 00 ns, "00000011" after 20 ns;
my_ADDR <= "00000010" after 00 ns, "00000011" after 20ns ;
my_RW <= '0' after 00 ns, '1' after 40ns;
my_RST <= '0' after 60ns;

end Behavioral;
