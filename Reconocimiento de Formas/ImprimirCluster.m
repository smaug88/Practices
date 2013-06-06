function ImprimirCluster(dataset,W,prot)
    k = size(prot(:,1));
    [m,n]= size(dataset.dato);
    hold on;
    for i = 1:k 
        X=[];
        Y=[];
        for j = 1:m
            if W(i,j) == 1
               X = [X dataset.dato(j,1)];
               Y = [Y dataset.dato(j,2)];
            end
        end
        switch int2str(i)
            case '1'
                plot(X, Y, 'b*');
                plot(prot(i,1),prot(i,2),'bh');
            case '2'
                plot(X, Y, 'g+');
                plot(prot(i,1),prot(i,2),'gh');
            case '3'
                plot(X, Y, 'ro');
                plot(prot(i,1),prot(i,2),'rh');
            case '4'
                plot(X, Y, 'cs');
                plot(prot(i,1),prot(i,2),'ch');
            case '5'
                plot(X, Y, 'md');
                plot(prot(i,1),prot(i,2),'mh');
            case '6'
                plot(X, Y, 'yp');
                plot(prot(i,1),prot(i,2),'yh');
        end
    end  
    hold off;
end