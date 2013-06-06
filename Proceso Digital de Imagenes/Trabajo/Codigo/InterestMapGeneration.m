function [ imMap ] = InterestMapGeneration( Mov )
    [x,y] = size(Mov);
    for i=1:x
        for j=1:y
            if(Mov(i,j)==1)
                imMap(i,j) = 1;
            else
                imMap(i,j) = 3;
            end
        end
    end
end

