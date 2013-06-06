function [s] = Edicion(dataset1,k)

    conjunto = [];
    clases = [];
    frec = [];
    for i=1:dataset1.nclases
        frec(i)=0;
    end
    tam=1;

   for i=1:dataset1.nobj
       [clase prob]=KNN(dataset1, dataset1.dato(i,:), k);
       if dataset1.clase(i)==clase
            for j=1:dataset1.natrib
                conjunto(tam, j) = dataset1.dato(i, j);
            end
            clases(tam)=clase;
            frec(clase)=frec(clase)+1;
            tam=tam+1;
       end
   end  

s = struct('nobj', tam-1, 'natrib', dataset1.natrib, 'nclases', dataset1.nclases, 'frec', frec, 'dato', conjunto, 'clase', clases);
end