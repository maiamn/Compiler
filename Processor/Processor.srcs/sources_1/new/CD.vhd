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
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

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

-- Constant
constant NOP : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; 
constant ADD : STD_LOGIC_VECTOR(7 downto 0) := "00000001";
constant MUL : STD_LOGIC_VECTOR(7 downto 0) := "00000010";
constant SOU : STD_LOGIC_VECTOR(7 downto 0) := "00000011";
constant DIV : STD_LOGIC_VECTOR(7 downto 0) := "00000100";
constant COP : STD_LOGIC_VECTOR(7 downto 0) := "00000101";
constant AFC : STD_LOGIC_VECTOR(7 downto 0) := "00000110";
constant LOAD : STD_LOGIC_VECTOR(7 downto 0) := "00000111";
constant STORE : STD_LOGIC_VECTOR(7 downto 0) := "00001000";


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


-- Signaux composants
signal UAL_A : STD_LOGIC_VECTOR (7 downto 0);
signal UAL_B : STD_LOGIC_VECTOR (7 downto 0);
signal UAL_Ctrl : STD_LOGIC_VECTOR (2 downto 0);
signal UAL_S : STD_LOGIC_VECTOR (7 downto 0);
signal UAL_N : STD_LOGIC;
signal UAL_O : STD_LOGIC;
signal UAL_Z : STD_LOGIC;
signal UAL_C : STD_LOGIC;

signal BR_A_addr : STD_LOGIC_VECTOR (3 downto 0) := (others => '0') ;
signal BR_B_addr : STD_LOGIC_VECTOR (3 downto 0) := (others => '0') ;
signal BR_W_addr : STD_LOGIC_VECTOR (3 downto 0) := (others => '0') ;
signal BR_W : STD_LOGIC := '0';
signal BR_DATA : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal BR_QA : STD_LOGIC_VECTOR (7 downto 0);
signal BR_QB : STD_LOGIC_VECTOR (7 downto 0);

signal BMD_ADDR : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal BMD_IN_data : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal BMD_RW : STD_LOGIC := '1';
signal BMD_OUT_data : STD_LOGIC_VECTOR (7 downto 0);

signal BMI_ADDR : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal BMI_CLK : STD_LOGIC;
signal BMI_OUT_instr : STD_LOGIC_VECTOR (31 downto 0) := (others => '0') ; 


-- Signaux intermédiaires 
signal IP : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); 

signal op1_in : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a1_in, b1_in, c1_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op1_out : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a1_out, b1_out, c1_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal op2_in : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a2_in, b2_in, c2_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op2_out : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a2_out, b2_out, c2_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal op3_in : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a3_in, b3_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op3_out : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a3_out, b3_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal op4_in : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a4_in, b4_in: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op4_out : STD_LOGIC_VECTOR(7 downto 0) := NOP;
signal a4_out, b4_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');


-- MUX
signal MUX1 : STD_LOGIC_VECTOR(8 downto 0) := "100111110"; 
signal MUX2 : STD_LOGIC_VECTOR(8 downto 0) := "000011110";
signal MUX3 : STD_LOGIC_VECTOR(8 downto 0) := "010000000";
signal MUX4 : STD_LOGIC_VECTOR(8 downto 0) := "100000000"; 

signal LC3 : STD_LOGIC_VECTOR(8 downto 0) := "011111111"; 
signal LC4 : STD_LOGIC_VECTOR(8 downto 0) := "011111110"; 


-- Aléa
signal alea : STD_LOGIC := '0';

signal alea_risk_write_3 : STD_LOGIC := '0';
signal alea_risk_write_data_3 : STD_LOGIC := '0';
signal alea_risk_write_2 : STD_LOGIC := '0';
signal alea_risk_write_data_2 : STD_LOGIC := '0';

signal alea_risk_read_1 : STD_LOGIC := '0';
signal alea_risk_read_data_1 : STD_LOGIC := '0';
signal alea_risk_read_ual_1 : STD_LOGIC := '0';

