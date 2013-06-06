-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- IF.VHD
--
-- Etapa de busqueda de la instruccion del procesador DLX32p
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity etapa_IF is
port(
	CLK, RESET: in std_logic;
	EIF1: in std_logic; -- senales de control del multiplexor que alimenta el PC
	EIF6: in std_logic_vector(31 downto 0); -- direccion destino de una instruccion de salto condicional e incondicional
	SIF1, SIF2: out std_logic_vector(31 downto 0)  -- PC+4 y PC
    );
end etapa_IF;

architecture comportamental of etapa_IF is -- empieza la arquitectura de la etapa de busqueda

signal S,pc: std_logic_vector(31 downto 0);
signal PCW: std_logic; 

begin

PCW <= '1'; -- habilitamos siempre al registro PC. Se puede utilizar para introducir burbujas

process (CLK,RESET) -- registro del PC
begin
  if (RESET='0') then
	pc <= (others=>'0');
  elsif (CLK='1' and CLK'event) then
        if (PCW='1') then
	    if (EIF1 ='0') then
		pc <= pc + 4; -- nuevo contador de programa PC
	    else  
		pc <= EIF6; -- direccion destino de la instruccion de salto
	    end if;
	end if;
  end if;
end process;

SIF1 <= pc + 4; -- PC+4
SIF2 <= pc; -- PC

end;
