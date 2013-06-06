function [a,test] = PerceptronSimple1(dataset, clase, ro, num)
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
    test = 0;
    for i=1:num
        b = Psi*a; 
        index = find(b<0); 
        if isempty(index)
            test = 1;
            break;
        end; 
        s = sum(Psi(index,:),1);
        a = a + ro*s';
    end
end
