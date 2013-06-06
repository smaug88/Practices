-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- b32x32.vhd
--
-- Banco de 3 puertos de 32 registros de 32 bits
--
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

entity b32x32 is 
-- P1: puerto de escritura; P2: primer puerto de lectura; P3: segundo puerto de lectura
port (  DAT_P1W_up : 	in STD_LOGIC_VECTOR (31 downto 0); 
	DIR_P1W_up, DIR_P2R_up, DIR_P3R_up: in STD_LOGIC_VECTOR (4 downto 0); 
	WE_up, CLK_up : in STD_LOGIC; 
	DAT_P2R_up, DAT_P3R_up : out STD_LOGIC_VECTOR (31 downto 0));
end b32x32; 

architecture behav of b32x32 is

component BANCOREG -- memoria de 1 puerto de lectura y 1 puerto de escritura
-- P1: puerto de escritura; P2: puerto de lectura
port (  DAT_P1W_int : in STD_LOGIC_VECTOR (31 downto 0); 
	DIR_P1W_int,DIR_P2R_int: in STD_LOGIC_VECTOR (4 downto 0); 
	WE_int,CLK_int : in STD_LOGIC; 
	DAT_P2R_int,DAT_P1R_int : out STD_LOGIC_VECTOR (31 downto 0) ); 
end component; 

signal NULO1,NULO2: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal WE_int: STD_LOGIC;

begin -- EL BANCO DE REGISTROS REALMENTE ESTA DUPLICADO: u1 y u2

WE_int <= '0' when (DIR_P1W_up = "00000") else WE_up; -- se detecta la seleccion del registro R0 para deshabilitar escrituras al R0

u1:BANCOREG port map( -- primera replica
	DAT_P1W_int => DAT_P1W_up,  
	DIR_P1W_int => DIR_P1W_up, DIR_P2R_int => DIR_P2R_up,
	WE_int => WE_int, CLK_int => CLK_up, 
	DAT_P2R_int => DAT_P2R_up, DAT_P1R_int => NULO1
);	  

u2:BANCOREG port map( -- segunda replica
	DAT_P1W_int => DAT_P1W_up,  
	DIR_P1W_int => DIR_P1W_up, DIR_P2R_int => DIR_P3R_up,
	WE_int => WE_int, CLK_int => CLK_up, 
	DAT_P2R_int => DAT_P3R_up, DAT_P1R_int => NULO2
);	  

end behav;
	 
