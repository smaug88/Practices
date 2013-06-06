global inicio fin incremento medias polinomio_interpol

f = figure();
plot(inicio:incremento:fin, medias)
saveas(f, 'curva_calib_medias', 'jpg');

p1 = polyfit(inicio:incremento:fin, medias', 1);
y1 = polyval(p1, inicio:incremento:fin);
f = figure();
plot(inicio:incremento:fin, y1)
saveas(f, 'curva_calib_interpo_grad1', 'jpg');

p2 = polyfit(inicio:incremento:fin, medias', 2);
y2 = polyval(p2, inicio:incremento:fin);
f = figure();
plot(inicio:incremento:fin, y2)
saveas(f, 'curva_calib_interpo_grad2', 'jpg');

p3 = polyfit(inicio:incremento:fin, medias', 3);
y3 = polyval(p3, inicio:incremento:fin);
f = figure();
plot(inicio:incremento:fin, y3)
saveas(f, 'curva_calib_interpo_grad3', 'jpg');

p4 = polyfit(inicio:incremento:fin, medias', 4);
y4 = polyval(p4, inicio:incremento:fin);
f = figure();
plot(inicio:incremento:fin, y4)
saveas(f, 'curva_calib_interpo_grad4', 'jpg');

p5 = polyfit(inicio:incremento:fin, medias', 5);
y5 = polyval(p5, inicio:incremento:fin);
f = figure();
plot(inicio:incremento:fin, y5)
saveas(f, 'curva_calib_interpo_grad5', 'jpg');