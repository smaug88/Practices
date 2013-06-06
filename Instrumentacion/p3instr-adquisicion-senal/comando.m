% 1.- Señal de 40 Hz
[voltages1 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 7, 3200, 0, 0, 0, 240, 1, 0);
[voltages2 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 7, 1600, 0, 0, 0, 120, 1, 0);
fig = figure;
a = 1/3200;
b = 1/1600;
plot(0:239, voltages1)
hold on;
plot(0:119, voltages2, 'r')
hold off;
saveas(fig, 'cuestion1', 'jpg');

% 2.- 
% NO SE PUEDE HACER, PORQUE LAS FRECUENCIAS DE MUESTREO SON MENORES QUE LAS
% PERMITIDAS POR EL LABJACK

% [voltages3 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 0, 10, 0, 0, 0, 400, 1, 0)
% [voltages4 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 0, 5, 0, 0, 0, 200, 1, 0)
% fig = figure;
% a = 1/10;
% b = 1/5;
% plot(0:a:400*a, voltages3)
% hold on;
% plot(0:b:200*b, voltages4)
% hold off;
% saveas(fig, 'cuestion2', 'jpg');

% 3.- Señal de 0.375 Hz y 0.25 Hz
[voltages5 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 6, 500, 0, 0, 0, 4000, 15, 0)
fig = figure;
a = 1/500;
plot(0:4000-1, voltages5)
saveas(fig, 'cuestion3', 'jpg');

[voltages6 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 6, 500, 0, 0, 0, 4000, 15, 0)
a = 1/500;
hold on;
plot(0:4000-1, voltages6, 'r')
hold off;
saveas(fig, 'cuestion3', 'jpg');
% 4.-

[voltages7 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 6, 500, 0, 0, 0, 167, 1, 0)
% [voltages7 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 0, 250, 0, 0, 0, 83, 1, 0)
fig = figure;
a = 1/500;
% b = 1/250; % NO SE PUEDE HACER, PORQUE LAS FRECUENCIAS DE MUESTREO SON MENORES QUE LAS PERMITIDAS POR EL LABJACK
plot(0:166, voltages7)
% plot(0:b:83*b, voltages7) % --> NO SE PUEDE
saveas(fig, 'cuestion4', 'jpg');

% 5.- 

%[voltages8 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 7, 400, 0, 0, 0, 200, 1, 0)
[voltages9 stateIOout scanRate overVoltage errorcode idnum] = aiburst(-1, 0, 0, 0, 1, 1, [8], 7, 400, 0, 0, 0, 400, 2, 0)
%fig = figure;
hold on;
%plot(0:200-1, voltages8)
plot(0:400-1, voltages9, 'r')
hold off;
saveas(fig, 'cuestion6', 'jpg');