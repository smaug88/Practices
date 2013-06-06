function [ salida ] = FiltroGradienteSobel( img )
    [x, y] = size(img);
    for i=1:x
        for j=1:y
            if(1<i && i<x)
                if(1<j && j<y)
                    p1 = abs(img(i-1, j+1) + 2*img(i, j+1) + img(i+1, j+1) - img(i-1, j-1) + 2*img(i, j-1) + img(i+1, j-1));
                    p2 = abs(img(i+1, j-1) + 2*img(i+1, j) + img(i+1, j+1) - img(i-1, j-1) + 2*img(i-1, j) + img(i-1, j+1));
                else
                    if(j == 1)
                        p1 = abs(img(i-1, j+1) + 2*img(i, j+1) + img(i+1, j+1));
                        p2 = abs(2*img(i+1, j) + img(i+1, j+1)+ 2*img(i-1, j) + img(i-1, j+1));
                    else
                        p1 = abs(-img(i-1, j-1) + 2*img(i, j-1) + img(i+1, j-1));
                        p2 = abs(img(i+1, j-1) + 2*img(i+1, j) - img(i-1, j-1) + 2*img(i-1, j));
                    end
                end
            else
                if(i == 1)
                   if(1<j && j<y)
                        p1 = abs(2*img(i, j+1) + img(i+1, j+1) + 2*img(i, j-1) + img(i+1, j-1));
                        p2 = abs(img(i+1, j-1) + 2*img(i+1, j) + img(i+1, j+1));
                     else
                        if(j == 1)
                            p1 = abs(2*img(i, j+1) + img(i+1, j+1));
                            p2 = abs(2*img(i+1, j) + img(i+1, j+1));
                        else
                            p1 = abs(2*img(i, j-1) + img(i+1, j-1));
                            p2 = abs(img(i+1, j-1) + 2*img(i+1, j));
                        end
                   end 
                else
                   if(1<j && j<y)
                        p1 = abs(img(i-1, j+1) + 2*img(i, j+1) - img(i-1, j-1) + 2*img(i, j-1));
                        p2 = abs(-img(i-1, j-1) + 2*img(i-1, j) + img(i-1, j+1));
                     else
                        if(j == 1)
                            p1 = abs(img(i-1, j+1) + 2*img(i, j+1));
                            p2 = abs(2*img(i-1, j) + img(i-1, j+1));
                        else
                            p1 = abs(-img(i-1, j-1) + 2*img(i, j-1));
                            p2 = abs(-img(i-1, j-1) + 2*img(i-1, j));
                        end
                   end  
                end
            end
            salida(i,j) = p1-p2;
        end
    end
end

