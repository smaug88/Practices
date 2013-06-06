function [] = MuestraPerceptron (dataset, test)   
    maxX = max(dataset.dato(1));
    minX = min(dataset.dato(1));
    maxY = max(dataset.dato(2));
    minY = min(dataset.dato(2));
    F = [minX minY; minX maxY; maxX minY; maxX maxY];
    N = [0 minY-maxY; minX-maxX 0; 0 minY-maxY; maxX-minX 0];
    
    hold on;
    Displaydataset(dataset);
    plot(X, Y, '-g');
    hold off;
end