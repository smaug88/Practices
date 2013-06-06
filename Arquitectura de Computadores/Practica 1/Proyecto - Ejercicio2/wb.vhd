-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- WB.VHD
--
-- Etapa WB del procesador DLX32P
--
library IEEE;
use IEEE.std_logic_1164.all;

entity wb is
    port (
        data_mem: in STD_LOGIC_VECTOR (31 downto 0);
        data_ALU: in STD_LOGIC_VECTOR (31 downto 0);
        mux_wb:   in STD_LOGIC;
        data_WB:  out STD_LOGIC_VECTOR (31 downto 0)
    );
end wb;

architecture wb_arch of wb is
begin -- empieza la arquitectura
data_WB <= data_mem when (mux_wb='0') else data_ALU; -- multiplexor que selecciona el dato de la ALU o de la memoria de datos
end wb_arch;
