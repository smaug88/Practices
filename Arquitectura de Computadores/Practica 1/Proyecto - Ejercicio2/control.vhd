-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- control.vhd
--
-- Unidad de control del procesador, la cual se encuentra en la etapa ID del procesador DLX32p
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.dlx_pack.all;

entity control  is
port(
	clr: 	in std_logic;
	COP: 	in TypeDlxOpcode; -- codigo operacion de la instruccion de 6 bits
	func: 	in TypeDlxFunc; -- campo "func" de 6 bits de la instruccion
	cond_Z: in std_logic; -- contenido registro cero (Z=1)
	MUX_rt_rd,MUX_PC,WE_b32x32,MUX_ALU_A,MUX_ALU_B,WE_mem,MUX_wb,beq,j: out std_logic;
	ALU_op: out std_logic_vector(5 downto 0)); -- palabra de control de la ALU
end control;

architecture estructural of control is

signal c_out: std_logic_vector(8 downto 0);
signal COP_int: TypeDlxOpcode;

begin

COP_int <= cOpcode_undef_06 when (COP=cOpcode_alu and func=cAluFunc_nop) else COP; -- se quitan los "nop" de las del tipo R-R para que realmente no hagan nada

with COP_int select -- c_out = MUX_rt_rd, MUX_PC, WE_b32x32, MUX_ALU_A, MUX_ALU_B, WE_mem, MUX_wb, beq, j;
	c_out <="101100100" when cOpcode_alu, -- operacion ALU
	 	"001110000" when cOpcode_lw, -- carga desde memoria de datos (lw)
	 	"000111000" when cOpcode_sw, -- almacenamiento en memoria de datos (sw)
	 	"001110100" when cOpcode_ori, -- or inmediato
		'0' & cond_Z & "0010010" when cOpcode_beqz, -- salto condicional si registro=0 (Z=1,beqz)
	 	"010010001" when cOpcode_j, -- salto incondicional (j)
		"000000000" when others; -- aqui se incluyen los "nop"
	
with COP_int select
	ALU_op <= func when cOpcode_alu, -- va directamente a la ALU
		  cAluFunc_add when cOpcode_lw, -- sumar direccion e inmediato
		  cAluFunc_add when cOpcode_sw, -- sumar direccion e inmediato
	 	  cAluFunc_or when cOpcode_ori, -- or inmediato
		  cAluFunc_undef_01 when cOpcode_beqz, -- ALU_out <= PC+4 + Inm
		  cAluFunc_undef_01 when cOpcode_j, -- ALU_out<= PC+4 + Inm(25..0)
		  cAluFunc_nop when others;
-- Salidas	
MUX_rt_rd <= c_out(8);
MUX_PC <= c_out(7) and clr; 
WE_b32x32 <= c_out(6) and clr;
MUX_ALU_A <= c_out(5) and clr;
MUX_ALU_B <= c_out(4) and clr;
WE_mem <= c_out(3) and clr;
MUX_wb <= c_out(2) and clr;
beq <= c_out(1) and clr;
j <= c_out(0) and clr;
end;
