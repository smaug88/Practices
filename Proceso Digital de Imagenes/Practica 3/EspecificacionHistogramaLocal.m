function [ salida ] = EspecificacionHistogramaLocal( img1, histograma, x0, x1, y0, y1 )
    valores1 = zeros(256, 1);
    for i=x0:x1
        for j=y0:y1
            valores1(img1(i,j)+1) = valores1(img1(i,j)+1)+1;
        end
    end
    valores2 = zeros(256, 1);
    pr = zeros(256, 1);
    ps = zeros(256, 1);
    pt = zeros(256, 1);
    for i=1:256
        for j=1:i
            pr(i) = pr(i)+valores1(j);
            ps(i) = ps(i)+histograma(j);
        end
    end
    pr = pr/sum(valores1);
    ps = ps/sum(histograma);
    for i=1:256
        for j=1:256
            if ps(j)>=pr(i)
                pt(i) = j/256;
                break;
            end
        end
    end
    salida = img1;
    for i=x0:x1
        for j=y0:y1
            salida(i,j) = im2uint8(pt(img1(i,j)+1));
        end
    end
end

