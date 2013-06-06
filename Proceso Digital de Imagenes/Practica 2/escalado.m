function [ salida ] = escalado( imagen )
    minimo = min(min(imagen));
    maximo = max(max(imagen));
    diferencial = maximo - minimo;
    auxiliar = 255/diferencial
	salida = (imagen-minimo)*255/diferencial;
    imshow(salida);
end

