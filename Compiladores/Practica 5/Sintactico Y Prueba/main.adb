--Cláusula de contexto
with Text_Io, Ada.Strings, Ada.Strings.Fixed;
use Text_Io, Ada.Strings, Ada.Strings.Fixed;


------------------------ COMENTARIOS ------------------------
-- Por ahora el analizador tan solo examina los            --
-- caracteres y cuando muestra por pantalla la palabra     --
-- las palabras reservadas, sin comprobar el siguiente     --
-- caracter tras la palabra. Reconoce las 11 palabras.     --
-- 						           						   --
-- El warning que aparece al compilar es normal, es        --
-- porque por ahora el procedure lexico no devuelve nada.  --
-- 						           						   --
-- 						           						   --
-------------------------------------------------------------

-------------------------------- CAMBIOS --------------------------------
--24/04 16:05 -> Se han incluido excepciones                           --
--26/04 -> -Incluidos operadores binarios y unarios y separadores      --
--	   -Incluida variable Revisar_char para cuando se dan	           --
--	    oper. dobles u operadores compuestos de 2 (==, !=, etc)		   --
--	   -Incluido el espacio,que no hace nada | error si no esta		   --
--27/04 -> -Incluidos los registros R0..R7                             --
--	   -Incluidos los numeros enteros                              	   --
--	   -Modificado el inicio del programa, main llama a sigchar        --
--	   -Incluidos tokens que aparecen al final GCC                     --
--30/04 -> - Añadido hexadecimales y octales, número 0		           --
--	   - Bucle externo al léxico, no interno		                   --
--	   - Limpieza de espacios, comentarios, saltos de línea	           --
-- 	   - Cambio de Revisar_char por sigchar()                          --
-- 1/05 -> - Añadido de tipo con palabras reservadas		           --
--	   - Comprobado general de funcionamiento		                   --
--	   - Números reales (no esta terminado)			                   --
-------------------------------------------------------------------------

--Para comprobar si el sig caracter es el EOL, puesto que
--get solo devuelve caracteres validos tendremos que usar
--la funcion look_ahead(Fichero,c,EOL);

