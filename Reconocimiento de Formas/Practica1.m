function [s] = Practica1 (nombre, tipo)
    fid = fopen(nombre);
    if(fid == -1)
        return;
    end
    nobj = fscanf(fid, '%u', 1);
    natrib = fscanf(fid, '%d', 1);
    nclases = 0;
    frec = [];
    if(tipo ~= 0)
        index = [];
        for j=1:nobj
            for k=1:natrib
                dato(j,k) = fscanf(fid, '%f ',1);
            end
            clase(j) = fscanf(fid, '%d\n',1);
            if(clase(j)>length(frec))
                while(clase(j)>length(frec))
                    frec(length(frec)+1) = 0;
                end
            end
            frec(clase(j)) = frec(clase(j))+1;
            if(frec(clase(j))==1)
                nclases = nclases+1;
            end
        end
    else
        for j=1:nobj
            for k=1:natrib-1
                dato(j,k) = fscanf(fid, '%f ',1);
            end
            dato(j,s) = fscanf(fid, '%d\n',1);
            clase(j) = 0;
            frec(clase(j)) = 0;
        end
    end
    s = struct('nobj', nobj, 'natrib', natrib, 'nclases', nclases, 'frec', frec, 'dato', dato, 'clase', clase);
end