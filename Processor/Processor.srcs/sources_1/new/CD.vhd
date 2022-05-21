----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 09:51:26
-- Design Name: 
-- Module Name: CD - Behavioral
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

entity CD is
    Port ( CD_CLK : in STD_LOGIC;
           CD_RST : in STD_LOGIC;
           OUTB : out STD_LOGIC_VECTOR (7 downto 0));
end CD;

architecture Behavioral of CD is

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

component BM_data
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           IN_data : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUT_data : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component BM_instr 
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUT_instr : out STD_LOGIC_VECTOR (31 downto 0));
end component;


-- Signaux intermédiaires
signal UAL_A : STD_LOGIC_VECTOR (7 downto 0);
signal UAL_B : STD_LOGIC_VECTOR (7 downto 0);
signal UAL_Ctrl : STD_LOGIC_VECTOR (2 downto 0);
signal UAL_S : STD_LOGIC_VECTOR (7 downto 0);
signal UAL_N : STD_LOGIC;
signal UAL_O : STD_LOGIC;
signal UAL_Z : STD_LOGIC;
signal UAL_C : STD_LOGIC;

signal BR_A_addr : STD_LOGIC_VECTOR (3 downto 0);
signal BR_B_addr : STD_LOGIC_VECTOR (3 downto 0);
signal BR_W_addr : STD_LOGIC_VECTOR (3 downto 0);
signal BR_W : STD_LOGIC;
signal BR_DATA : STD_LOGIC_VECTOR (7 downto 0);
signal BR_QA : STD_LOGIC_VECTOR (7 downto 0);
signal BR_QB : STD_LOGIC_VECTOR (7 downto 0);

signal BMD_ADDR : STD_LOGIC_VECTOR (7 downto 0);
signal BMD_IN_data : STD_LOGIC_VECTOR (7 downto 0);
signal BMD_RW : STD_LOGIC;
signal BMD_OUT_data : STD_LOGIC_VECTOR (7 downto 0);

signal BMI_ADDR : STD_LOGIC_VECTOR (7 downto 0);
signal BMI_CLK : STD_LOGIC;
signal BMI_OUT_instr : STD_LOGIC_VECTOR (31 downto 0);

begin
    my_ual: UAL PORT MAP(
        A => UAL_A, 
        B => UAL_B, 
        Ctrl_Alu => UAL_Ctrl, 
        S => UAL_S, 
        N => UAL_N, 
        O => UAL_O, 
        Z => UAL_Z, 
        C => UAL_C);
        
    my_br : BR port map(
        A_addr => BR_A_addr, 
        B_addr => BR_B_addr, 
        W_addr => BR_W_addr, 
        W => BR_W, 
        DATA => BR_DATA, 
        QA => BR_QA, 
        QB => BR_QB);
        
    bm_data : BM_data port map(
        ADDR => BMD_ADDR, 
        IN_data => BMD_IN_data, 
        RW => BMD_RW,
        OUT_data => BMD_OUT_data);
        
    bm_instr : BM_instr port map(
        ADDR => BMI_ADDR, 
        OUT_instr => BMI_OUT_instr);  
    
    -- 1st - LI/DI
    process (CLK)
    begin
        -- wait until rising edge
        if (CLK'Event and CLK='1') then
        
        end if;
    end process;
    
    
    -- 2nd - DI/EX
    process (CLK)
    begin
        -- wait until rising edge
        if (CLK'Event and CLK='1') then
        
        end if;
    end process;
    
        
    -- 3rd - EX/Mem
    process (CLK)
    begin
        -- wait until rising edge
        if (CLK'Event and CLK='1') then
        
        end if;
    end process;
    
    
    -- 4th - Mem/RE
    process (CLK)
    begin
        -- wait until rising edge
        if (CLK'Event and CLK='1') then
        
        end if;
    end process;



end Behavioral;
