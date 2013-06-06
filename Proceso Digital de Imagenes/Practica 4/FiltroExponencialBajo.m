function [ salida ] = FiltroExponencialBajo( img, dist, n )
    imgFrec = fftshift(fft2(img));
    [x, y] = size(img);
    xcent = x/2;
    ycent = y/2;
    img2 = zeros(x,y);
    for i=1:x
        for j=1:y
            dist2 = sqrt((i-xcent)*(i-xcent) + (j-ycent)*(j-ycent));
            img2(i,j) = imgFrec(i,j)*exp(-power(dist2/dist, n));
        end
    end
    salida = uint8(ifft2(ifftshift(img2)));
end

