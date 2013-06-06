global inicio incremento fin

valoresx = inicio:incremento:fin;

f = figure('Visible', 'off');
set(f, 'FileName', '01_nube_todas_puntos');
plot(valoresx, mediciones, '.');
saveas(f, get(f, 'FileName'), 'jpg');

f = figure('Visible', 'off');
set(f, 'FileName', '02_nube_todas_unidas');
plot(valoresx, mediciones);
saveas(f, get(f, 'FileName'), 'jpg');

% f = figure('Visible', 'off');
% set(f, 'FileName', '03_curva_interpolada');
% plot(valoresx, mediciones);