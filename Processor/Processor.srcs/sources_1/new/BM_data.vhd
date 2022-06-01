----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 11:22:14
-- Design Name: 
-- Module Name: BM_data - Behavioral
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

entity BM_data is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           IN_data : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUT_data : out STD_LOGIC_VECTOR (7 downto 0));
end BM_data;

architecture Behavioral of BM_data is

type bank_data is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0); 
signal mem_data : bank_data;

begin

process (CLK)
    begin
    
        -- wait until rising edge
        if (CLK'Event and CLK='1') then
        
            -- RST 
            if (RST='0') then 
                mem_data <= (others=> X"00"); 
                
            -- WRITE 
            elsif (RW='0') then
                mem_data(to_integer(unsigned(ADDR))) <= IN_data;
      
            end if;           
        end if;
    
    end process;
    
    -- READ
    OUT_data <= mem_data(to_integer(unsigned(ADDR)));

end Behavioral;
