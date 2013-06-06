--Cláusula de contexto
with Text_Io, Ada.Strings, Ada.Strings.Fixed;
use Text_Io, Ada.Strings, Ada.Strings.Fixed;


------------------------ COMENTARIOS ------------------------
-- Por ahora el analizador tan solo examina los            --
-- caracteres y cuando muestra por pantalla la palabra     --
-- las palabras reservadas, sin comprobar el siguiente     --
-- caracter tras la palabra. Reconoce las 11 palabras.     --
--                                                         --
-- El warning que aparece al compilar es normal, es        --
-- porque por ahora el procedure lexico no devuelve nada.  --
--                                                         --
--                                                         --
-------------------------------------------------------------

-------------------------------- CAMBIOS --------------------------------
--24/04 16:05 -> Se han incluido excepciones                           --
--26/04 -> -Incluidos operadores binarios y unarios y separadores      --
--       -Incluida variable Revisar_char para cuando se dan            --
--        oper. dobles u operadores compuestos de 2 (==, !=, etc)      --
--       -Incluido el espacio,que no hace nada | error si no esta      --
--27/04 -> -Incluidos los registros R0..R7                             --
--       -Incluidos los numeros enteros                                --
--       -Modificado el inicio del programa, main llama a sigchar      --
--       -Incluidos tokens que aparecen al final GCC                   --
--30/04 -> - Añadido hexadecimales y octales, número 0                 --
--       - Bucle externo al léxico, no interno                         --
--       - Limpieza de espacios, comentarios, saltos de línea          --
--        - Cambio de Revisar_char por sigchar()                       --
-- 1/05 -> - Añadido de tipo con palabras reservadas                   --
--       - Comprobado general de funcionamiento                        --
--       - Números reales (no esta terminado)                          --
-------------------------------------------------------------------------

--Para comprobar si el sig caracter es el EOL, puesto que
--get solo devuelve caracteres validos tendremos que usar
--la funcion look_ahead(Fichero,c,EOL);

procedure main is --Elemento de librería (subprograma)
    Fichero : Text_Io.File_Type;
    c: Character;
    error: Integer;
    Error_Estructura: exception;

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
                    sigchar(c);
                
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
                salida := POSITIVE;    -- Número 0
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
                    c = ' ';
                    return;
                end if;

    end lexico;

    procedure PrintToken(t: in Token) is
    begin
        Put("Token: ");
        case t is
            when INICIO                 => Put("BEGIN");
            when FIN                    => Put("END");
            when STAT                   => Put("STAT");
            when CODE                   => Put("CODE");
            when MEM                    => Put("MEM");
            when FIL                    => Put("FIL");
            when DAT                    => Put("DAT");
            when STR                    => Put("STR");
            when L                      => Put("L");
            when SI                     => Put("IF");
            when GT                     => Put("GT");
            --------- Sustituidos por MEM ----------
            when E                      => Put("E");
            when S                      => Put("S");
            when F                      => Put("F");
            when D                      => Put("D");
            when I                      => Put("I");
            when P                      => Put("P");
            when U                      => Put("U");
            when J                      => Put("J");
            ----------------------------------------
            when REG_INT                => Put("REG_INT");
            when REG_FLOAT              => Put("REG_FLOAT");
            when BARRA                  => Put("/");
            when DOBLE_BARRA            => Put("//");
            when BARRA_ASTERISCO        => Put("/*");
            when MENOR                  => Put("<");
            when MENOR_MENOR            => Put("<<");
            when MENOR_IGUAL            => Put("<=");
            when MAYOR                  => Put(">");
            when MAYOR_MAYOR            => Put(">>");
            when MAYOR_IGUAL            => Put(">=");
            when ASIGNACION             => Put("=");
            when IGUAL_IGUAL            => Put("==");
            when ASTERISCO              => Put("*");
            when ASTERISCO_BARRA        => Put("*/");
            when AMPERSAND              => Put("&");
            when AMPERSAND_AMPERSAND    => Put("&&");
            when BARRAVERT              => Put("|");
            when BARRAVERT_BARRAVERT    => Put("||");
            when EXCLAMACION            => Put("!");
            when DISTINTO               => Put("!=");
            when ABRE_PARENTESIS        => Put("(");
            when CIERRA_PARENTESIS      => Put(")");
            when COMA                   => Put(",");
            when PUNTO_COMA             => Put(";");
            when DOS_PUNTOS             => Put(":");
            when MAS                    => Put("+");
            when MENOS                  => Put("-");
            when PORCENTAJE             => Put("%");
            when CIRCUNFLEJO            => Put("^");
            when ENE                    => Put("~");
            when POSITIVE               => Put("POSITIVE");
            when FLOTANTE               => Put("FLOAT");
            when CHAR                   => Put("CARACTER");
            when RISTRA                 => Put("RISTRA");
            when DEFECTO                => Put("DEFECTO");
        end case;
        new_line;
    end PrintToken;

begin
    Open(Fichero, In_File, "ficheroq.txt");
    Put_line("Fichero abierto"); 

    --Lanzamos analizador lexico
    sigchar(c);

    while (c /= Character'Val(0)) loop
        lexico(c,res,error);
        if (error = 0) then
            PrintToken(res);
        end if;
    end loop;

    Close(Fichero);
    Put_line("Fichero cerrado. Termina el programa");
end main;

