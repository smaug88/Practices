function angulo = curva_calib_inv(resistencia)
    % R3_m90 = 18.37;
    % R3_90 = 2.45;
    % pendiente = (R3_m90 - R3_90) / (-90 - 90);
    % angulo = (resistencia - 90*pendiente + R3_90) / pendiente;
    
    m = (2.1285 - 17.7387)/180;
    % angulo = m * (resistencia  - 2.128) - 90;
    angulo = (resistencia - 17.7387)/m - 90;
    
    
end