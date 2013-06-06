function a = PerceptronMuestra(dataset, clase, ro, num)
    if nargin < 3
        ro = 0.001;
        num = 100;
    end
    [m,n] = size(dataset.dato); 
    I = ones(m,1); 
    Y = [I, dataset.dato]; 
    I(find(dataset.clase ~= clase)) = - 1;
    Psi = repmat(I,[1,n+1]).*Y;
    
    
    [m,n] = size(Psi);
    a = rand(n,1);
    while 1
        cambios = 0;
        for i=1:m
            Z = Psi(i,:);
            if Z*a < 0
                a = a + ro*Z';
                cambios = cambios + 1;
            end
        end
        if cambios == 0 break,end
    end
end
