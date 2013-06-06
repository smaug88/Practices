function [] = Displaydataset (dataset)
    x = find(dataset.clase == 1);
    y = find(dataset.clase == 2);
    z = find(dataset.clase == 3);
    plot(dataset.dato(x,1), dataset.dato(x,2), 'r+', dataset.dato(y,1), dataset.dato(y,2), 'b*', dataset.dato(z,1), dataset.dato(z,2), 'go');
end