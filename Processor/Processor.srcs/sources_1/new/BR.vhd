----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 11:39:36
-- Design Name: 
-- Module Name: BR - Behavioral
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

entity BR is
    Port ( A_addr : in STD_LOGIC_VECTOR (3 downto 0);
           B_addr : in STD_LOGIC_VECTOR (3 downto 0);
           W_addr : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end BR;

architecture Behavioral of BR is

type bank_registers is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0); 
signal registers : bank_registers; 

begin

    process (CLK)
    begin
    
        -- wait until rising edge
        if (CLK'Event and CLK='1') then
        
            -- RST 
            if (RST='0') then 
                registers <= (others=> X"00"); 
                
            -- WRITE 
            elsif (W='1') then
                registers(to_integer(unsigned(W_addr))) <= DATA;
            end if;           
        end if;
    
    end process;

    -- read and bypass
    QA <= registers(to_integer(unsigned(A_addr))) when W_addr/=A_addr or W='0'
          else DATA;
    QB <= registers(to_integer(unsigned(B_addr))) when W_addr/=B_addr or W='0'
          else DATA;
    

end Behavioral;
