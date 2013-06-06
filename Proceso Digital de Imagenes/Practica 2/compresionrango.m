function [ salida ] = compresionrango( img, c)
    salida = im2uint8(mat2gray(c*log10(1+double(img))));
end

