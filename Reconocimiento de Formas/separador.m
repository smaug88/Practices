function [dataset1, dataset2] = separador(dataset,factor)
    rand('state', sum(100*clock));
    n = dataset.nobj*factor;
    d1nobj = 0;
    d2nobj = 0;
    d2natrib = dataset.natrib;
    d1natrib = dataset.natrib;
    d2clases = dataset.nclases;
    d1clases = dataset.nclases;
    d1dato = 0;
    d2dato = 0;
    d1clase = 0;
    d2clase = 0;
    d1frec = 0;
    d2frec = 0;
    for i=1:dataset.nclases
        f = round(dataset.frec(i)*factor)+d1nobj;
        datos = find(dataset.clase==i);
        for k=1:dataset.natrib
            dato(:, k) = dataset.dato(datos,k);
        end
        j = 0;
        while (j<length(find(dataset.clase == i))),
            if((rand()<factor)&&(d1nobj<f))
                for k=1:dataset.natrib
                    d1dato(d1nobj+1, k) = dato(j+1, k);
                end
                d1nobj = d1nobj + 1;
                d1clase(d1nobj) = i;
            else
                for k=1:dataset.natrib
                    d2dato(d2nobj+1, k) = dato(j+1, k);
                end
                d2nobj = d2nobj + 1;
                d2clase(d2nobj) = i;
            end
            j = j+1;
        end
    end
    for i=1:dataset.nclases
        d1frec(i) = length(find(d1clase==i));
        d2frec(i) = length(find(d2clase==i));
    end
    
    dataset1 = struct('nobj', d1nobj, 'natrib', d1natrib, 'nclases', d1clases, 'frec', d1frec, 'dato', d1dato, 'clase', d1clase);
    dataset2 = struct('nobj', d2nobj, 'natrib', d2natrib, 'nclases', d2clases, 'frec', d2frec, 'dato', d2dato, 'clase', d2clase);
end