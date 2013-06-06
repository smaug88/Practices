-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- DLX32p.vhd
--
-- Modulo del procesador de instrucciones DLX32p. Este es un procesador segmentado de 5 etapas: IF, ID, EX, MEM, WB
-- Dispone de 4 modulos que coinciden con las etapas del procesador a excepcion de MEM
--
library IEEE;
use IEEE.std_logic_1164.all;

entity DLX32p is
    port (
        clk: 		in STD_LOGIC;
        clr: 		in STD_LOGIC;
        addr_Pmem: 	out STD_LOGIC_VECTOR (31 downto 0); -- direccion mem programa
        instruction: 	in STD_LOGIC_VECTOR (31 downto 0); -- dato de la mem programa
        addr_Dmem: 	out STD_LOGIC_VECTOR (31 downto 0); -- direc mem datos
        data_out_Dmem: 	out STD_LOGIC_VECTOR (31 downto 0); -- dato escrito en mem datos
        data_in_Dmem: 	in STD_LOGIC_VECTOR (31 downto 0); -- dato leido de mem datos
        we_Dmem: 	out STD_LOGIC; -- habilitacion escritura en mem datos
        BR_A,BR_B,BR_W: out STD_LOGIC_VECTOR (31 downto 0); -- datos de lectura (A, B) y escritura (W) en el banco de registros
        BR_WE: 		out STD_LOGIC -- habilitacion de escritura en el banco de registros
    );
end DLX32p;

architecture DLX32s_arch of DLX32p is

component etapa_IF -- Implementa la etapa IF del procesador DLX32p
port(
	CLK, RESET: in std_logic; -- entradas de las senyales de reloj y reset de la etapa
	EIF1: in std_logic; -- control del multiplexor que alimenta el PC
	EIF6: in std_logic_vector(31 downto 0); -- direccion destino de las instrucciones de salto condicional e incondicional
	SIF1, SIF2: out std_logic_vector(31 downto 0)  -- salidas PC+4 y PC respectivamente
    );
end component ;

component idp -- Implementa la etapa ID del procesador DLX32p
port(
	clr, clock: in std_logic; -- entradas de las senyales de reloj y reset de la etapa
	NextPC: in std_logic_vector(31 downto 0); -- entrada por donde especta PC+4
	instruccion, Data_W: in std_logic_vector(31 downto 0); -- codigo instruccion almacenado en la direccion PC, y dato a escribir en banco de registros
	ALU_control: out std_logic_vector(5 downto 0); -- palabra de control dirigida expresamente a la ALU
	b_dir_W: in std_logic_vector(4 downto 0); -- direccion del registro donde se escribe el resultado de una instruccion
	WE_b32x32_ext: in std_logic; -- senyal de habilitacion de escritura en banco registros
	control_word, Data_A, Data_B, inmediato, NextPC_out: out std_logic_vector(31 downto 0)  -- Salida: palabra de control del procesador, dato leido por el puerto A del banco registros, dato leido por el puerto B, valor del inmediato de 32 bits, PC+4
    );
end component;

component ex -- Implementa la etapa EX del procesador DLX32p
    port (
    	MUX_A_control,MUX_B_control: in STD_LOGIC; -- control de los multiplexores de entrada a la ALU: MUX_ALU_A y MUX_ALU_B
    	ALU_control: in STD_LOGIC_VECTOR (5 downto 0); -- palabra de control de la ALU
        NextPC, Data_A, Data_B, Inm: in STD_LOGIC_VECTOR (31 downto 0); -- NextPC=PC+4, Data_A,Data_B= Banco, Inm= inmediato
        ALU_out: out STD_LOGIC_VECTOR (31 downto 0) -- salida de la ALU
    );
end component;

