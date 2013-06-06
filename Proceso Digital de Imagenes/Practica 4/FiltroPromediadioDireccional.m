function [ salida ] = FiltroPromediadioDireccional( img )
    [x, y] = size(img);
    for i=1:x
        for j=1:y
            if (1<i && i<x)
                if (1<j && j<y)
                    v(1) = (img(i-1, j-1) + img(i,j) + img(i+1, j+1))/3;
                    v(2) = (img(i-1, j) + img(i,j) + img(i+1, j))/3;
                    v(3) = (img(i, j-1) + img(i,j) + img(i, j+1))/3;
                else
                    if (j==1)
                        v(1) = (img(i,j) + img(i+1, j+1))/2;
                        v(2) = (img(i-1, j) + img(i,j) + img(i+1, j))/3;
                        v(3) = (img(i,j) + img(i, j+1))/2;
                    else
                        v(1) = (img(i-1, j-1) + img(i,j))/2;
                        v(2) = (img(i-1, j) + img(i,j) + img(i+1, j))/3;
                        v(3) = (img(i, j-1) + img(i,j))/2;
                    end
                end
            else
                if (i==1)
                    if (1<j && j<y)
                        v(1) = (img(i,j) + img(i+1, j+1))/2;
                        v(2) = (img(i,j) + img(i+1, j))/2;
                        v(3) = (img(i, j-1) + img(i,j) + img(i, j+1))/3;
                    else
                        if (j==1)
                            v(1) = (img(i,j) + img(i+1, j+1))/2;
                            v(2) = (img(i,j) + img(i+1, j))/2;
                            v(3) = (img(i,j) + img(i, j+1))/2;
                        else
                            v(1) = img(i,j);
                            v(2) = (img(i,j) + img(i+1, j))/2;
                            v(3) = (img(i, j-1) + img(i,j))/2;
                        end
                    end
                else
                    if (1<j && j<y)
                        v(1) = (img(i-1, j-1) + img(i,j))/2;
                        v(2) = (img(i-1, j) + img(i,j))/2;
                        v(3) = (img(i, j-1) + img(i,j) + img(i, j+1))/3;
                    else
                        if (j==1)
                            v(1) = img(i,j);
                            v(2) = (img(i-1, j) + img(i,j))/2;
                            v(3) = (img(i,j) + img(i, j+1))/2;
                        else
                            v(1) = (img(i-1, j-1) + img(i,j))/2;
                            v(2) = (img(i-1, j) + img(i,j))/2;
                            v(3) = (img(i, j-1) + img(i,j))/2;
                        end
                    end
                end
            end
            salida(i,j) = max(v);
        end
    end
end