signal alea_a3_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal alea_a2_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal alea_b1_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal alea_c1_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal num_nop : STD_LOGIC_VECTOR(1 downto 0) := "00";


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
        CLK => CD_CLK,
        RST => CD_RST,
        QA => BR_QA, 
        QB => BR_QB);
        
    my_bm_data : BM_data port map(
        ADDR => BMD_ADDR, 
        IN_data => BMD_IN_data, 
        RW => BMD_RW,
        CLK => CD_CLK, 
        RST => CD_RST,
        OUT_data => BMD_OUT_data);
        
    my_bm_instr : BM_instr port map(
        ADDR => BMI_ADDR, 
        CLK => CD_CLK,
        OUT_instr => BMI_OUT_instr);  

   -- IP
   BMI_ADDR <= IP; 
    
    -- Etage 1 
    op1_in <= BMI_OUT_instr(31 downto 24);
    a1_in <= BMI_OUT_instr(23 downto 16);
    b1_in <= BMI_OUT_instr(15 downto 8); 
    c1_in <= BMI_OUT_instr(7 downto 0); 
    
    op1_out <= op1_in; 
    a1_out <= a1_in; 
    b1_out <= b1_in; 
    c1_out <= c1_in; 
    
    -- BR 
    BR_A_addr <= b1_out(3 downto 0);
    BR_B_addr <= c1_out(3 downto 0);
    BR_W_addr <= a4_out(3 downto 0);
    BR_W <= LC4(to_integer(unsigned(op4_out)));
    BR_DATA <= b4_out;
    
    -- Etage 2 
    op2_in <= op1_out;
    a2_in <= a1_out;
    b2_in <= BR_QA when (MUX1(to_integer(unsigned(op1_out)))='1') else b1_out;
    c2_in <= BR_QB; 
    
    -- ALU
    UAL_A <= b2_out ; 
    UAL_B <= c2_out;
    UAL_Ctrl <= op2_out(2 downto 0); --LC
    
    -- Etage 3
    op3_in <= op2_out; 
    a3_in <= a2_out; 
    b3_in <= UAL_S when (MUX2(to_integer(unsigned(op2_out)))='1') else b2_out;
    
    -- BM
    BMD_ADDR <= a3_out when (MUX4(to_integer(unsigned(op3_out)))='1') else b3_out; 
    BMD_IN_data <= b3_out; 
    BMD_RW <= LC3(to_integer(unsigned(op3_out)));
    
    -- Etage 4
    op4_in <= op3_out;
    a4_in <= a3_out;
    b4_in <= BMD_OUT_data when (MUX3(to_integer(unsigned(op3_out)))='1') else b3_out; 
    
    -- Aléas
        -- Write
    alea_risk_write_3 <= '0' when (op3_in = NOP or op3_in = STORE) else '1';
    alea_risk_write_data_3 <= '1' when (op3_in = STORE) else '0';
    alea_a3_in <= a3_in; -- registre où on écrit
    
    alea_risk_write_2 <= '0' when (op2_in = NOP or op2_in = STORE) else '1';
    alea_risk_write_data_2 <= '1' when (op2_in = STORE) else '0';
    alea_a2_in <= a2_in; -- registre où on écrit
    
        -- Read
    alea_risk_read_1 <= '0' when (op1_in = LOAD or op1_in = AFC) else '1';
    alea_risk_read_data_1 <= '1' when (op1_in = LOAD) else '0';
    alea_risk_read_ual_1 <= '1' when (op1_in = ADD or op1_in = SOU or op1_in = MUL or op1_in = DIV) else '0';
    alea_b1_in <= b1_in;
    alea_c1_in <= c1_in;
    
    
    alea <= '1' 
            when (
            --alea_1_2
                (alea_risk_read_1 = '1' and alea_risk_write_2 = '1' and alea_a2_in=alea_b1_in) or
                (alea_risk_read_data_1 = '1' and alea_risk_write_data_2 = '1' and alea_a2_in=alea_b1_in) or
                (alea_risk_read_ual_1 = '1' and alea_a2_in=alea_c1_in) or
            --alea_1_3
                (alea_risk_read_1 = '1' and alea_risk_write_3 = '1' and alea_a3_in=alea_b1_in) or
                (alea_risk_read_data_1 = '1' and alea_risk_write_data_3 = '1' and alea_a3_in=alea_b1_in) or
                (alea_risk_read_ual_1 = '1' and alea_a3_in=alea_c1_in)
            )
            else '0';

    -- Elements à réaliser en séquentiel 
    process (CD_CLK)
    begin 
        if (CD_CLK'Event and CD_CLK='1') then 
        
            -- Etage 4 
            op4_out <= op4_in;
            a4_out <= a4_in; 
            b4_out <= b4_in;
                   
            -- Etage 3
            op3_out <= op3_in ;
            a3_out <= a3_in; 
            b3_out <= b3_in;
            
            -- Etage 2
            op2_out <= op2_in;
            a2_out <= a2_in;
            b2_out <= b2_in; 
            c2_out <= c2_in;
                                                
            IP <= IP+1;
                   
        
--            if(alea = '1' or (num_nop /= "00" and num_nop /= "11")) then
--                      op2_out <= NOP;
--                      a2_out <= "00000000";
--                      b2_out <= "00000000"; 
--                      c2_out <= "00000000";
--                    else
                    
--                      num_nop <= "00";
                                            
--                     -- Etage 2
--                     op2_out <= op2_in;
--                     a2_out <= a2_in;
--                     b2_out <= b2_in; 
--                     c2_out <= c2_in;
                                                        
--                     IP <= IP+1; 
--                    end if;
 
        end if; 
    end process; 

    OUTB <= b4_out;

end Behavioral;
