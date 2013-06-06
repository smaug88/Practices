function [] = Resultado_KNN(dataset, factor, kmax)
    [dataset1 dataset2] = separador(dataset, factor);
    for i=1:kmax
        [error prob] = Test_KNN(dataset1, dataset2, i);
        total(i) = error;
    end
    plot(1:kmax, total, 'bo-');
end