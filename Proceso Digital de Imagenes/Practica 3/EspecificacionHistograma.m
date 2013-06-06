function [ salida ] = EspecificacionHistograma( img1, histograma )
    valores1 = zeros(256, 1);
    [ x, y] = size(img1);
    for i=1:x
        for j=1:y
            valores1(img1(i,j)+1) = valores1(img1(i,j)+1)+1;
        end
    end
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
    [ x, y] = size(img1);
    for i=1:256
        for j=1:256
            if ps(j)>=pr(i)
                pt(i) = j/256;
                break;
            end
        end
    end
    for i=1:x
        for j=1:y
            salida(i,j) = pt(img1(i,j)+1);
        end
    end
end