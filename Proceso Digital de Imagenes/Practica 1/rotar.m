function [ salida ] = rotar( matriz, angulo)
    angl = angulo*pi/180;
    Matrizrotacion = [cos(angl) sin(angl) 0 ; ...
                     -sin(angl) cos(angl) 0 ; ...
                              0         0 1];
    [X, Y, A] = size(matriz);
    MatCentrar = [1 0 0; 0 1 0; -X/2 -Y/2 1];
    MatDesCentrar = [1 0 0; 0 1 0; X/2 Y/2 1];
    MatTransf = MatCentrar*Matrizrotacion*MatDesCentrar;
    for i=1:X
        for j=1:Y
           P = [i j 1]*MatTransf;
           if P(1) > 0 && P(1) < X && P(2) > 0 && P(2) < Y
               for n=1:A
                   salida(round(P(1))+1,round(P(2))+1,n) = matriz(i, j, n);
               end
           end
        end
    end
end