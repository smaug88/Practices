% adquiere.m
%
% [tiempo, medidas] = adquiere(num_iter)
%
% Función para adquirir datos del LabJack. Realiza 'num_iter' medidas y devuelve
% los 'num_iter' valores medidos en el vector 'medidas' y cada instante de tiempo
% en el vector 'tiempo', para facilitar la representación gráfica.
%

% function [tiempo, out] = adquiere(numiter)
%     out = [];
%     tiempo = 0:(numiter-1);
%     tiempo = tiempo * 50;
%     for i = 1:numiter
%         [voltage overVoltage errorcode idnum] = eanalogin(-1, 0, 0, 0);
%         out = [out [voltage]];
%         % pause(deltaT)
%     end
% end

% Función de prueba para el desarrollo de otras funciones, para cuando no
% se tiene el LabJack.
% En lugar de adquirir datos del LabJack, devuelve un vector con valores
% aleatorios.
function [tiempo, out] = adquiere(numiter)
    out = [];
    tiempo = 0:(numiter-1);
    tiempo = tiempo * 50;
    out = rand(1, numiter);
end