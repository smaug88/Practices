function [ salida ] = correcciongamma( img, correccion, gamma, epsilon )
    salida = im2uint8(mat2gray(correccion*power(double(img+epsilon),gamma)));
end