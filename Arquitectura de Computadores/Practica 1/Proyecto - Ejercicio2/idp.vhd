-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- IDp.VHD
--
-- Etapa ID de DLX32p: decodificacion y lectura de operandos
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.dlx_pack.all;

entity idp is
port(
	clr, clock: 		in std_logic;
	NextPC: 		in std_logic_vector(31 downto 0); -- PC+4
	instruccion, Data_W: 	in std_logic_vector(31 downto 0); -- codigo instruccion en PC, y dato a escribir en banco de registros
	ALU_control: 		out std_logic_vector(5 downto 0); -- palabra de control de la ALU
	b_dir_W: 		in std_logic_vector(4 downto 0); -- direccion del registro de escritura del banco
	WE_b32x32_ext: 		in std_logic; -- habilitacion de la operacion de escritura en el banco de registros
	control_word, Data_A, Data_B, inmediato, NextPC_out: out std_logic_vector(31 downto 0)  -- Salida: control, datos de los puertos A y B del banco de registros , inmediato, PC+4
    );
end idp;

architecture comportamental of idp is -- empieza la arquitectura

component control -- unidad de control
port(
	clr: in std_logic;
	COP: in TypeDlxOpcode; -- codigo operacion de la instruccion de 6 bits
	func: in TypeDlxFunc; -- campo "func" de la instruccion de 6 bits
	cond_Z: in std_logic; -- cuando (Z=1) el contenido del registro es cero 
	MUX_rt_rd, MUX_PC, WE_b32x32, MUX_ALU_A, MUX_ALU_B, WE_mem, MUX_wb, beq, j: out std_logic; -- senyales de control
	ALU_op: out std_logic_vector(5 downto 0));
end component;

component b32x32  -- banco de 32 registros de 32 bits
port (  DAT_P1W_up : in STD_LOGIC_VECTOR (31 downto 0); -- dato de escritura en el banco de registros
	DIR_P1W_up, DIR_P2R_up, DIR_P3R_up: in STD_LOGIC_VECTOR (4 downto 0); -- P1: puerto de escritura; P2: primer puerto de lectura; P3: segundo puerto de lectura
	WE_up, CLK_up : in STD_LOGIC; -- senyales de sincronismo
	DAT_P2R_up, DAT_P3R_up : out STD_LOGIC_VECTOR (31 downto 0) ); -- datos de lectura de los puertos A y B
end component; 

component inm -- calculo del inmediato
port(
	beq, j, mux_wb: in std_logic; 
	NPC: in std_logic_vector(31 downto 0); -- 4 bits mas significativos del PC siguiente
	parte_instruccion: in std_logic_vector(25 downto 0);
	inmediato: out std_logic_vector(31 downto 0)  -- Salida inmediato y PA y PB
    );
end component;

signal mux_rt_rd, b32x32_we, control_j, control_beq, Z, control_mux_wb: std_logic;
signal DataA: std_logic_vector(31 downto 0); 
signal dir_W: std_logic_vector(4 downto 0); 

begin -- empieza la arquitectura

NextPC_out <= NextPC; -- el PC+4 entra y sale
Z <= '1' when (DataA = X"00000000") else '0'; -- Gneracion del flag Zero para las instrucciones de salto condicional

u1: control port map (
  clr => clr,
  COP => instruccion(31 downto 26), -- codigo de operacion de la instruccion
  func => instruccion(5 downto 0), -- codigo de operacion en la ALU
  cond_Z => Z, MUX_rt_rd => mux_rt_rd,
  MUX_PC => control_word(7), WE_b32x32 => b32x32_we, MUX_ALU_A => control_word(5), MUX_ALU_B => control_word(4), 
  WE_mem => control_word(3), MUX_wb => control_mux_wb, beq => control_beq ,j => control_j,
  ALU_op => ALU_control -- control de la ALU
);

-- Generacion de la palabra de control, por ahora solo se usan 9 bits de un total de 32
control_word(31 downto 9) <= (others=>'0');
control_word(8) <= mux_rt_rd;
control_word(6) <= b32x32_we;
control_word(2) <= control_mux_wb;
control_word(1) <= control_beq;
control_word(0) <= control_j;

dir_W <= b_dir_W; -- direccion del puerto de escritura del banco de registros que viene desde la etapa WB a traves de la entity

u2: b32x32 port map (
  DAT_P1W_up => Data_W,  -- dato a escribir por el puerto de escritura
  DIR_P1W_up => dir_W, -- direccion del puerto escritura
  DIR_P2R_up => instruccion(25 downto 21), -- direccion del puerto de lectura rs/rs1
  DIR_P3R_up => instruccion(20 downto 16), -- direccion del puerto de lectura rt/rs2
  WE_up => WE_b32x32_ext, -- habilitacion escritura en banco registros, desde etapa WB
  CLK_up => clock, 
  DAT_P2R_up => DataA, -- dato leido por el puerto A del banco registros
  DAT_P3R_up => Data_B -- dato leido por el puerto B del banco registros
);

Data_A <= DataA;

u3: inm port map (
  beq => control_beq,j => control_j, mux_wb => control_mux_wb, -- senyales de control
  NPC => NextPC, -- PC+4
  parte_instruccion => instruccion(25 downto 0), -- entrada del inmediato de 26 bits
  inmediato => inmediato -- Salida del inmediato de 32 bits
);

end;
