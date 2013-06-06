function [ output, GLB ] = ColorExtraction( img0, img1, S, modo)
    [x,y] = size(img1);
    GLmin = min(min(img1));
    GLmax = max(max(img1));
    GLdiff = GLmax-GLmin;
    diff = double(ceil(GLdiff/8));
    if(modo==1)
        for i=1:x
            for j=1:y
                output(i,j) = floor(double(img1(i,j))/diff);
            end
        end
    else
        for i=1:x
            for j=1:y
                maxi = max((img0(i,j)-1)*GLdiff/8 - S, GLmin);
                mini = min(img0(i,j)*GLdiff/8 + S, GLmax);
                if (maxi <= img1(i,j) && mini > img1(i,j))
                    output(i,j) = img0(i,j);
                else
                    output(i,j) = floor(double(img1(i,j))/diff);
                end
            end
        end
    end
end

