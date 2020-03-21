----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.03.2020 16:29:15
-- Design Name: 
-- Module Name: Working_Zone - Behavioral
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

use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_reti_logiche is
port (
i_clk : in std_logic;
i_start : in std_logic;
i_rst : in std_logic;
i_data : in std_logic_vector(7 downto 0);
o_address : out std_logic_vector(15 downto 0);
o_done : out std_logic;
o_en : out std_logic;
o_we : out std_logic;
o_data : out std_logic_vector (7 downto 0)
);
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is

signal o_reg1 : std_logic_vector(7 downto 0);
signal o_reg2 : std_logic_vector(7 downto 0);
signal o_reg3 : std_logic_vector(7 downto 0);
signal o_reg4 : std_logic_vector(7 downto 0);
signal o_reg5 : std_logic_vector(7 downto 0);
signal o_reg6 : std_logic_vector(7 downto 0);
signal o_reg7 : std_logic_vector(7 downto 0);
signal o_reg8 : std_logic_vector(7 downto 0);
signal o_reg9 : std_logic_vector(7 downto 0);
signal r1_load : std_logic;
signal r2_load : std_logic;
signal r3_load : std_logic;
signal r4_load : std_logic;
signal r5_load : std_logic;
signal r6_load : std_logic;
signal r7_load : std_logic;
signal r8_load : std_logic;
signal r9_load : std_logic;
signal sub: std_logic_vector(7 downto 0);
signal ris: std_logic_vector(2 downto 0);
signal base_wz: std_logic;

type S is(S0,S10,S11,S12,S13,S14,S15,S16,S17,S18,S2,S3,S4,S5,S6);
signal cur_state, next_state: S; 

begin
    process (i_clk,i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif i_clk'event and i_clk = '1' then
            cur_state <= next_state;
        end if;
    end process;
    
    
    process(cur_state, i_start)
    begin
        next_state <= cur_state;
        case cur_state is
            when S0 => 
                if i_start = '1' then 
                    next_state <= S10;
                 end if;
            when S10 =>
                next_state <= S11;
            when S11 =>
                next_state <= S12;
            when S12 =>
                next_state <= S13;
            when S13 =>
                next_state <= S14;
            when S14 =>
                next_state <= S15;
            when S15 =>
                next_state <= S16;
            when S16 =>
                next_state <= S17;
            when S17 =>
                next_state <= S18;
            when S18 =>
                next_state <= S2;
            when S2 =>
                next_state <= S3;
            when S3 =>
                next_state <= S4;
            when S4 =>
                next_state <= S5;
            when S5 => --o_done = '1'
                if i_start = '0' then
                    next_state <= S6;
                end if;
            when S6 => 
                next_state <= S0;
        end case;
     end process;
     
     process(cur_state)
     begin
        r1_load <= '0';
        r2_load <= '0';
        r3_load <= '0';
        r4_load <= '0';
        r5_load <= '0';
        r6_load <= '0';
        r7_load <= '0';
        r8_load <= '0';
        r9_load <= '0';
        o_address <= "0000000000000000";
        o_en <= '0';
        o_we <= '0';
        o_done <= '0';           
        case cur_state is
            when S0 =>
            when S10 =>
                o_address <= "0000000000001000";
                o_en <= '1';
                r1_load <= '1';
            when S11 =>
                o_address <= "0000000000000000";
                o_en <= '1';
                r2_load <= '1';
            when S12 =>
                o_address <= "0000000000000001";
                o_en <= '1';
                r3_load <= '1';
            when S13 =>
                o_address <= "0000000000000010";
                o_en <= '1';
                r4_load <= '1';
            when S14 =>
                o_address <= "0000000000000011";
                o_en <= '1';
                r5_load <= '1';
            when S15 =>
                o_address <= "0000000000000100";
                o_en <= '1';
                r6_load <= '1';
            when S16 =>
                o_address <= "0000000000000101";
                o_en <= '1';
                r7_load <= '1';
            when S17 =>
                o_address <= "0000000000000110";
                o_en <= '1';
                r8_load <= '1';
            when S18 =>
                o_address <= "0000000000000111";
                o_en <= '1';
                r9_load <= '1';
            when S2 =>
                base_wz <= '0';
                sub <= o_reg1 - o_reg2; --il valore di sub contiene SEMPRE l'offset
                if (0 < sub) or (sub > 3) then --non sono nella wz1 ??
                    sub <= o_reg1 - o_reg3;
                    if (0 < sub) or (sub > 3) then
                        sub <= o_reg1 - o_reg4; --il valore di sub contiene SEMPRE l'offset
                        if (0 < sub) or (sub > 3) then --non sono nella wz3 ??
                            sub <= o_reg1 - o_reg5;
                            if (0 < sub) or (sub > 3) then
                                sub <= o_reg1 - o_reg6; --il valore di sub contiene SEMPRE l'offset
                                if (0 < sub) or (sub > 3) then --non sono nella wz5 ??
                                    sub <= o_reg1 - o_reg7;
                                    if (0 < sub) or (sub > 3) then
                                        sub <= o_reg1 - o_reg8; --il valore di sub contiene SEMPRE l'offset
                                        if (0 < sub) or (sub > 3) then --non sono nella wz7 ??
                                            sub <= o_reg1 - o_reg9;
                                            if (0 < sub) or (sub > 3) then -- non sono nella wz8
                                                base_wz <= '1';
                                            else --se entro qui sono nella wz (e entro SOLO in questo else)
                                                ris <= "111";
                                            end if;
                                        else --se entro in questo else sono nella wz7  
                                            ris <= "110";
                                        end if;
                                    else --se entro qui sono nella wz6 (e entro SOLO in questo else)
                                        ris <= "101";
                                    end if;
                                else --se entro in questo else sono nella wz5  
                                    ris <= "100";
                                end if;
                            else --se entro qui sono nella wz4 (e entro SOLO in questo else)
                                ris <= "011";
                            end if;
                        else --se entro in questo else sono nella wz3  
                            ris <= "010";
                        end if;
                    else --se entro qui sono nella wz2 (e entro SOLO in questo else)
                        ris <= "001";
                    end if;
                else --se entro in questo else sono nella wz1  
                    ris <= "000";
                end if;
            when S3 => --converto offset (sub) in onehot, ris contiene la wz || se invece ris = 0 allora non è in nessuna wz
                if base_wz = '1' then -- non sono in nessuna wz metto il risutato così com'è
                    o_data <= o_reg1;
                else 
                    if sub = "00000000" then --codifica in onehot
                        o_data <= '1' & ris & "0001";
                    elsif sub = "00000001" then
                        o_data <= '1' & ris & "0010";
                    elsif sub = "00000010" then
                        o_data <= '1' & ris & "0100";
                    elsif sub = "00000011" then
                        o_data <= '1' & ris & "1000";
                    end if;
                end if;
            when S4 =>
                o_we <= '1';
                o_en <= '1';
                o_address <= "0000000000001001";
            when S5 =>
                o_done <= '1';
            when S6 =>
                o_done <= '0';
end case;

end process;
         
end Behavioral;
         

