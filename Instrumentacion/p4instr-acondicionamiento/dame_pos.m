function pos = dame_pos
    R1 = 9.19;
    R2 = 19.62;
    R4 = 5.03;
    RK = R4 / (R1 + R4);
    v = 5;
    
    % -1 = Primer LabJack encontrado
    %  0 = Operación normal (no demo)
    %  8 = Canal 8 (1er canal diferencial)
    %  0 = Ganancia 1
    [voltage overVoltage errorcode idnum] = eanalogin(-1, 0, 8, 0);
    % resistencia = -19.62*(voltage + 1.02) / (voltage + 3.98); % no calcula bien la resistencia
    % resistencia = ((R4 / (R1+R4)) - (-voltage/5)) * (R2+R4) % calcula la resistencia con cierto parecido, pero con un cierto offset
    % resistencia = (R2 * (voltage/5 + RK)) / (1 - voltage/5 + RK);
    % resistencia = R2*(-voltage*R1-voltage*R4+v*R4)/(voltage*R1+voltage*R4+v*R1)
    
    resistencia = R2*(v*R4+voltage*R1+voltage*R4)/(v*R1-voltage*R1-voltage*R4);
    
    disp('voltaje '), disp(voltage); % depuracion
    disp('R '), disp(resistencia); % depuracion
    pos = curva_calib_inv(resistencia);
end