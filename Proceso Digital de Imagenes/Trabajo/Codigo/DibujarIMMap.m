function [ ] = DibujarIMMap( imMap )
    [x,y] = size(imMap);
    for i=1:x
        for j=1:y
            if(imMap(i,j) == 1)
                p(i,j) = 255;
            else
                if(imMap(i,j) == 2)
                    p(i,j) = 127;
                else
                    p(i,j) = 0;
                end
            end
        end
    end
    imshow(p);
end

