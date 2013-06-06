% eanalogout(-1, 0, x, y)
% el primer valor (x): 0 adelante, 5 atras
% el segundo valor (y): 0 conduce, 5 no

load pcal8;
while true
    distancia = 10;
    % preguntar distancia
    [voltaje overVoltage errorcode idnum] = eanalogin(-1, 0, 0, 0);
    distancia = polyval(pcal8, voltaje);
    % decidir accion
    if distancia < 15
        eanalogout(-1, 0, 5.0, 0.0); % hacia atrás
    else
        if distancia > 17
            eanalogout(-1, 0, 0.0, 0.0); % hacia delante
        else
            eanalogout(-1, 0, 5.0, 5.0); % quieto parao
        end
    end
    pause(0.1);
end