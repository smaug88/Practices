function [] = DisplaydatasetDoble (dataset,dataset2)
    hold on;
    x = find(dataset.clase == 1);
    y = find(dataset.clase == 2);
    z = find(dataset.clase == 3);
    plot(dataset.dato(x,1), dataset.dato(x,2), 'ro', dataset.dato(y,1), dataset.dato(y,2), 'bo', dataset.dato(z,1), dataset.dato(z,2), 'go');
    x = find(dataset2.clase == 1);
    y = find(dataset2.clase == 2);
    z = find(dataset2.clase == 3);
    plot(dataset2.dato(x,1), dataset2.dato(x,2), 'r*', dataset2.dato(y,1), dataset2.dato(y,2), 'b*', dataset2.dato(z,1), dataset2.dato(z,2), 'g*');
    hold off;
end