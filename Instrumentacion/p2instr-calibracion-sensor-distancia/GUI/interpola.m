global inicio fin incremento medias polinomio_interpol

f = figure('Name', 'Curva de calibracion');
plot(inicio:incremento:fin, medias)
saveas(f, 'curva_calib_medias', 'jpg');

p1 = polyfit(inicio:incremento:fin, medias', 1);
y1 = polyval(p1, inicio:incremento:fin);
f = figure('Name', 'Polinomio interpolador grado 1');
plot(inicio:incremento:fin, y1)
saveas(f, 'curva_calib_interpo_grad1', 'jpg');

p2 = polyfit(inicio:incremento:fin, medias', 2);
y2 = polyval(p2, inicio:incremento:fin);
f = figure('Name', 'Polinomio interpolador grado 2');
plot(inicio:incremento:fin, y2)
saveas(f, 'curva_calib_interpo_grad2', 'jpg');

p3 = polyfit(inicio:incremento:fin, medias', 3);
y3 = polyval(p3, inicio:incremento:fin);
f = figure('Name', 'Polinomio interpolador grado 3');
plot(inicio:incremento:fin, y3)
saveas(f, 'curva_calib_interpo_grad3', 'jpg');

p4 = polyfit(inicio:incremento:fin, medias', 4);
y4 = polyval(p4, inicio:incremento:fin);
f = figure('Name', 'Polinomio interpolador grado 4');
plot(inicio:incremento:fin, y4)
saveas(f, 'curva_calib_interpo_grad4', 'jpg');

p5 = polyfit(inicio:incremento:fin, medias', 5);
y5 = polyval(p5, inicio:incremento:fin);
f = figure('Name', 'Polinomio interpolador grado 5');
plot(inicio:incremento:fin, y5)
saveas(f, 'curva_calib_interpo_grad5', 'jpg');

p6 = polyfit(inicio:incremento:fin, medias', 6);
y6 = polyval(p6, inicio:incremento:fin);
f = figure('Name', 'Polinomio interpolador grado 6');
plot(inicio:incremento:fin, y6)
saveas(f, 'curva_calib_interpo_grad6', 'jpg');

p21 = polyfit(inicio:incremento:fin, medias', 21);
y21 = polyval(p21, inicio:incremento:fin);
f = figure('Name', 'Polinomio interpolador grado 22');
plot(inicio:incremento:fin, y21)
saveas(f, 'curva_calib_interpo_grad22', 'jpg');

pcal4 = polyfit(medias', inicio:incremento:fin, 4);
ycal4 = polyval(pcal4, medias');
f = figure('Name', 'Polinomio de calibracion');
plot(medias', ycal4)
saveas(f, 'curva_calib_interpo_gradcal_4', 'jpg');

pcal6 = polyfit(medias', inicio:incremento:fin, 6);
ycal6 = polyval(pcal6, medias');
f = figure('Name', 'Polinomio de calibracion');
plot(medias', ycal6)
saveas(f, 'curva_calib_interpo_gradcal_6', 'jpg');

pcal7 = polyfit(medias', inicio:incremento:fin, 7);
ycal7 = polyval(pcal7, medias');
f = figure('Name', 'Polinomio de calibracion');
plot(medias', ycal7)
saveas(f, 'curva_calib_interpo_gradcal_7', 'jpg');

pcal8 = polyfit(medias', inicio:incremento:fin, 8);
ycal8 = polyval(pcal8, medias');
f = figure('Name', 'Polinomio de calibracion grado 8');
plot(medias', ycal8)
saveas(f, 'curva_calib_interpo_gradcal_8', 'jpg');

pcal9 = polyfit(medias', inicio:incremento:fin, 9);
ycal9 = polyval(pcal9, medias');
f = figure('Name', 'Polinomio de calibracion grado 9');
plot(medias', ycal9)
saveas(f, 'curva_calib_interpo_gradcal_9', 'jpg');