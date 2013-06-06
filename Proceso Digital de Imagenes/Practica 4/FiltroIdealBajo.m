function [ salida ] = FiltroIdealBajo( img, dist )
    imgFrec = fftshift(fft2(img));
    [x, y] = size(img);
    xcent = x/2;
    ycent = y/2;
    im2 = zeros(x,y);
    for i=1:x
        for j=1:y
            dist2 = sqrt((i-xcent)*(i-xcent) + (j-ycent)*(j-ycent));
            if (dist2<=dist)
                im2(i,j) = 1;
            end
        end
    end
    im2 = im2.*imgFrec;
    salida = uint8(ifft2(ifftshift(im2)));
end

