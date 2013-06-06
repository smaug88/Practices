function [] = Displaydataset3 (dataset, x, y, z)
    a = find(dataset.clase == 1);
    b = find(dataset.clase == 2);
    c = find(dataset.clase == 3);
    plot3(dataset.dato(a,x), dataset.dato(a,y), dataset.dato(a,z), 'ro', dataset.dato(b,x), dataset.dato(b,y), dataset.dato(b,z), 'bo', dataset.dato(c,x), dataset.dato(c,y), dataset.dato(c,z), 'go');
    cameratoolbar
end