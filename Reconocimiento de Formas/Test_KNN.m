function [error, prob] = Test_KNN(dataset1, dataset2, k)
   probs(1:dataset1.nclases, 1:dataset1.nclases) = 0;
   clases(1:dataset2.nobj) = 0;
   for i=1:dataset2.nobj
       [clases(i) probs(i,:)] = KNN(dataset1, dataset2.dato(i,:), k);
   end
   error = 0;
   prob(dataset1.nclases, dataset1.nclases) = 0;
   nclases(1:dataset2.nclases,1:dataset2.nclases) = 0;
   for i=1:dataset2.nobj
       if clases(i) ~= dataset2.clase(i);
           error = error + 1;
       end
       nclases(dataset2.clase(i),clases(i)) = nclases(dataset2.clase(i),clases(i)) + 1;
   end
   ntot(1:dataset2.nclases) = 0;
   for i=1:dataset2.nclases
       for(j=1:dataset2.nclases)
           ntot(i) = ntot(i)+ nclases(i,j);
       end
   end 
   for i=1:dataset2.nclases
       prob(i,:) = nclases(i,:)/ntot(i);
   end
   error = error / dataset2.nobj;
end