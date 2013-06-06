-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- INM.VHD
--
-- Etapa de generacion del valor inmediato de 32 bits a partir del codigo de instruccion para llevarlo a la ALU del DLX32p
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.dlx_pack.all;

entity inm is
port(
	beq,j,mux_wb: 	   in std_logic; -- indica que tipo de inmediato necesitan las distintas instrucciones
	NPC: 		   in std_logic_vector(31 downto 0); -- PC+4
	parte_instruccion: in std_logic_vector(25 downto 0); -- 26 bits menos significativos del codigo de instruccion
	inmediato: 	   out std_logic_vector(31 downto 0)  -- Salida del valor inmediato de 32 bits
    );
end inm;

architecture comportamental of inm is

signal extension1,extension2,extension3,extension4: std_logic_vector(31 downto 0);
signal PCW: std_logic_vector(2 downto 0); 
signal extension,cero16: std_logic_vector(15 downto 0); 
signal ext: std_logic_vector(5 downto 0);

begin -- empieza la arquitectura

PCW <= beq & j & mux_wb;
extension <= (others=>parte_instruccion(15)); -- generamos parte CON extension signo 16 bits
ext <= (others=>parte_instruccion(25)); -- extendemos el signo al inmediato 6 bits
cero16 <= (others=>'0'); -- generamos parte SIN extension signo 16 bits

process(parte_instruccion,NPC,extension,ext) -- genera la direccion de salto en la instruccion "beqz" y "j"
variable temp1,temp2 : signed(31 downto 0);
begin
	--beqz: extension1 <= (PC + 4) + inmediato-16 bits-extendido en signo
	temp1 := MVL_TO_SIGNED(extension & parte_instruccion(15 downto 0)); -- convertimos inm-32 bits a entero con signo
	temp2 := temp1 + MVL_TO_SIGNED(NPC); -- sumamos
	extension1 <= CONV_STD_LOGIC_VECTOR(temp2,32); -- convertimos a std_logic
	--j: extension2 <= (PC + 4) + inmediato-26 bits-extendido en signo
	temp1 := MVL_TO_SIGNED(ext & parte_instruccion); -- convertimos a entero con signo
	temp2 := temp1 + MVL_TO_SIGNED(NPC); -- sumamos
	extension2 <= CONV_STD_LOGIC_VECTOR(temp2,32); -- convertimos a std_logic
end process;

extension3 <= extension & parte_instruccion(15 downto 0); -- inmediato de 32 bits con extension de signo para operaciones aritmeticas con inmediato
extension4 <= cero16 & parte_instruccion(15 downto 0); -- inmediato de 32 bits sin extension de signo para operaciones logicas con inmediato

with PCW select -- seleccionamos finalmente el tipo de inmediato de salida
inmediato <= 	extension1 when "100", -- beq
		extension2 when "010", -- j
		extension4 when "001", -- OR inmediato
		extension3 when others; -- demas instrucciones
end;
