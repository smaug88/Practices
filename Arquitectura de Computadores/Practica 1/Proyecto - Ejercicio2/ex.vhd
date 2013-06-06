-- ARQUITECTURA DE COMPUTADORES - ULPGC
--
-- EX.VHD
--
-- Etapa de ejecucion de la instruccion de DLX32P
--
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use work.dlx_pack.all;

entity ex is
    port (
    	MUX_A_control,MUX_B_control: in STD_LOGIC; -- bit de control de los multiplexores de entrada a la ALU: MUX_ALU_A y MUX_ALU_B
        ALU_control: in STD_LOGIC_VECTOR (5 downto 0); -- palabra de control de la ALU
        NextPC,Data_A,Data_B,Inm: in STD_LOGIC_VECTOR (31 downto 0); -- NextPC=PC+4, Data_A,Data_B= datos desde banco de registros, Inm= valore inmediato de 32 bits
        ALU_out: out STD_LOGIC_VECTOR (31 downto 0) -- ALUout= salida de la ALU
    );
end ex;

architecture ex_arch of ex is
begin -- empieza la arquitectura

process(ALU_control,Data_A,Data_B,NextPC,Inm,MUX_A_control,MUX_B_control)

variable index, v2: integer;
variable MUX_A_out, MUX_B_out, v5, iALU_out: SIGNED(31 DOWNTO 0); -- v1, v3, v4
variable COUNT,dummy1,dummy2: unsigned(31 downto 0);

begin

case MUX_A_control is -- multiplexor para la entrada A de la ALU
	when '1' => MUX_A_out := MVL_TO_SIGNED(Data_A); -- dato desde banco desde banco de registros
	when others => MUX_A_out := MVL_TO_SIGNED(NextPC); -- PC+4
end case;

case MUX_B_control is -- multiplexor para la entrada B de la ALU
	when '0' => MUX_B_out := MVL_TO_SIGNED(Data_B); -- dato desde banco desde banco de registros
	when others => MUX_B_out := MVL_TO_SIGNED(Inm); -- valor inmediato de 32 bits
end case;

case ALU_control is
	when cAluFunc_add => iALU_out := MUX_A_out + MUX_B_out; -- operacion de instruccion ADD
	when cAluFunc_undef_01 => iALU_out := MUX_B_out; -- desde bloque inmediato sale la direccion de salto INCONDICIONAL
	when cAluFunc_sub => iALU_out := MUX_A_out - MUX_B_out; -- operacion de instruccion SUB
	when cAluFunc_and => -- operacion de AND logica
             for index in 31 downto 0 loop
                 v5(index) := MUX_A_out(index) and MUX_B_out(index);
             end loop;
	     iALU_out := v5;   	
	when cAluFunc_or => -- operacion de OR logica
             for index in 31 downto 0 loop
                 v5(index) := MUX_A_out(index) or MUX_B_out(index);
             end loop;
	     iALU_out := v5;   	
	when cAluFunc_sra => -- operacion de desplazamiento aritmetico a la derecha
	     COUNT := CONV_UNSIGNED(MUX_B_out,32);
	     iALU_out := SHR(MUX_A_out,COUNT); -- SHR funcion XILINX, desplazamiento aritmetico, replica signo
	when cAluFunc_sll => -- operacion de desplazamiento logico a la izquierda
	     COUNT := CONV_UNSIGNED(MUX_B_out,32);
	     dummy1 := CONV_UNSIGNED(MUX_A_out,32);
	     dummy2 := SHL(dummy1,COUNT); -- SHL funcion XILINX
	     iALU_out := CONV_SIGNED(dummy2,32);
	when others =>  iALU_out := CONV_SIGNED(0,32); 
end case;

ALU_out <= CONV_STD_LOGIC_VECTOR(iALU_out,32); -- salida del resultado de la ALU

end process;

end ex_arch;
