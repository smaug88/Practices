R3_m90 = 18.37;
R3_90 = 2.45;
pendiente = (R3_m90 - R3_90) / (-90 - 90);
rango_angulo = -90:0.1:90;
resistencia_potenciometro = pendiente * (rango_angulo - 90) + R3_m90;
plot(rango_angulo, resistencia_potenciometro)
save('info_calibracion.mat', 'rango_angulo', 'resistencia_potenciometro')