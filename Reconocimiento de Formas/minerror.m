function [prot,W,J] = minerror(dataset,k)
    [m,n] = size(dataset.dato);
    % La Matriz W representa a cual de los K clusters pertenece cada uno de
    % los m elementos. Asi W(i,j)==1, significa que el elemento j pertenece
    % al cluster k . Cada elemento debe pertenecer a un y solo a un cluster 
    % y cada cluster tiene que tener algun elemento 
    % Se inicializara la matriz W, como una Matriz (Numero de clases X
    % Numero de muestras), todo a 0    
    
    % N sera un vector con el numero de elementos en cada cluster (para
    % evitar contar varias veces
    W = zeros(k,m);
    N = zeros(k);
    
    % Se hara que cada elemento pertenezca a algun cluster
    for i = 1 : m
        aux = randi(k);
        W(aux,i)= 1;
        N(aux) = N(aux)+1;
    end
    % Se comprobara que todos los cluster tienen almenos un elemento, y si
    % alguno no tiene se moveran elementos aleatoriamente hasta que se
    % cumpla
    while 1
        for i = 1 : k
            while sum(W(:,i)) == 0
                aux = randi(m); 
                aux2 = find(W(:,aux)== 1);
                W(aux2,aux) = 0;
                W(i,aux) = 1;
                N(aux2)= N(aux2)-1;
                N(aux)= N(aux)+1;
            end
        end
        aux = 0;
        for i = 1 : k
            if (sum(W(:,i)) == 0)
            aux = aux +1; 
            end
        end
        if aux == 0 
            break;
        end
        
    end
    % Ahora W esta inicializada aleatoriamente
    C = m;
    while C ~= 0
        % Calcular el vector Z, que contendra los prototipos de cada cluster,
        % por asi decirlo, su centro
        Z = zeros(k,n);
        for i = 1:k
            % "Ni" sera el numero de elemento que pertenezen al cluster i
            Ni = 0;
            for j = 1:m
                if W(i,j) == 1
                   Ni = Ni +1;
                   for o = 1:n
                       Z(i,o) = Z(i,o) +dataset.dato(j,o);
                   end
                end
            end
            if Ni == 0
                Ni = 1;
            end
            for o = 1:n
                Z(i,o) = Z(i,o)/Ni;
            end    
        end
   
        C = 0;
        
        % Ahora se colocaran cada una de las muestras en el cluster del
        % prototipo mas cercano
        for i = 1:m
            r = find(W(:,i)==1);
            rt = r;
            % Distancia de la muestra al prototipo de su cluster
            % aux2 = (Ni/Ni-1)(||Zi -Xr||^2)
            aux = 0;
            for o = 1:n
                aux = aux + (dataset.dato(i,o)-Z(r,o))^2;
            end
            %aux = sqrt(aux);
            aux = aux* N(r) / (N(r)-1);
            for j = 1:k
                if j ~= r
                    % aux2 = ||Zi -Xr||^2
                    aux2 = 0;
                    for o = 1:n
                        aux2 = aux2 + (dataset.dato(i,o)-Z(j,o))^2;
                    end
                    %aux2 = sqrt(aux2);
                    aux2 = aux2* N(j) / (N(j)-1);
                    if aux > aux2 
                        aux = aux2;
                        rt = j;
                    end
                end
            end
            if r ~= rt
                % Hay que cambiar
                C = C +1;
                W(r,i) = 0;
                W(rt,i) = 1;
                N(r) = N(r)-1;
                N(rt) = N(rt)+1;
            end
        end
    end    
    prot = Z;
    % Ahora se calculara la funcion objetivo para cumplir con los
    % requisitos de la practica. No se ha computado antes ya que habria
    % requerido recomputarlo con cada cambio. 
    J = zeros(k,1);
    for i = 1:m
        aux = 0;
        aux2 = find(W(:,i)==1);
        for o = 1:n
            aux = aux + (dataset.dato(i,o)-Z(aux2,o))^2;
        end
        J(aux2)= J(aux2)+ aux;
    end
end