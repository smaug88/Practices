function [res, submatriz] = menor(matriz, fila, col)
    dim = size(matriz);
    maxi = dim(1);
    maxj = dim(2);
    
    submatriz = rand(maxi - 1, maxj - 1);
    cuenta = 1;
    
    for ci = 1:maxi
        for cj = 1:maxj
            if ci ~= fila & cj ~= col
                submatriz(cuenta) = matriz(ci, cj);
                cuenta = cuenta + 1;
            end
        end
    end
    
    res = det(submatriz);
end