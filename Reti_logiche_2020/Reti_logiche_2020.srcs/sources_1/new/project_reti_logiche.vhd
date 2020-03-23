----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2020 19:38:58
-- Design Name: 
-- Module Name: project_reti_logiche - Behavioral
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


LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity project_reti_logiche is Port (
     i_clk         : in  std_logic;
     i_start       : in  std_logic;
     i_rst         : in  std_logic;
     i_data        : in  std_logic_vector(7 downto 0);
     o_address     : out std_logic_vector(15 downto 0);
     o_done        : out std_logic;
     o_en          : out std_logic;
     o_we          : out std_logic;
     o_data        : out std_logic_vector (7 downto 0)
     );

end project_reti_logiche;

architecture Behavioral of project_reti_logiche is

type state is (RESET, ADDRESS_SET, WAIT_CLK, READ_RAM, CHECK_WZ, OUT_SET, WRITE_RAM, DONE_HIGH, DONE_LOW);
signal curr_state, next_state : state;
signal input_address : std_logic_vector (7 downto 0);
signal current_working_zone : std_logic_vector (7 downto 0);
signal ram_pos_counter : std_logic_vector(3 downto 0);
signal i : integer range 7 to 1;
signal offset : std_logic_vector (7 downto 0);
signal offset_onehot : std_logic_vector (3 downto 0);
signal ram_pos_out : std_logic_vector (2 downto 0);
--per definire una variabile usare 2 signal
--var e var_next

begin

--RESET inizializzazione segnali

--ADDRESS-SET incrementa il valore di o_address per poter leggere da memoria. i valori di o_address vanno reinizializzati dopo un i_rst ricevuto
--inizializzato all'indirizzo n.8 della ram,decremento di 1 ogni ciclo, fino a n.0

--WAIT_CLK 

--READ_RAM
--leggo da memoria il valore di i_data salvando in un signal apposito, se il valore letto è l'indirizzo da codificare torno allo stato ADDRESS_SET
--se ho letto un indirizzo base WZ, vado in stato CHECK_WZ

--CHECK_WZ controllo se l'indirizzo è nella wz
--True va in OUT_SET
--False va in ADDRESS_SET


--OUT_SET setta o_data con il valore codificato correttamente 

--WRITE_RAM setto segnali per output su ram
    
--ONE_HIGH alzo done

--DONE_LOW abbasso done(completata scrittura e start basso)


    working_zone : Process(i_clk, i_rst, i_start, i_data)
        
    Begin 
        if(i_rst = '1' ) then
            curr_state <= RESET;
        end if;
        
        if (rising_edge(i_clk)) then
            
            case curr_state is
                
                when RESET =>
                    if(i_start = '0') then
                        curr_state <= RESET;
                    elsif (i_start = '1') then
                        ram_pos_counter <= "1001";
                        input_address <= "00000000";
                        current_working_zone <= "00000000";
                        offset <= "00000000";
                        curr_state <= ADDRESS_SET;
                    end if;
                    
                when ADDRESS_SET =>
                    o_en <= '1';
                    o_we <= '0';
                    if(ram_pos_counter = "0000") then
                        ram_pos_counter <= "1111";
                        curr_state <= OUT_SET;
                    else
                        o_address <= "000000000000" & (ram_pos_counter - "0001");
                        curr_state <= WAIT_CLK;
                    end if;
                    
                when WAIT_CLK =>
                    curr_state <= READ_RAM;
                    
                when READ_RAM =>
                    if( ram_pos_counter = "1001") then
                        input_address <= i_data;
                        ram_pos_counter <= ram_pos_counter - "0001";
                        curr_state <= ADDRESS_SET;                    
                    else
                        current_working_zone <= i_data;
                        ram_pos_counter <= ram_pos_counter - "0001";
                        curr_state <= CHECK_WZ;
                    end if;
                    
                when CHECK_WZ =>
                    offset <= input_address - current_working_zone;
                    if(offset = "00000000") then
                        curr_state <= OUT_SET;
                    elsif(offset = "00000001") then
                        curr_state <= OUT_SET;
                    elsif(offset = "00000010") then
                        curr_state <= OUT_SET;
                    elsif(offset = "00000011") then
                        curr_state <= OUT_SET;
                    else
                        curr_state <= ADDRESS_SET;
                    end if;
                    
                when OUT_SET =>
                    if(ram_pos_counter = "1111" ) then
                        for i in 1 to 7 loop
                            o_data(i-1) <= input_address(i);
                        end loop;
                        o_data <= '0' & input_address;
                        curr_state <= WRITE_RAM;
                    else
                        if(offset = "00000000") then
                            offset_onehot <= "0001";
                        elsif(offset = "00000001") then
                            offset_onehot <= "0010";
                        elsif(offset = "00000010") then
                            offset_onehot <= "0100";
                        elsif(offset = "00000011") then
                            offset_onehot <= "1000";
                        end if;
                        for i in 0 to 2 loop
                            ram_pos_out(i) <= ram_pos_counter(i+1);
                        end loop;        
                        o_data <= '1' & ram_pos_out & offset_onehot;
                        curr_state <= WRITE_RAM;
                    end if;   
                
                when WRITE_RAM =>
                    o_en <= '1';
                    o_we <= '1';
                    o_address <= "0000000000001001";
                    curr_state <= DONE_HIGH;
                    
                when DONE_HIGH =>
                    o_done <= '1';
                    curr_state <= DONE_LOW;
                       
                when DONE_LOW =>
                    o_done <= '0';
                    curr_state <= RESET;
                           
           end case;
       end if;        
    end process;
end Behavioral;
