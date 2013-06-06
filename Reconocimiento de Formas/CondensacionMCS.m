function dataset2 = CondensacionMCS(dataset1)
    % 1. Hacer S el dataset original y C vacio.
    C=[];
    S=[1:dataset1.nobj];
    
    % 2. Elegir un elemento arbitrario de S y pasarlo a C.
    Random = round(rand(1)*(size(S,2)-1))+1;
    C=struct('nobj', 1, 'natrib', dataset1.natrib, 'nclases', dataset1.nclases, 'frec', dataset1.frec, 'dato', dataset1.dato(Random,:), 'clase', dataset1.clase(Random));
    S = extraer(S,Random);
    
    %3. Clasificar elementos en S en base a C y transferir el primero erroneo desde S a C.
    Continuar = 1;
    while(Continuar)
        Continuar = 0;
        STemp = S;
        while (STemp)
            Random = round(rand(1)*(size(STemp,2)-1))+1;
            [clase, objeto] = NN(C, dataset1.dato(STemp(Random),:));
            if(clase ~= dataset1.clase(STemp(Random)))
                %4. Retornar a 3 hasta que no exista ninguno erroneo o S
                %este vacio.
                C.nobj= C.nobj + 1;
                C.dato= [C.dato; dataset1.dato(STemp(Random),:)];
                C.clase= [C.clase; dataset1.clase(STemp(Random))];
                IndiceAux =find(S==STemp(Random));
                S = extraer(S,IndiceAux);               
                Continuar = 1;
                break;
            end
            STemp = extraer(STemp,Random); 
        end
    end
    dataset2 = C;
end

function V = extraer(V0,Indice)
    if(Indice >1)
        V = [V0(1:(Indice-1)), V0((Indice+1):end)];
    else %% Caso que Indice sea 0
        V = V0(2:end);
    end
end