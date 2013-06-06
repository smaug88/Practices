-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- main32p.vhd
--
-- Fichero de mas alto nivel del Sistema Computador que se utiliza para probar la ejecucion de programas MIPS con el procesador DLX32p
-- Dispone de 3 componentes: procesador "DLX32p", memoria de programa "ROM_32x8", y memoria de datos "MEM".
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.dlx_pack.all;
use work.dlx_prog2.all; -- donde se encuentra el programa en codigo maquina

entity main32p is
    port (
        clk: 		in STD_LOGIC;
        clr: 		in STD_LOGIC;
        PC: 		out STD_LOGIC_VECTOR (31 downto 0);
        instruccion: 	out STD_LOGIC_VECTOR (31 downto 0);
        data_out_Rt: 	out STD_LOGIC_VECTOR (31 downto 0);
        ALU_out: 	out STD_LOGIC_VECTOR (31 downto 0);
        BR_A,BR_B,BR_W: out STD_LOGIC_VECTOR (31 downto 0);
        BR_WE: 		out STD_LOGIC
    );
end main32p;

architecture main32s_arch of main32p is

component DLX32p is -- modulo del procesador DLX32p
    port (
        clk: in STD_LOGIC; -- seal de reloj de todo el sistema computador
        clr: in STD_LOGIC; -- reset del sistema computador
        addr_Pmem: out STD_LOGIC_VECTOR (31 downto 0); -- direccion memoria programa
        instruction: in STD_LOGIC_VECTOR (31 downto 0); -- dato de la memoria programa
        addr_Dmem: out STD_LOGIC_VECTOR (31 downto 0); -- direccion memoria datos
        data_out_Dmem: out STD_LOGIC_VECTOR (31 downto 0); -- dato escrito en memoria datos
        data_in_Dmem: in STD_LOGIC_VECTOR (31 downto 0); -- dato leido desde memoria datos
        we_Dmem: out STD_LOGIC; -- habilitacion escritura en memoria de datos
        BR_A,BR_B,BR_W: out STD_LOGIC_VECTOR (31 downto 0); -- datos leidos y escritos en el banco de registros
        BR_WE: out STD_LOGIC -- habilitacion de escritura en el banco de registros
	); 
end component ;

component ROM_32x8 -- memoria de programa
port(
	ADDR: in ROM_RANGE; 
        DATA: out ROM_WORD);
end component ;

component MEM -- memoria de datos
port (
	ADDRESS: in STD_LOGIC_VECTOR (4 downto 0); 
	DATA_IN: in STD_LOGIC_VECTOR (31 downto 0); 
	DATA_OUT: out STD_LOGIC_VECTOR (31 downto 0); 
	WE,CLK : in STD_LOGIC ); 
end component ; 

-- VARIABLES GLOBALES
signal addr_Pmem,ins,addr_Dmem,data_in,data_out,ALU_out_int: std_logic_vector(31 downto 0);
signal addr: signed(31 downto 0);
signal addr1: ROM_RANGE;
signal we, n_clk: std_logic;

begin -- empieza a describirse la arquitectura

n_clk <= not(clk); -- la seal de reloj se INVIERTE

u1: DLX32p port map (
        clk => clk,
        clr => clr,
        addr_Pmem => addr_Pmem, -- direccion memoria programa
        instruction => ins, -- se introduce la instruccion en la memoria programa
        addr_Dmem => addr_Dmem, -- se envia la direccion a la memoria de datos
        data_out_Dmem => data_out, -- se envia el dato a la memoria datos
        data_in_Dmem => data_in, -- se recibe el dato leido desde memoria datos
        we_Dmem => we, -- habilitacion escritura de la memoria de datos
        BR_A => BR_A,
        BR_B => BR_B,
        BR_W => BR_W, -- datos de las salidas A y B y entrada W del banco de registros
        BR_WE => BR_WE -- senyal habilitacion del banco de registros

);

instruccion <= ins;
PC <= addr_Pmem;
addr <= MVL_TO_SIGNED('0'&'0'& addr_Pmem(31 downto 2)); -- transformamos direccion para acceder a "dlx_prog2.vhd"
addr1 <= conv_integer(addr);
ALU_out <= addr_Dmem;
data_out_Rt <= data_out;

u2: ROM_32x8 port map (
	ADDR => addr1, -- por donde se recibe la direccion de la instruccion
       	DATA => ins -- por donde se obtiene la instruccion
);

u3: MEM port map ( -- La memoria de datos dispone de 32 entradas de 4 bytes cada una de ellas. Es decir, cada entrada abarca 4 direcciones consecutivas de memoria
	ADDRESS => addr_Dmem(6 downto 2), -- por donde se recibe la direccion del dato en la memoria de datos. El dato es de 4 bytes. Por eso se empieza a direccionar desde el bit 2
	DATA_IN => data_out, -- por donde se recibe el dato a escribir desde el procesador
	DATA_OUT => data_in, -- por donde se envia el dato a leer por el procesador
	WE => we ,CLK => n_clk -- senyales de sincronismo 
);

end main32s_arch;
