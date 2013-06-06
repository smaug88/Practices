function dataset2 = CondensacionDBC(dataset1)
    Conexiones = Conectividad(dataset1.dato);
    dato=[];
    clase=[];
    for i=1:size(Conexiones,1),
        insertar=false;
        for j=1:size(Conexiones,1),
            if (Conexiones(i,j) & j ~= i)
                if (dataset1.clase(i)~= dataset1.clase(j))
                    insertar=true;
                    break;
                end
            end
        end
        if (insertar)
            dato = [dato; dataset1.dato(i,:)];
            clase = [clase; dataset1.clase(i)];
        end
    end
    dataset2 = struct('nobj', size(dato,1), 'natrib', dataset1.natrib, 'nclases', dataset1.nclases, 'frec', dataset1.frec, 'dato', dato, 'clase', clase);
end




function C = Conectividad(X)
    T = delaunayn(X);
    C = eye(size(X,1));
    for i=1:size(T,1),
        A = nchoosek(T(i,:),2);
        for j=1:size(A,1),
            C(A(j,1),A(j,2)) = 1;
        C(A(j,2),A(j,1)) = 1;
        end
    end
end