function [clase, objeto] = NN(dataset, vector)
    x = repmat(vector, dataset.nobj, 1);
    x = dataset.dato - x;
    b = sqrt(dot(x(:,:)',x(:,:)')')
    n = find(b==min(b));
    sort(b)
    objeto = dataset.dato(n,:);
    clase = dataset.clase(n);
end