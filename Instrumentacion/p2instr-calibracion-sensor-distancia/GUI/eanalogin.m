function [voltage overVoltage errorcode idnum] = eanalogin(a, b, c, d)
    % FAKE!
    % Esta funci�n permite probar el programa cuando no se dispone de las
    % funciones del LabJack instaladas en el sistema
    
    voltage     = rand(1, 2) * rand(2, 1);
    overVoltage = rand(1, 2) * rand(2, 1);
    errorcode   = 0;
    idnum       = rand(1, 2) * rand(2, 1);
end