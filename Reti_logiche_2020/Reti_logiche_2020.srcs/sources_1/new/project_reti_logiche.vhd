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

--RESET legge l'indirizzo da codificare


end Behavioral;
