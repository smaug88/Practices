-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- MEM_PROG.VHD
--
-- Memoria de programa que utiliza una estructura ROM
--
use work.DLX_pack.all;   
use work.DLX_prog2.all; -- donde se encuentra el programa a ejecutar

entity ROM_32x8 is
  port(ADDR: in ROM_RANGE;
       DATA: out ROM_WORD);
end ROM_32x8;

architecture comportamental of ROM_32x8 is
begin
  DATA <= ROM(ADDR);  -- lectura desde la ROM
end comportamental;
