function [] = DisplayDataset3Doble (dataset,dataset2)
    hold on;
    x=1;
    y=2;
    z=3;
    
    a = find(dataset.clase == 1);
    b = find(dataset.clase == 2);
    c = find(dataset.clase == 3);
    plot3(dataset.dato(a,x), dataset.dato(a,y), dataset.dato(a,z), 'ro', dataset.dato(b,x), dataset.dato(b,y), dataset.dato(b,z), 'bo', dataset.dato(c,x), dataset.dato(c,y), dataset.dato(c,z), 'go');
    a = find(dataset2.clase == 1);
    b = find(dataset2.clase == 2);
    c = find(dataset2.clase == 3);
    plot3(dataset2.dato(a,x), dataset2.dato(a,y), dataset2.dato(a,z), 'r*', dataset2.dato(b,x), dataset2.dato(b,y), dataset2.dato(b,z), 'b*', dataset2.dato(c,x), dataset2.dato(c,y), dataset2.dato(c,z), 'g*');
    hold off;
    cameratoolbar
end