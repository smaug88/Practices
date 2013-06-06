function [a,lambda] = svm1(dataset,clase)
    [m,n] = size(dataset.dato); 
    I = ones(m,1); 
    Y = [I, dataset.dato]; 
    I(find(dataset.clase ~= clase)) = - 1;
    Psi = repmat(I,[1,n+1]).*Y
    [m,n] = size(Psi);
    Q = eye(n);
    Q(1,1)=0;
    [a,fval,exitflag,out,lam] = quadprog(Q,[],-Psi,-ones(m,1));
    lambda = lam.ineqlin;
end