procedure main is --Elemento de librería (subprograma)
	Fichero : Text_Io.File_Type;
	c: Character;
	error: Integer;

	type Token is (INICIO, FIN, STAT, CODE, MEM, FIL, DAT, STR, L, SI,
				   GT, E, S, F, D, I, P, U, J, REG_INT, REG_FLOAT,
				   BARRA, DOBLE_BARRA, BARRA_ASTERISCO, MENOR,
				   MENOR_MENOR, MENOR_IGUAL, MAYOR, MAYOR_MAYOR,
				   MAYOR_IGUAL, ASIGNACION, IGUAL_IGUAL, ASTERISCO,
				   ASTERISCO_BARRA, AMPERSAND, AMPERSAND_AMPERSAND,
				   BARRAVERT, BARRAVERT_BARRAVERT, EXCLAMACION,
				   DISTINTO, ABRE_PARENTESIS, CIERRA_PARENTESIS, COMA,
				   PUNTO_COMA, DOS_PUNTOS, MAS, MENOS, PORCENTAJE, 				     
				   CIRCUNFLEJO, ENE, POSITIVE, FLOTANTE, CHAR, RISTRA, DEFECTO);

	res: Token;

    procedure sigchar(caracter: in out Character) is
    begin
        if(Is_Open(Fichero)) then
			if(End_Of_File(Fichero)) then
				caracter:= Character'Val(0);
			else
				get(Fichero,caracter);
			end if;
		end if;
    end sigchar;
	
	procedure caracEspeciales (caracter: in Character; ok: out Integer) is
	   
	begin
		ok:= 1;
		if (c = '\') then
			sigchar(c);
			if (c='0' or c='1' or c='2' or c='3' or c='4' 
					  or c='5' or c='6' or c='7') then
				sigchar(c);
				if (c='0' or c='1' or c='2' or c='3' or c='4' 
						  or c='5' or c='6' or c='7') then
					sigchar(c);
					if (c='0' or c='1' or c='2' or c='3' or c='4' 
							  or c='5' or c='6' or c='7') then
						sigchar(c); 
					else
						ok := 0;
					end if;
				else
					ok := 0;
				end if;
			 elsif (c = 'x') then
				sigchar(c);
				if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
						  or c='6' or c='7' or c='8' or c='9' or c='a' or c='A'
						  or c='b' or c='B' or c='c' or c='C' or c='d' or c='D'
						  or c='e' or c='E' or c='f' or c='F') then
					sigchar(c);
					if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							  or c='6' or c='7' or c='8' or c='9' or c='a' or c='A'
							  or c='b' or c='B' or c='c' or c='C' or c='d' or c='D'
							  or c='e' or c='E' or c='f' or c='F') then
						sigchar(c);
					else 
						ok := 0;
					end if;
				else
					ok := 0;
				end if;
			elsif (c = 'n') then
				sigchar(c);
			elsif (c = 't') then
				sigchar(c);
			else 
				ok := 0;
			end if;
		elsif (c = '.') then
			sigchar(c);
			if (c = '.') then
				sigchar(c);
			else
				ok := 0;
			end if;
		end if;
	end caracEspeciales;
	
	procedure valido(caracter: in Character; ok: out Integer) is
    begin
        ok := 1;
        
        case caracter is
        -- Letras en minuscula
	    when 'a' => ok := 1;
	    when 'b' => ok := 1;
	    when 'c' => ok := 1;
	    when 'd' => ok := 1;
	    when 'e' => ok := 1;
	    when 'f' => ok := 1;
	    when 'g' => ok := 1;
	    when 'h' => ok := 1;
	    when 'i' => ok := 1;
	    when 'j' => ok := 1;
	    when 'k' => ok := 1;
	    when 'l' => ok := 1;
	    when 'm' => ok := 1;
	    when 'n' => ok := 1;
	    when 'o' => ok := 1;
	    when 'p' => ok := 1;
	    when 'q' => ok := 1;
	    when 'r' => ok := 1;
	    when 's' => ok := 1;
	    when 't' => ok := 1;
	    when 'u' => ok := 1;
	    when 'v' => ok := 1;
	    when 'w' => ok := 1;
	    when 'x' => ok := 1;
	    when 'y' => ok := 1;
	    when 'z' => ok := 1;
        -- Letras en mayuscula
	    when 'A' => ok := 1;
	    when 'B' => ok := 1;
	    when 'C' => ok := 1;
	    when 'D' => ok := 1;
	    when 'E' => ok := 1;
	    when 'F' => ok := 1;
	    when 'G' => ok := 1;
	    when 'H' => ok := 1;
	    when 'I' => ok := 1;
	    when 'J' => ok := 1;
	    when 'K' => ok := 1;
	    when 'L' => ok := 1;
	    when 'M' => ok := 1;
	    when 'N' => ok := 1;
	    when 'O' => ok := 1;
	    when 'P' => ok := 1;
	    when 'Q' => ok := 1;
	    when 'R' => ok := 1;
	    when 'S' => ok := 1;
	    when 'T' => ok := 1;
	    when 'U' => ok := 1;
	    when 'V' => ok := 1;
	    when 'W' => ok := 1;
	    when 'X' => ok := 1;
	    when 'Y' => ok := 1;
	    when 'Z' => ok := 1;
        -- Numeros
	    when '0' => ok := 1;
	    when '1' => ok := 1;
	    when '2' => ok := 1;
	    when '3' => ok := 1;
	    when '4' => ok := 1;
	    when '5' => ok := 1;
	    when '6' => ok := 1;
	    when '7' => ok := 1;
	    when '8' => ok := 1;
	    when '9' => ok := 1;
        -- Simbolos raros
	    when ':' => ok := 1;
	    when ';' => ok := 1;
	    when '=' => ok := 1;
	    when '<' => ok := 1;
	    when '>' => ok := 1;
	    when '(' => ok := 1;
	    when ')' => ok := 1;
	    when '+' => ok := 1;
	    when '-' => ok := 1;
	    when '*' => ok := 1;
	    when '&' => ok := 1;
	    when '%' => ok := 1;
	    when '|' => ok := 1;
	    when '!' => ok := 1;
	    when '~' => ok := 1;
	    when ''' => ok := 1;
	    when '"' => ok := 1;
	    when '.' => ok := 1;
	    when '^' => ok := 1;
	    when ',' => ok := 1;
	    when '/' => ok := 1;
	    when ' ' => ok := 1;
        -- Los no validos
	    when others => ok := 0;
        end case;
    end valido;


    procedure lexico (caracter: in Character; salida: out Token; error: out Integer) is
		Error_Begin, Error_End, Error_Stat, Error_Str, Error_Code, Error_Registro,
		Error_Registro_Float, Error_Mem, Error_Fil, Error_Dat, Error_L, Error_If,
		Error_Gt, Error_Hex, Error_Float, error_Char, Error_ristra: exception;
		ok: Integer;
    begin

		c := caracter;
		error := 0;
		salida := DEFECTO;
		-- Limpieza de espacios, comentarios, saltos de línea
		ok := 0;
		while (ok /= 1) loop
			-- Ignoramos comentarios de linea
			if (c ='#') then
				Skip_line(Fichero);
				sigchar(c);
				if (c = Character'Val(0)) then
					error := -1;
					return;
				end if;
			elsif(c = '/') then
				sigchar(c);
				if(c = '/') then
					Skip_line(Fichero);
					sigchar(c);
					if (c = Character'Val(0)) then
						error := -1;
						return;
					end if;
				elsif (c = '*') then
					sigchar(c);
                    while (c /= '/') loop   
						while (c /= '*') loop
							if (c = Character'Val(0)) then
								error := -1;
								return;
							else
								error := -4;
							end if;
							sigchar(c);
						end loop;
					
						if (c = Character'Val(0)) then
							error := -1;
							return;
						else
							error := -4;
						end if;
					
						sigchar(c);
					end loop;
				
				else
					salida := BARRA;
                    return;
				end if;
                        
				-- Vacio == Final de fichero
			elsif (c = Character'Val(0)) then
				error := -1;
				return;
			-- Ignoramos espacios
			elsif (c = ' ') then
				sigchar(c);
			-- Ignoramos tabulaciones
			elsif (c = Character'Val(9)) then
				sigchar(c);
			else
				ok := 1;
			end if;
		end loop;

		--Token BEGIN
		if(c = 'B') then
			sigchar(c);
			if(c = 'E') then
				sigchar(c);
				if(c = 'G') then
					sigchar(c);
					if(c = 'I') then
						sigchar(c);
						if(c = 'N') then
							salida := INICIO;
							sigchar(c);
						else
							raise Error_Begin;
						end if;
					else
						raise Error_Begin;
					end if;
				else
					raise Error_Begin;
				end if;
			else
				raise Error_Begin;
			end if;

		--Token END
		elsif(c = 'E') then
			sigchar(c);
			if(c = 'N') then
				sigchar(c);
				if(c = 'D') then
					salida := FIN;
					sigchar(c);
				else
					raise Error_End;
				end if;
			else
				salida := MEM;
			end if;
		
		--Token STAT y S
		elsif (c = 'S') then
			sigchar(c);        
			if(c = 'T') then
				sigchar(c);
				if(c = 'A') then
					sigchar(c);
					if(c = 'T') then
						salida := STAT;
						sigchar(c);
					else
						raise Error_Stat;
					end if;
					--Token STR
				elsif (c = 'R') then
					salida := STR;
					sigchar(c);
				else
					raise Error_Stat;
				end if;
			else
				salida := MEM;
			end if;

		--Token CODE
		elsif(c = 'C') then
			sigchar(c);
			if(c = 'O') then
				sigchar(c);
				if(c = 'D') then
					sigchar(c);
					if(c = 'E') then
						salida := CODE;
						sigchar(c);
					else
						raise Error_Code;
					end if;
				else
					raise Error_Code;
				end if;
			else
				raise Error_Code;	
			end if;

		--Token MEM
		elsif (c = 'M') then
			sigchar(c);
			if(c = 'E') then
				sigchar(c);
				if(c = 'M') then
					salida := MEM;
					sigchar(c);
				else
					raise Error_Mem;
				end if;
			else
				raise Error_Mem;
			end if;

		--Token FIL y F
		elsif (c = 'F') then
			sigchar(c);
			if(c = 'I') then
				sigchar(c);
				if(c = 'L') then
					salida := FIL;
					sigchar(c);
				else
					raise Error_Fil;
				end if;
			else
				salida := MEM;
			end if;

		--Token DAT y D
		elsif (c = 'D') then
			sigchar(c);
			if(c = 'A') then
				sigchar(c);
				if(c = 'T') then
					salida := DAT;
					sigchar(c);
				else
					raise Error_Dat;
				end if;
			else
				salida := MEM;
			end if;

		--Token L
		elsif (c = 'L') then
			salida := L;
			sigchar(c);

		--Token IF
		elsif (c = 'I') then
			sigchar(c);
			if(c = 'F') then
				salida := SI;
				sigchar(c);
			else
				salida := MEM;
			end if;

		--Token GT
		elsif(c = 'G') then
			sigchar(c);
			if(c = 'T') then
				salida := GT;
				sigchar(c);
			else
				raise Error_GT;
			end if;

		--Token P
		elsif(c ='P') then
			salida := MEM;
			sigchar(c);

		--Token U
		elsif(c = 'U') then
			salida := MEM;
			sigchar(c);

		--Token J
		elsif(c = 'J') then
			salida := MEM;
			sigchar(c);

		--Registros
		elsif (c = 'R') then
			sigchar(c);
			if(c = '0' or c = '1' or c = '2' or c = '3' or c = '4'
			           or c = '5' or c = '6' or c = '7') then
				salida := REG_INT;
				sigchar(c);
			-- Registros flotante
			elsif (c = 'R') then
				sigchar(c);
				if(c = '0' or c = '1' or c = '2' or c = '3') then
					salida := REG_FLOAT;
					sigchar(c);
				else
					raise Error_Registro_Float;
				end if;
			else
				raise Error_Registro;
			end if;

		--Token << , < y <=
		elsif(c = '<') then
			sigchar(c);
			if(c = '<') then
				salida := MENOR_MENOR;
				sigchar(c);
			elsif (c = '=') then
				salida := MENOR_IGUAL;
				sigchar(c);
			else
				salida := MENOR;
			end if;

		--Token >> , > y >=
		elsif(c = '>') then
			sigchar(c);
			if(c = '>') then
				salida := MAYOR_MAYOR;
				sigchar(c);
			elsif (c = '=') then
				salida := MAYOR_IGUAL;
				sigchar(c);
			else
				salida := MAYOR;
			end if;

		--Token == y =
		elsif(c = '=') then
			sigchar(c);
			if(c = '=') then
				salida := IGUAL_IGUAL;
				sigchar(c);
			else
				salida := ASIGNACION;
			end if;

		--Token && y &
		elsif(c = '&') then
			sigchar(c);
			if(c = '&') then
				salida := AMPERSAND_AMPERSAND;
				sigchar(c);
			else
				salida := AMPERSAND;
			end if;

		--Token || y |
		elsif(c = '|') then
			sigchar(c);
			if(c = '|') then
				salida := BARRAVERT_BARRAVERT;
				sigchar(c);
			else
				salida := BARRAVERT;
			end if;

		--Token ! y !=
		elsif(c = '!') then
			sigchar(c);
			if(c = '=') then
				salida := DISTINTO;
				sigchar(c);
			else
				salida := EXCLAMACION;
			end if;

		--Token * 
		elsif(c = '*') then
			sigchar(c);
			salida := ASTERISCO;

		--Token (
		elsif(c = '(') then
			salida := ABRE_PARENTESIS;
			sigchar(c);

		--Token )
		elsif (c = ')') then
			salida := CIERRA_PARENTESIS;
			sigchar(c);

		--Token ;
		elsif(c = ',') then
			salida := COMA;
			sigchar(c);

		--Token ;
		elsif(c = ';') then
			salida := PUNTO_COMA;
			sigchar(c);

		--Token :
		elsif(c = ':') then
			salida := DOS_PUNTOS;
			sigchar(c);

		--Token +
		elsif(c = '+') then
			salida := MAS;
			sigchar(c);

		--Token -
		elsif(c = '-') then
			salida := MENOS;
			sigchar(c);

		--Token %
		elsif(c = '%') then
			salida := PORCENTAJE;
			sigchar(c);

		--Token ^
		elsif(c = '^') then
			salida := CIRCUNFLEJO;
			sigchar(c);

		--Token ~
		elsif(c = '~') then
			salida := ENE;
			sigchar(c);

		-- Token caracter
		elsif (c = ''') then
			sigchar(c);
			valido(c,ok);
			if (ok = 1) then
				sigchar(c);
				if (c = ''') then
					salida := CHAR;
					sigchar(c);
				else
					raise error_Char;
                end if;
            else 
				caracEspeciales(c, ok);
				if (ok = 1) then
					if (c = ''') then
						salida := CHAR;
						sigchar(c);
					else
						raise error_Char;
					end if;
				else
					raise error_Char;
				end if;
			end if;

		-- Token ristra
		elsif (c = '"') then
			sigchar(c);
            while (c /= Character'Val(0) and c /= '"') loop
				valido(c,ok);
				if (ok = 1) then
					sigchar(c);
				else 
					caracEspeciales(c, ok);
					if (ok /= 1) then
						raise error_Char;
					end if;
				end if;
			end loop;
			if (c = Character'Val(0)) then 
				raise Error_ristra;
			else
				salida := RISTRA;
				sigchar(c);
			end if;

		--Token de numeros enteros
		elsif(c='1' or c='2' or c='3' or c='4' or c='5'
		            or c='6' or c='7' or c='8' or c='9') then
			sigchar(c);
			while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
				         or c='6' or c='7' or c='8' or c='9') loop
				sigchar(c);
			end loop;
			-- Si hay un punto estamos leyendo un float
			if (c = '.') then
				sigchar(c);
				while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
				             or c='6' or c='7' or c='8' or c='9') loop
					sigchar(c);
				end loop;
				if (c='E' or c='e') then
					sigchar(c);
					if (c='+' or c='-') then
						sigchar(c);
					end if;
					if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
					          or c='6' or c='7' or c='8' or c='9') then
						sigchar(c);
						while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
						             or c='6' or c='7' or c='8' or c='9') loop    
							sigchar(c);
						end loop;
					else
						raise Error_Float;
					end if;
				end if;
				salida := FLOTANTE;
			-- Si encontramos un exponente también es un float
			elsif (c='e' or c='E') then
				sigchar(c);
				if (c='+' or c='-') then
					sigchar(c);
				end if;
				if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
						  or c='6' or c='7' or c='8' or c='9') then
					sigchar(c);
					while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
						         or c='6' or c='7' or c='8' or c='9') loop    
						sigchar(c);
					end loop;
				else
					raise Error_Float;
				end if;
				salida := FLOTANTE;
			-- Si no, hemos leido un entero
			else
				salida := POSITIVE;
			end if;

		-- Numero 0
		elsif (c='0') then
			sigchar(c);
			-- Comprobamos que sea octal
			if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
					  or c='6' or c='7') then
				sigchar(c);
				while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							 or c='6' or c='7') loop
					sigchar(c);
				end loop;

				-- Si encontramos 8, 9, ., e o E sera un float
				if (c='8' or c='9') then
					while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								 or c='6' or c='7' or c='8' or c='9') loop
						sigchar(c);
					end loop;
					if (c = '.') then
						sigchar(c);
						while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
									 or c='6' or c='7' or c='8' or c='9') loop
							sigchar(c);
						end loop;
						if (c='E' or c='e') then
							sigchar(c);
							if (c='+' or c='-') then
								sigchar(c);
							end if;
							if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
									  or c='6' or c='7' or c='8' or c='9') then
								sigchar(c);
								while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
											 or c='6' or c='7' or c='8' or c='9') loop    
									sigchar(c);
								end loop;
							else
								raise Error_Float;
							end if;
						end if;
						salida := FLOTANTE;
					elsif (c='e' or c='E') then
						sigchar(c);
						if (c='+' or c='-') then
							sigchar(c);
						end if;
						if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								  or c='6' or c='7' or c='8' or c='9') then
							sigchar(c);
							while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								         or c='6' or c='7' or c='8' or c='9') loop    
								sigchar(c);
							end loop;
						else
							raise Error_Float;
						end if;
						salida := FLOTANTE;
					end if;
			
				elsif (c = '.') then
					sigchar(c);
					while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								 or c='6' or c='7' or c='8' or c='9') loop
						sigchar(c);
					end loop;
					if (c='E' or c='e') then
						sigchar(c);
						if (c='+' or c='-') then
							sigchar(c);
						end if;
						if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								  or c='6' or c='7' or c='8' or c='9') then
							sigchar(c);
							while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
										 or c='6' or c='7' or c='8' or c='9') loop    
								sigchar(c);
							end loop;
						else
							raise Error_Float;
						end if;
					end if;
					salida := FLOTANTE;

				elsif (c='e' or c='E') then
					sigchar(c);
					if (c='+' or c='-') then
						sigchar(c);
					end if;
					if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
						      or c='6' or c='7' or c='8' or c='9') then
						sigchar(c);
						while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
									 or c='6' or c='7' or c='8' or c='9') loop    
							sigchar(c);
						end loop;
					else
						raise Error_Float;
					end if;
					salida := FLOTANTE;
				else
				-- Si no, es un octal
					salida := POSITIVE;
				end if;
			-- Comprobamos que sea hexadecimal
			elsif (c='x' or c='X') then
				sigchar(c);
				if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							 or c='6' or c='7' or c='8' or c='9' or c='a' or c='A'
							 or c='b' or c='B' or c='c' or c='C' or c='d' or c='D'
							 or c='e' or c='E' or c='f' or c='F') then
					sigchar(c);
					while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								 or c='6' or c='7' or c='8' or c='9' or c='a' or c='A'
								 or c='b' or c='B' or c='c' or c='C' or c='d' or c='D'
								 or c='e' or c='E' or c='f' or c='F') loop
						sigchar(c);
					end loop;
				else
					raise Error_Hex;
				end if;
				salida := POSITIVE;
			-- Si hay un 8 o un 9 estamos leyendo un float
			elsif (c='8' or c='9') then
			
				while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
						     or c='6' or c='7' or c='8' or c='9') loop
					sigchar(c);
				end loop;
				if (c = '.') then
					sigchar(c);
					while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								 or c='6' or c='7' or c='8' or c='9') loop
						sigchar(c);
					end loop;
					if (c='E' or c='e') then
						sigchar(c);
						if (c='+' or c='-') then
							sigchar(c);
						end if;
						if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							      or c='6' or c='7' or c='8' or c='9') then
							sigchar(c);
							while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
										 or c='6' or c='7' or c='8' or c='9') loop    
								sigchar(c);
							end loop;
						else
							raise Error_Float;
						end if;
					end if;
					salida := FLOTANTE;
				elsif (c='e' or c='E') then
					sigchar(c);
					if (c='+' or c='-') then
						sigchar(c);
					end if;
					if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							  or c='6' or c='7' or c='8' or c='9') then
						sigchar(c);
						while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
									 or c='6' or c='7' or c='8' or c='9') loop    
							sigchar(c);
						end loop;
					else
						raise Error_Float;
					end if;
					salida := FLOTANTE;
				end if;
			-- Si encontramos un exponente también es un float
			elsif (c='e' or c='E') then
				sigchar(c);
				if (c='+' or c='-') then
					sigchar(c);
				end if;
				if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
						  or c='6' or c='7' or c='8' or c='9') then
					sigchar(c);
					while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
								 or c='6' or c='7' or c='8' or c='9') loop    
						sigchar(c);
					end loop;
				else
					raise Error_Float;
				end if;
				salida := FLOTANTE;
			-- Si encontramos un punto también es un float
			elsif (c = '.') then
				sigchar(c);
				while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							 or c='6' or c='7' or c='8' or c='9') loop
					sigchar(c);
				end loop;
				if (c='E' or c='e') then
					sigchar(c);
					if (c='+' or c='-') then
						sigchar(c);
					end if;
					if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							  or c='6' or c='7' or c='8' or c='9') then
						sigchar(c);
						while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
									 or c='6' or c='7' or c='8' or c='9') loop    
							sigchar(c);
						end loop;
					else
						raise Error_Float;
					end if;
				end if;
				salida := FLOTANTE;

			else
				salida := POSITIVE;	-- Número 0
			end if;

		-- Si empieza por punto, es un flotante
		elsif (c = '.') then
			sigchar(c);
			if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
					  or c='6' or c='7' or c='8' or c='9') then
				sigchar(c);
				while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							 or c='6' or c='7' or c='8' or c='9') loop    
					sigchar(c);
				end loop;
				if (c='E' or c='e') then
					sigchar(c);
					if (c='+' or c='-') then
						sigchar(c);
					end if;
					if (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
							  or c='6' or c='7' or c='8' or c='9') then
						sigchar(c);
						while (c='0' or c='1' or c='2' or c='3' or c='4' or c='5'
									 or c='6' or c='7' or c='8' or c='9') loop    
							sigchar(c);
						end loop;
					else
						raise Error_Float;
					end if;
				end if;
				salida := FLOTANTE;
			else
				raise Error_Float;
			end if;

		------------------------------------------------------
		--Si el caracter no coincide con nada de lo anterior
		else
			Put("El caracter '");
			Put(c);
			Put("' no pertenece a ningun token permitido");
			sigchar(c);
			new_line;
			error := -2;
		end if;
	   
		exception
			when Error_Begin => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra BEGIN");
				new_line;
				sigchar(c);
				error := -3;
			when Error_End => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra END");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Stat => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra STAT");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Str => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra STR");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Code => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra CODE");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Mem => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra MEM");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Fil => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra FIL");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Dat =>
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra DAT");
				new_line;
				sigchar(c);
				error := -3;
			when Error_L => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra L");
				new_line;
				sigchar(c);
				error := -3;
			when Error_If => 
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra IF");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Gt =>
				Put("Error: El caracter '");
				Put(c);
				Put("' es incorrecto en la palabra GT");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Registro =>
				Put("Error: El registro 'R");
				Put(c);
				Put("' no existe");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Registro_Float =>
				Put("Error: El registro 'RR");
				Put(c);
				Put("' no existe");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Hex =>
				Put("Error: El número hexadecimal que contiene '");
				Put(c);
				Put("' está mal formado");
				new_line;
				sigchar(c);
				error := -3;
			when Error_Float =>
				Put("Error: El número en coma flotante que contiene '");
				Put(c);
				Put("' está mal formado");
				new_line;
				sigchar(c);
				error := -3;
			when error_Char =>
				Put ("Caracter invalido");
				new_line;
				sigchar(c);
				error := -3;
			when error_Ristra =>
				Put ("Ristra invalida");
				new_line;
				sigchar(c);
				error := -3;
			when END_ERROR => 
				if (salida = DEFECTO) then
					error := -1;
				else
					c := ' ';
					return;
				end if;

    end lexico;

    procedure PrintToken(t: in Token) is
    begin
		Put("Token: ");
		case t is
			when INICIO					=> Put("BEGIN");
			when FIN 					=> Put("END");
			when STAT					=> Put("STAT");
			when CODE					=> Put("CODE");
			when MEM					=> Put("MEM");
			when FIL					=> Put("FIL");
			when DAT					=> Put("DAT");
			when STR					=> Put("STR");
			when L						=> Put("L");
			when SI						=> Put("IF");
			when GT						=> Put("GT");
			--------- Sustituidos por MEM ----------
			when E						=> Put("E");
			when S						=> Put("S");
			when F						=> Put("F");
			when D						=> Put("D");
			when I						=> Put("I");
			when P						=> Put("P");
			when U						=> Put("U");
			when J						=> Put("J");
			----------------------------------------
			when REG_INT				=> Put("REG_INT");
			when REG_FLOAT				=> Put("REG_FLOAT");
			when BARRA					=> Put("/");
			when DOBLE_BARRA			=> Put("//");
			when BARRA_ASTERISCO		=> Put("/*");
			when MENOR					=> Put("<");
			when MENOR_MENOR			=> Put("<<");
			when MENOR_IGUAL			=> Put("<=");
			when MAYOR					=> Put(">");
			when MAYOR_MAYOR			=> Put(">>");
			when MAYOR_IGUAL			=> Put(">=");
			when ASIGNACION				=> Put("=");
			when IGUAL_IGUAL			=> Put("==");
			when ASTERISCO				=> Put("*");
			when ASTERISCO_BARRA		=> Put("*/");
			when AMPERSAND				=> Put("&");
			when AMPERSAND_AMPERSAND	=> Put("&&");
			when BARRAVERT				=> Put("|");
			when BARRAVERT_BARRAVERT	=> Put("||");
			when EXCLAMACION			=> Put("!");
			when DISTINTO				=> Put("!=");
			when ABRE_PARENTESIS		=> Put("(");
			when CIERRA_PARENTESIS		=> Put(")");
			when COMA					=> Put(",");
			when PUNTO_COMA				=> Put(";");
			when DOS_PUNTOS				=> Put(":");
			when MAS					=> Put("+");
			when MENOS					=> Put("-");
			when PORCENTAJE				=> Put("%");
			when CIRCUNFLEJO			=> Put("^");
			when ENE					=> Put("~");
			when POSITIVE				=> Put("POSITIVE");
			when FLOTANTE				=> Put("FLOAT");
			when CHAR					=> Put("CARACTER");
			when RISTRA					=> Put("RISTRA");
			when DEFECTO				=> Put("DEFECTO");
		end case;
		new_line;
    end PrintToken;
	
	-- Sintactico Byte
	procedure byte is
		Error_byte : exception;
	begin
		if (res = POSITIVE or res = char) then
			lexico(c, res,error);
		else
			raise Error_Byte;
		end if;

	exception
		when Error_Byte	=> Put_line("Error en Byte"); 
	end byte;
	
	-- Sintactico OperadorBinario
	procedure OperadorBinario is
		Error_OperadorBinario : exception;
	begin
		if ((res = MAS or res = MENOS or res = ASTERISCO or res = BARRA or res = PORCENTAJE 
			or res = AMPERSAND_AMPERSAND or res = BARRAVERT_BARRAVERT or res = MENOR
			or res = MENOR_IGUAL or res = MAYOR or res = MAYOR_IGUAL or res = MENOR_MENOR
			or res = MAYOR_MAYOR or res = IGUAL_IGUAL or res = DISTINTO or res = AMPERSAND
			or res = BARRAVERT or res = CIRCUNFLEJO) and error = 0) then
			lexico(c,res,error);
		else
			raise Error_OperadorBinario;
		end if;
		
		exception
			when Error_OperadorBinario =>
				Put_line("Operador binario no valido");

	end OperadorBinario;

	-- Sintactico OperadorUnario
	procedure OperadorUnario is
		Error_OperadorUnario : exception;
	begin
		if ((res = MAS or res = MENOS or res = EXCLAMACION or res = ENE) and error = 0) then
			lexico(c,res,error);
		else
			raise Error_OperadorUnario;
		end if;
		
		exception
			when Error_OperadorUnario =>
				Put_line("Operador unario no valido");

	end OperadorUnario;

	-- Sintactico Constante
	procedure Constante is 
		Error_Constante: exception;
	begin

        if (res = CHAR and error = 0) then
            lexico(c,res,error);
        else
            if ((res = MAS or res = MENOS)and error = 0) then
                lexico(c, res, error);
            end if;
            if ((res = POSITIVE or res = FLOTANTE) and error = 0) then
                lexico(c, res, error);
            else
                raise error_Constante;
            end if;
        end if;
	
	exception
		when Error_Constante => Put_line("Error en constante: Falta el valor");

	end Constante;
	
	-- Sintactico Registro
	procedure Registro is
		Error_Registro : exception;
	begin
		if ((res = REG_INT or res = REG_FLOAT) and error = 0) then
			lexico(c,res,error);
		else
			raise Error_Registro;
		end if;
		
		exception
			when Error_Registro =>
				Put_line("Registro no valido");

	end Registro;

	-- Sintactico Expresion
	procedure Expresion is
		Error_Expresion: exception;
	begin
		if ((res = REG_INT or res = REG_FLOAT) and error = 0) then
			Registro;
			if ((res /= CIERRA_PARENTESIS and res /= PUNTO_COMA) and error = 0) then
				--lexico(c, res, error);
				OperadorBinario;
				if ((res = REG_INT or res = REG_FLOAT) and error = 0) then
					Registro;
				else
					--PrintToken(RES);
					Constante;	
				end if;
			end if;
		elsif ((res = POSITIVE or res = FLOTANTE or res = CHAR) and error = 0) then
			Constante;
			if ((res /= CIERRA_PARENTESIS and res /= PUNTO_COMA) and error = 0) then
				--lexico(c, res, error);
				
				OperadorBinario;
				if ((res = REG_INT or res = REG_FLOAT) and error = 0) then
					Registro;
				else
					--PrintToken(RES);
					Constante;	
				end if;
			end if;
		elsif ((res = MAS or res = MENOS) and error = 0) then
			lexico(c, res, error);
			if ((res = POSITIVE or res = FLOTANTE) and error = 0) then
				lexico(c, res, error);
				if((res/= CIERRA_PARENTESIS and res /= PUNTO_COMA) and error = 0) then
					OperadorBinario;
					if ((res = REG_INT or res = REG_FLOAT) and error = 0) then
						Registro;
					else
						Constante;	
					end if;
					
				end if;
			elsif ((res = MAS or res = MENOS) and error = 0) then
				Constante;
			elsif ((res = REG_INT or res = REG_FLOAT) and error = 0) then
				Registro;
			else
				raise Error_Expresion;
			end if;
		else
			OperadorUnario;
			if ((res = REG_INT or res = REG_FLOAT) and error = 0) then
				Registro;
			else
				--PrintToken(RES);
				Constante;	
			end if;
		end if;
		
	exception
		when Error_Expresion =>
			Put_line("Expresion no valida");
			
	end Expresion;

	-- Sintactico SaltoIncondicional
	procedure SaltoIncondicional is
		Error_SaltoIncondicional, Error_SaltoIncondicional1, Error_SaltoIncondicional2, 
		Error_SaltoIncondicional3, Error_SaltoIncondicional4 : exception;
	begin
		if (res = GT and error = 0) then
			lexico(c,res,error);
			if (res = ABRE_PARENTESIS and error = 0) then
				lexico(c,res,error);
				--PrintToken(res);
				if ((res = POSITIVE or res = REG_INT) and error = 0) then
					lexico(c,res,error);
				elsif (res = MENOS and error = 0) then
					lexico(c,res,error);
					if (res = POSITIVE and error = 0) then
						lexico(c,res,error);
					else
						raise Error_SaltoIncondicional2;
					end if;
				else
					raise Error_SaltoIncondicional1;
				end if;
				if (res = CIERRA_PARENTESIS and error = 0) then
					lexico(c,res,error);
				else
					raise Error_SaltoIncondicional3;
				end if;
			else
				raise Error_SaltoIncondicional;
			end if;
		else
			raise Error_SaltoIncondicional4;
		end if;

		exception
			when Error_SaltoIncondicional =>
				Put_line("Error en el salto condicional: Falta el caracter '('");
			when Error_SaltoIncondicional1 =>
				Put_line("Error en el salto condicional: Falta el caracter '-'");
			when Error_SaltoIncondicional2 =>
				Put_line("Error en el salto condicional: Falta el POSITIVE");
			when Error_SaltoIncondicional3 =>
				Put_line("Error en el salto condicional: Falta el caracter ')'");
			when Error_SaltoIncondicional4 =>
				Put_line("Error en el salto condicional: Falta el GT");

	end SaltoIncondicional;

	-- Sintactico SaltoCondicional
	procedure SaltoCondicional is
		Error_SaltoCondicional, Error_SaltoCondicional1, Error_SaltoCondicional2 : exception;
	begin
		if (res = SI and error = 0) then
			lexico(c,res,error);
			if (res = ABRE_PARENTESIS and error = 0) then
				lexico(c,res,error);
				Expresion;
				if (res = CIERRA_PARENTESIS and error = 0) then
					lexico(c,res,error);
					SaltoIncondicional;
					
				else
					raise Error_SaltoCondicional1;
				end if;
			else
				raise Error_SaltoCondicional;
			end if;
		else
			raise Error_SaltoCondicional2;	
		end if;

		exception
			when Error_SaltoCondicional =>
				Put_line("Error en el salto condicional: Falta el caracter '('");
			when Error_SaltoCondicional1 =>
				Put_line("Error en el salto condicional: Falta el caracter ')'");
			when Error_SaltoCondicional2 =>
				Put_line("Error en el salto condicional: Falta el simbolo SI");
	end SaltoCondicional;

	-- Sintactico EstructuraControl
	procedure EstructuraControl is
		Error_EC : exception;
	begin
		if (res = SI and error = 0) then
			--lexico(c,res,error);
			SaltoCondicional;
		elsif (res = GT and error = 0) then
			SaltoIncondicional;
			else
			raise Error_EC;
		end if;
	exception
		when Error_EC => 
			Put_line("Error Estructura del Control");
	end EstructuraControl;

	-- Sintactico Asignacion
	procedure Asigna is
		Error_Asignacion, Error_Asignacion1, Error_Asignacion2,
		Error_Asignacion4, Error_Asignacion5, Error_Asignacion6 : exception;
	begin
		if (res = MEM and error = 0) then
			lexico(c,res,error);

			if (res = ABRE_PARENTESIS and error = 0) then
				lexico(c,res,error);
				Expresion;
				if (res = CIERRA_PARENTESIS and error = 0) then
					lexico(c,res,error);
					if (res = ASIGNACION and error = 0) then
						lexico(c,res,error);
						if ((res = REG_INT or res = REG_FLOAT)and error = 0) then
							Registro;
						else
							Constante;
						end if;
					else
						raise Error_Asignacion2;
					end if;
				else
					raise Error_Asignacion1;
				end if;
			else
				raise Error_Asignacion;
			end if;
		else
			Registro;
			if (res = ASIGNACION and error = 0) then
				lexico(c,res,error);
				if (res = MEM and error = 0) then
					lexico(c,res,error);
					if (res = ABRE_PARENTESIS and error = 0) then
						lexico(c,res,error);
						Expresion;
						--printToken(res);
						if (res = CIERRA_PARENTESIS and error = 0) then
							lexico(c,res,error);
						else
							raise Error_Asignacion6;
						end if;
					else
						raise Error_Asignacion5;
					end if;
				else
					Expresion;
				end if;
			else
				raise Error_Asignacion4;
			end if;
		end if;
		
		exception
			when Error_Asignacion =>
				Put_line("Error en la asignacion: Falta el caracter '('");
			when Error_Asignacion1 =>
				Put_line("Error en la asignacion: Falta el caracter ')'");
			when Error_Asignacion2 =>
				Put_line("Error en la asignacion: Falta el caracter de asignacion ':='");
			when Error_Asignacion4 =>
				Put_line("Error en la asignacion: Falta el caracter de asignacion ':='");
			when Error_Asignacion5 =>
				Put_line("Error en la asignacion: Falta el caracter '('");
			when Error_Asignacion6 =>
				Put_line("Error en la asignacion: Falta el caracter ')'");
		
	end Asigna;	

	-- Sintactico Declaracion
	procedure Declaracion is
		Error_Declaracion, Error_Declaracion1, Error_Declaracion2, Error_Declaracion3, Error_Declaracion4,
		Error_Declaracion5, Error_Declaracion6, Error_Declaracion7, Error_Declaracion8,Error_Declaracion10, Error_Declaracion11, 
		Error_Declaracion12 : exception;
	begin
        if(res=MEM and error = 0) then
            lexico(c, res, error);        
            if (res = ABRE_PARENTESIS and error = 0) then
			    lexico(c,res,error);
			    if (res = POSITIVE and error = 0) then
				    lexico(c,res,error);
				    if (res = COMA and error = 0) then
					    lexico(c,res,error);
                        if (res = POSITIVE and error = 0) then
							lexico(c,res,error);
						else
							raise Error_Declaracion3;
						end if;
                    else
					    raise Error_Declaracion2;
				    end if;
			    else
				    raise Error_Declaracion1;
			    end if;
		    else
			    raise Error_Declaracion;
		    end if;

        elsif (res=FIL and error = 0) then
            lexico(c, res, error);        
            if (res = ABRE_PARENTESIS and error = 0) then
			    lexico(c,res,error);
			    if (res = POSITIVE and error = 0) then
				    lexico(c,res,error);
				    if (res = COMA and error = 0) then
					    lexico(c,res,error);
                        if (res = POSITIVE and error = 0) then
							lexico(c,res,error);
							if (res = COMA and error = 0) then
								lexico(c,res,error);
								Byte;
							else
								raise Error_Declaracion5;
							end if;
						else
							raise Error_Declaracion4;
						end if;
                    else
					    raise Error_Declaracion2;
				    end if;
			    else
				    raise Error_Declaracion1;
			    end if;
		    else
			    raise Error_Declaracion;
		    end if;

        elsif (res=DAT and error = 0) then
            lexico(c, res, error);        
            if (res = ABRE_PARENTESIS and error = 0) then
			    lexico(c,res,error);
			    if (res = POSITIVE and error = 0) then
				    lexico(c,res,error);
				    if (res = COMA and error = 0) then
					    lexico(c,res,error);
                        if (res = MEM and error = 0) then
							lexico(c,res,error);
							if (res = COMA and error = 0) then
								lexico(c,res,error);
								-- Primeros de constante
								Constante;
							else
								raise Error_Declaracion8;
							end if;
						else
							raise Error_Declaracion7;
						end if;
                    else
					    raise Error_Declaracion2;
				    end if;
			    else
				    raise Error_Declaracion1;
			    end if;
		    else
			    raise Error_Declaracion;
		    end if;

        elsif (res= STR and error = 0) then
            lexico(c, res, error);        
            if (res = ABRE_PARENTESIS and error = 0) then
			    lexico(c,res,error);
			    if (res = POSITIVE and error = 0) then
				    lexico(c,res,error);
				    if (res = COMA and error = 0) then
					    lexico(c,res,error);
                        if (res = RISTRA and error = 0) then
							lexico(c,res,error);
						else
							raise Error_Declaracion10;
						end if;
                    else
					    raise Error_Declaracion2;
				    end if;
			    else
				    raise Error_Declaracion1;
			    end if;
		    else
			    raise Error_Declaracion;
		    end if;
        else
            raise Error_Declaracion6;
        end if;


	    if (res = CIERRA_PARENTESIS and error = 0) then
			lexico(c,res,error);
			if (res = PUNTO_COMA and error = 0) then
				lexico(c,res,error); -- :D
			else
				raise Error_Declaracion12;
			end if;
		else
			raise Error_Declaracion11;
		end if;

		exception
			when Error_Declaracion =>
				Put_line("Error en la declaracion: Falta el caracter '('");
			when Error_Declaracion1 =>
				Put_line("Error en la declaracion: Falta POSITIVE");
			when Error_Declaracion2 =>
				Put_line("Error en la declaracion: Falta el caracter ','");
			when Error_Declaracion3 =>
				Put_line("Error en la declaracion: Falta POSITIVE");
			when Error_Declaracion4 =>
				Put_line("Error en la declaracion: Falta POSITIVE");
			when Error_Declaracion5 =>
				Put_line("Error en la declaracion: Falta el caracter ','");
			when Error_Declaracion6 =>
				Put_line("Error en la declaracion: Falta el identificador");
			when Error_Declaracion7 =>
				Put_line("Error en la declaracion: Falta MEM");
			when Error_Declaracion8 =>
				Put_line("Error en la declaracion: Falta el caracter ','");
			when Error_Declaracion10 =>
				Put_line("Error en la declaracion: No es una ristra");
			when Error_Declaracion11 =>
				Put_line("Error en la declaracion: Falta el caracter ')'");
			when Error_Declaracion12 =>
				Put_line("Error en la declaracion: Falta el caracter ';'");
	end Declaracion;



	-- Sintactico Instruccion
	procedure Instruccion is
		Error_Instruccion, Error_Instruccion1: exception;
	begin
		if ((res = MEM or res = REG_INT or res = REG_FLOAT)and error = 0) then
			Asigna;
			
		elsif ((res = GT or res = SI)and error = 0) then
				EstructuraControl;
		else
			raise Error_Instruccion1;
		end if;
		if (res = PUNTO_COMA and error = 0) then
			lexico(c,res,error);
		else
			raise Error_Instruccion;
		end if;
	exception
		when Error_Instruccion => 
			Put_line("Error en la instruccion: Falta el caracter ';'");
		when Error_Instruccion1 => 
			Put_line("Error en la instruccion: El Token a la izquierda no es valido ");
	end Instruccion;

	-- Sintactico Etiqueta
	procedure Etiqueta is
		Error_Etiqueta, Error_Etiqueta1 : exception;
	begin
		if (res = L and error = 0) then
			lexico(c,res,error);
			if (res = POSITIVE and error = 0) then
				lexico(c,res,error);
				if (res = DOS_PUNTOS and error = 0) then
					lexico(c,res,error);
				else
					raise Error_Etiqueta1;
				end if;
			else
				raise Error_Etiqueta;
			end if;
		else
			raise Error_Etiqueta;
		end if;

		exception
			when Error_Etiqueta =>
				Put_line("Error en la etiqueta: falta el numero positivo");
			when Error_Etiqueta1 =>
				Put_line("Error en la etiqueta: Falta el caracter ':'");
	end Etiqueta;

	-- Sintactico Sentecia
	procedure Sentencia is
	begin
		case res is
			when L => 
				Etiqueta;
			when others =>
				Instruccion;
		end case;
	end Sentencia;

	-- Sintactico de Seg_Codigo
	procedure Seg_Codigo is
		Error_SegCodigo,Error_SegCodigo0, Error_SegCodigo1, Error_SegCodigo2 : exception;
	begin
		if (res = CODE and error = 0) then
			lexico(c,res,error);
			if (res = ABRE_PARENTESIS and error = 0) then
				lexico(c,res,error);
				if (res = POSITIVE and error = 0) then
					 lexico(c,res,error);
					if (res = CIERRA_PARENTESIS and error = 0) then
						lexico(c,res,error);
							while ((res = L or res = MEM or res = REG_INT or RES = REG_FLOAT 
											or res = SI or res = GT) and error = 0) loop
								Sentencia;
							end loop;
						else 
							raise Error_SegCodigo2;
					end if;
				else 
					raise Error_SegCodigo1;
				end if;
			else
				raise Error_SegCodigo;
			end if;
		else
			raise Error_SegCodigo0;
		end if;

	exception
		when Error_SegCodigo0 =>
			Put_line("Se esperaba un CODE y hay ");
		when Error_SegCodigo =>
			Put_line("Se esperaba un ( y hay ");
		when Error_SegCodigo1 =>
			Put_line("Se esperaba un NumPositivo y hay ");
		when Error_SegCodigo2 =>
			Put_line("Se esperaba un ) y hay ");
			
	end Seg_Codigo;

	-- Sintactico de Seg_Datos
	procedure Seg_Datos is
		Error_SegDatos, Error_SegDatos1, Error_SegDatos2, Error_SegDatos3 : exception;
	begin
		if (res = STAT and error = 0) then
			lexico (c, res, error);
			if (res = ABRE_PARENTESIS and error = 0) then
				lexico(c,res,error);
				if (res = POSITIVE and error = 0) then
					lexico(c,res,error);
					if (res = CIERRA_PARENTESIS and error = 0) then
						lexico(c,res,error);
						while ((res = MEM or res = FIL or res = STR or res = DAT) and error = 0) loop
                            Declaracion;
						end loop;
					else 
					    raise Error_SegDatos2;
					end if;
				else 
					raise Error_SegDatos1;
				end if;
			else
				raise Error_SegDatos;
			end if;
		else
			raise Error_SegDatos;
		end if;

	exception
		when Error_SegDatos =>
			Put_line("Error en segmento de datos: Se esperaba el caracter '('");
		when Error_SegDatos1 =>
			Put_line("Error en segmento de datos: Se esperaba un POSITIVE");
		when Error_SegDatos2 =>
			Put_line("Error en segmento de datos: Se esperaba el caracter ')'");
		when Error_SegDatos3 => Put("Error_SegDatos3"); --nunca ocurre
		
	end Seg_Datos;

	-- Sintactico del PROGRAMA
	procedure Programa is
		Error_PIncorrecto, Error_PIncorrecto1: exception;
	begin
        if(res = INICIO and error = 0) then    
		    lexico(c,res,error);
		    while ((res = L or res = MEM or res = REG_INT or res = REG_FLOAT or
		            res = SI or res = GT) and error = 0) loop
			    Sentencia;
		    end loop;
		    while (res = STAT and error = 0) loop
		
			    Seg_Datos;
			    if (res = CODE and error = 0) then
                                    Seg_Codigo;
			    else
                                    exit;
			    end if; 
		    end loop;
		    if (res /= FIN and error = 0) then
			    raise Error_PIncorrecto;
		    end if;
        else
            raise Error_PIncorrecto1;
        end if;

	exception
		when Error_PIncorrecto =>
			Put_line("Error, falta el END del programa");
		when Error_PIncorrecto1 =>
			Put_line("Error, falta el BEGIN del programa");

	end Programa;

begin
    Open(Fichero, In_File, "p.txt");
    Put_line("Fichero abierto"); 

    --Lanzamos analizador lexico
    sigchar(c);

    if (c /= Character'Val(0)) then
    	lexico(c,res,error);
		Programa;
    end if;

    Close(Fichero);
    Put_line("Fichero cerrado. Termina el programa");
end main;
