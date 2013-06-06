function [clase, prob] = KNN(dataset, vector, k)
    x = repmat(vector, dataset.nobj, 1);
    x = dataset.dato - x;
    b = sqrt(dot(x(:,:)',x(:,:)')');
    j = sort(b);
    j = j(1:k);
    for i=1:k
        w = find(j(i)==b(:));
        clases(i) = dataset.clase(w(1));
    end
    prob(1:dataset.nclases) = 0;
    for i=1:dataset.nclases
        prob(i) = length(find(clases(:) == i))/k;
    end
    clase = find(max(prob)==prob);
    clase = clase(1);
end