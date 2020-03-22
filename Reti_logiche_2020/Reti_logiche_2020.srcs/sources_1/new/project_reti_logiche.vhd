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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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

--per definire una variabile usare 2 signal


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


    find_wz : Process(i_clk, i_rst, i_start, i_data)
    Begin 
        if(i_rst = '1' ) then
            curr_state <= RESET;
        end if;
        
        if (rising_edge(i_clk)) then
            
            case curr_state is
                
                when RESET =>
                
                
                when ADDRESS_SET =>
                
                
                when WAIT_CLK =>
            
                
                when READ_RAM =>
                
                
                when CHECK_WZ =>
                
                
                when OUT_SET =>
                
                
                when WRITE_RAM =>
                
                
                when DONE_HIGH =>
                
                
                when DONE_LOW =>
               
               
           end case;
       end if;        
    end process;
end Behavioral;
