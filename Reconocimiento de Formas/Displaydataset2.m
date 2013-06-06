function [] = Displaydataset2 (dataset, x, y)
    a = find(dataset.clase == 1);
    b = find(dataset.clase == 2);
    c = find(dataset.clase == 3);
    plot(dataset.dato(a,x), dataset.dato(a,y),'ro', dataset.dato(b,x), dataset.dato(b,y), 'bo', dataset.dato(c,x), dataset.dato(c,y), 'go');
end