component wb -- Implementa la etapa WB del procesador DLX32p
    port (
        data_mem: in STD_LOGIC_VECTOR (31 downto 0); -- dato leido desde la memoria de datos
        data_ALU: in STD_LOGIC_VECTOR (31 downto 0); -- dato resultado de una operacion en la ALU
        mux_wb: in STD_LOGIC; -- control del multiplexor de la etapa WB
        data_WB: out STD_LOGIC_VECTOR (31 downto 0) -- dato seleccionado en la etapa WB que se escribe en el banco de registros
    );
end component;

-- VARIABLES GLOBALES
signal n_clk: std_logic;
signal ALU_out_int, dataW_int, NPC, NPCout, dataRS, dataRT, INM, control : STD_LOGIC_VECTOR (31 downto 0);
signal controlALU : STD_LOGIC_VECTOR (5 downto 0); -- palabra de control de la ALU
signal MUX_PC,MUX_ALU_A,MUX_ALU_B,MUX_wb: std_logic; -- sanales de control de muxs desde CONTROL.VHD
signal reg_IF_ID : STD_LOGIC_VECTOR (64 downto 0); -- registro de segmentacion IF/ID
signal reg_ID_EX : STD_LOGIC_VECTOR (148 downto 0); -- registro de segmentacion ID/EX
signal reg_EX_MEM : STD_LOGIC_VECTOR (72 downto 0); -- registro de segmentacion EX/MEM
signal reg_MEM_WB : STD_LOGIC_VECTOR (71 downto 0); -- registro de segmentacion MEM/WB
signal ena_IF_ID, ena_ID_EX, ena_EX_MEM, ena_MEM_WB : std_logic;
signal WE_b32x32, mux_rt_rd, clr_idp : std_logic;
signal control_ID_EX : STD_LOGIC_VECTOR (8 downto 0);
signal control_EX_MEM: STD_LOGIC_VECTOR (2 downto 0);
signal control_MEM_WB: STD_LOGIC_VECTOR (1 downto 0);
signal dir_rt_rd, dir_W, dir_rt_rd_EX_MEM, dir_rt_rd_MEM_WB : STD_LOGIC_VECTOR (4 downto 0);

begin -- empieza a describirse la arquitectura

n_clk <= not(clk); -- se invierte el reloj del sistema computador

u1: etapa_IF port map( -- Etapa IF del procesador DLX32p
	CLK => clk, RESET => clr, -- entradas de sincronizacion de la etapa
	EIF1 => MUX_PC, -- multiplexor que alimenta al PC. Viene del registro ID/EX
	EIF6 => ALU_out_int, -- direccion destino de una instruccion de salto, la cual viene de la ALU en la etapa EX
	SIF1 => NPC, SIF2 => addr_Pmem  -- Salidas PC+4 y PC. Esta ultima se utiliza para acceder a la memoria de programas
    );

ena_IF_ID <= '1'; -- por ahora se habilita siempre. Puede ser utilizado para introducir burbujas

