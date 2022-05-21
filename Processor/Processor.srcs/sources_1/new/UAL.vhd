----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 13:28:39
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end UAL;

architecture Behavioral of UAL is

    -- declarations 
    signal Aux_A : STD_LOGIC_VECTOR (7 downto 0) ; 
    signal Aux_B : STD_LOGIC_VECTOR (7 downto 0) ; 
    signal Aux_S : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ; 
    signal Aux_N : STD_LOGIC ;
    signal Aux_O : STD_LOGIC ;
    signal Aux_Z : STD_LOGIC ;
    signal Aux_C : STD_LOGIC ;
   
    signal S_add : STD_LOGIC_VECTOR (8 downto 0) := (others => '0') ; 
    signal S_mul : STD_LOGIC_VECTOR (15 downto 0) := (others => '0') ; 
    signal S_sub : STD_LOGIC_VECTOR (8 downto 0) := (others => '0') ; 
    signal S_div : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;

begin

    Aux_A <= A;
    Aux_B <= B;
    S <= Aux_S;
    N <= Aux_N;
    O <= Aux_O;
    Z <= Aux_Z;
    C <= Aux_C;

    -- ADD
    S_add <= ('0'&Aux_A) + ('0'&Aux_B); 
    
    -- MUL 
    S_mul <= Aux_A*Aux_B;
    
    -- SUB
    S_sub <= ('0'&Aux_A) - ('0'&Aux_B); 
    
    -- DIV
    S_div <= shr(A, "1");
    
    -- Result
    Aux_S <= S_add (7 downto 0) when Ctrl_Alu= "001" else 
             S_mul (7 downto 0) when Ctrl_Alu= "010" else
             S_sub (7 downto 0) when Ctrl_Alu= "011" else
             S_div (7 downto 0) when Ctrl_Alu= "100";
             
    Aux_Z <= '1' when Aux_S="00" else '0';
    
    Aux_C <= Aux_S(7) when Ctrl_Alu="001" else '0'; 
    Aux_O <= '1' when (S_mul(15 downto 8)/=X"00") else '0';
    Aux_N <= Aux_S(7) when Ctrl_Alu="011" else '0';  
    

end Behavioral;
