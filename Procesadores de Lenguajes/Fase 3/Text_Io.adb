---------------------------------------------
-- Este fichero contiene las declaraciones --
-- prototipo para trabajar con ficheros    --
-- en el lenguaje nADA.                    --
---------------------------------------------

procedure Open (File : inout Integer;
		Mode : in String;
		Name : in String);

procedure Close (File : in Integer);

procedure Get (File : in Integer;
		Mode : out String);

procedure Put (File : in Integer;
		Mode : in String);

function End_Of_File (File : Integer) return Integer;