process(clk,clr,NPC,instruction) -- Registro de segmentacion IF/ID, 65 bits
begin
  if (clr='0') then
	reg_IF_ID <= (others=>'0');
  elsif (CLK='1' and CLK'event) then
        if (ena_IF_ID='1') then
	    reg_IF_ID(31 downto 0) <= NPC; -- Guarda el PC+4
	    reg_IF_ID(63 downto 32) <= instruction; -- Guarda la salida de la memoria de programa    
	    reg_IF_ID(64) <= '1'; -- senal que indica que se transmite instruccion. Necesario para cuando entra la primera instruccion del programa	    
	end if;
  end if;
end process;


clr_idp <= clr and reg_IF_ID(64); -- habilita la etapa ID cuando llega la primera instruccion a la etapa

u2: idp port map( -- Etapa ID del procesador DLX32p
	clr => clr_idp, clock => n_clk, -- estas senyales van directamente al banco registros
	NextPC => reg_IF_ID(31 downto 0), -- PC+4 leido desde registro segmentacion IF/ID
	instruccion => reg_IF_ID(63 downto 32), -- instruccion leida desde memoria de programa 
	Data_W => dataW_int, -- dato a escribir en banco de registros en puerto W
	ALU_control => controlALU, -- palabra control ALU
	b_dir_W => dir_W, -- direccion de registro de escritura que viene de la etapa WB
	WE_b32x32_ext => WE_b32x32, -- senyal de habilitacion de escritura en banco de registros que viene desde etapa WB
	control_word=>control, Data_A=>dataRS, Data_B=>dataRT, inmediato=>INM, NextPC_out => NPCout -- palabra de control, puerto A y B del banco de registros,inmediato, PC+4
    );

mux_rt_rd <= control(8); -- senyal que selecciona al campo de la instruccion rt/rs2 o rd como puerto de escritura en banco de registros
dir_rt_rd <= reg_IF_ID(47 downto 43) when (mux_rt_rd='1') else reg_IF_ID(52 downto 48); -- salida del multiplexor que indica la direccin del registro de escritura

control_ID_EX <= control(8 downto 0); -- Palabra de control que se transmite a la etapa EX desde la etapa ID: MUX_rt_rd & MUX_PC & WE_b32x32 & MUX_ALU_A & MUX_ALU_B & WE_mem & MUX_wb & beq & j

BR_A <= dataRS; -- senales del Banco de registros que se visualizan en simulacion
BR_B <= dataRT; 
BR_W <= dataW_int;
BR_WE <= WE_b32x32; 

ena_ID_EX <= '1'; -- por ahora se habilita siempre

process(clk,clr,NPCout,INM,control_ID_EX,controlALU,dir_rt_rd,reg_IF_ID) -- Registro de segmentacion ID/EX
begin
  if (clr='0' or reg_IF_ID(64)='0') then
	reg_ID_EX <= (others=>'0');
  elsif (clk='1' and clk'event) then
        if (ena_ID_EX='1') then
	    reg_ID_EX(31 downto 0) <= NPCout; -- PC+4
	    reg_ID_EX(63 downto 32) <= INM; -- inmediato de 32 bits	
	    reg_ID_EX(72 downto 64) <= control_ID_EX; -- senales de control del procesador que se utilizan en las etapas EX, MEM y WB  
	    reg_ID_EX(78 downto 73) <= controlALU; -- senyales de control de la ALU
	    reg_ID_EX(83 downto 79) <= dir_rt_rd; -- direccion de registro de escritura en banco de registros
	    reg_ID_EX(84) <= reg_IF_ID(64); -- senyal que indica que se transmite instruccion
	    reg_ID_EX(116 downto 85) <= dataRS; -- data_A leido del puerto A del banco de registros
	    reg_ID_EX(148 downto 117) <= dataRT; -- data_B leido del puerto B del banco de registros
	end if;
  end if;
end process;

MUX_ALU_B <= reg_ID_EX(68); -- control(4), Senyal de control que sale del registro ID/EX
MUX_ALU_A <= reg_ID_EX(69); -- control(5), Senyal de control que sale del registro ID/EX
MUX_PC <= reg_ID_EX(71); -- control(7), Senyal de control que va a la etapa IF (al multiplexor del PC)

u3: ex port map( -- Etapa EX del procesador DLX32p
    	MUX_A_control=>MUX_ALU_A, MUX_B_control=>MUX_ALU_B, -- control de multiplexores de la ALU
        ALU_control => reg_ID_EX(78 downto 73), -- palabra de control de la ALU
        NextPC => reg_ID_EX(31 downto 0), -- PC+4 
        Data_A => reg_ID_EX(116 downto 85), -- dato puerto A del banco de registros 
        Data_B => reg_ID_EX(148 downto 117), -- dato puerto B del banco de registros 
        Inm => reg_ID_EX(63 downto 32), -- inmediato
        ALU_out => ALU_out_int );  -- salida de la ALU 

ena_EX_MEM <= '1'; -- por ahora se habilita siempre
control_EX_MEM <= reg_ID_EX(70) & reg_ID_EX(67) & reg_ID_EX(66); -- Palabra de control que se transmite a la etapa MEM desde la etapa EX: control_EX_MEM <= WE_b32x32 & WE_mem & MUX_wb
dir_rt_rd_EX_MEM <= reg_ID_EX(83 downto 79); -- direccion de escritura en banco de registros que pasa desde registros ID/EX a EX/MEM

process(clk,clr,ALU_out_int,dataRT,control_EX_MEM,dir_rt_rd_EX_MEM,reg_ID_EX) -- Registro de segmentacion EX/MEM
begin
  if (clr='0' or reg_ID_EX(84)='0') then
	reg_EX_MEM <= (others=>'0');
  elsif (clk='1' and clk'event) then
        if (ena_EX_MEM='1') then
	    reg_EX_MEM(31 downto 0) <= ALU_out_int; -- Salida de la ALU
	    reg_EX_MEM(63 downto 32) <= reg_ID_EX(148 downto 117); -- dataRT. Dato leido del Puerto B del banco de registros 
	    reg_EX_MEM(66 downto 64) <= control_EX_MEM; -- senayles de control: WE_b32x32 & WE_mem & MUX_wb 
	    reg_EX_MEM(71 downto 67) <= dir_rt_rd_EX_MEM; -- direccion de registro de escritura en banco
	    reg_EX_MEM(72) <= reg_ID_EX(84); -- senyal que indica que se transmite instruccion
	end if;
  end if;
end process;

data_out_Dmem <= reg_EX_MEM(63 downto 32); -- dato a escribir en la memoria de datos
addr_Dmem <= reg_EX_MEM(31 downto 0); -- direccin de la memoria de datos
we_Dmem <= reg_EX_MEM(65); -- habilitaicion de escritura en la memoria de datos
control_MEM_WB <= reg_EX_MEM(66) & reg_EX_MEM(64); -- Palabra de control que se transmite a la etapa WB desde la etapa MEM: WE_b32x32 & MUX_wb
ena_MEM_WB <= '1'; -- por ahora se habilita siempre
dir_rt_rd_MEM_WB <= reg_EX_MEM(71 downto 67); -- direccion de escritura en banco de registros que pasa desde registros EX/MEM a MEM/WB

process(clk,clr,data_in_Dmem,control_MEM_WB,dir_rt_rd_MEM_WB,reg_EX_MEM) -- Registro de segmentacion MEM/WB
begin
  if (clr='0' or reg_EX_MEM(72)='0') then
	reg_MEM_WB <= (others=>'0');
  elsif (clk='1' and clk'event) then
        if (ena_MEM_WB='1') then
	    reg_MEM_WB(31 downto 0) <= data_in_Dmem; -- Salida de la memoria de datos que se introduce en el procesador
	    reg_MEM_WB(36 downto 32) <= dir_rt_rd_MEM_WB; -- direccion de escritura en banco de registros
	    reg_MEM_WB(38 downto 37) <= control_MEM_WB; -- senales de control: WE_b32x32 & MUX_wb
	    reg_MEM_WB(70 downto 39) <= reg_EX_MEM(31 downto 0); -- Salida de la ALU
	    reg_MEM_WB(71) <= reg_EX_MEM(72); -- senyal que indica que se transmite instruccion
	end if;
  end if;
end process;

MUX_wb <= reg_MEM_WB(37); -- senyal de control que va a etapa WB
WE_b32x32 <= reg_MEM_WB(38); --senyal de control que va a etapa ID
dir_W <= reg_MEM_WB(36 downto 32); -- direccion del puerto de escritura en banco registros

u4: wb port map( -- Etapa WB del procesador DLX32p
        data_mem => reg_MEM_WB(31 downto 0), -- entrada desde la memoria de datos
        data_ALU => reg_MEM_WB(70 downto 39), -- salida de la ALU
        mux_wb => MUX_wb, -- control del multiplexor de esta etapa
        data_WB => dataW_int -- dato que se escribe en el banco de registros en el puerto W
    );

end DLX32s_arch;
