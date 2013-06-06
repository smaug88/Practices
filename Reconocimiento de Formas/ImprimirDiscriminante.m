function ImprimirDiscriminante(a, dataset, clase)
    if nargin < 3
        clase = 1;
    end
    maxX = max(dataset.dato(:,1))
    minX = min(dataset.dato(:,1))
    X = minX:abs((minX-maxX)/100):maxX
    Y = (-a(1)-a(2)*X)/a(3)
    hold on;
    plot(X,Y);
    Displaydataset(dataset);
    hold off;
end