function [ salida ] = extraccionbits( im, n )
    [ x,y ] = size(im);
    salida = im;
    for i=1:x
        for j=1:y
            salida(i,j) = bitset(salida(i,j),n);
        end
    end
end

