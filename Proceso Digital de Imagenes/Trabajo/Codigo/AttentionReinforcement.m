function [ AM, AF] = AttentionReinforcement( workingMemory, Dam, Cam, CHmin, CHmax, AMpast)
    [x, y] = size(workingMemory);
    for i=1:x
        for j=1:y
            if(workingMemory(i,j) == 0)
                AM(i,j) = max(AMpast(i,j)-Dam, CHmin);
            else
                AM(i,j) = min(AMpast(i,j)+Cam, CHmax);
            end
            if(AM(i,j) > 0)
                v(i,j) = i*x + y +1;
            else
                v(i,j) = 0;
            end
        end
    end
    for i=1:x
        for j=1:y
            if(i==1)
                if (j==1)
                    minv = min(v(i, j),v(i, j+1));
                    minv = min(v(i+1, j),v(i+1, j+1), minv);
                else
                    if(j==y)
                        minv = min(v(i, j-1),v(i, j));
                        minv = min(v(i+1, j-1),v(i+1, j), minv);
                    else
                        minv = min(v(i, j-1),v(i, j),v(i, j+1));
                        minv = min(v(i+1, j-1),v(i+1, j),v(i+1, j+1), minv);
                    end
                end
            else
                if(i==x)
                    if (j==1)
                        minv = min(v(i-1, j),v(i-1, j+1));
                        minv = min(v(i, j),v(i, j+1), minv);
                    else
                        if(j==y)
                            minv = min(v(i-1, j-1),v(i-1, j));
                            minv = min(v(i, j-1),v(i, j), minv);
                        else
                            minv = min(v(i-1, j-1),v(i-1, j),v(i-1, j+1));
                            minv = min(v(i, j-1),v(i, j),v(i, j+1), minv);
                        end
                    end
                else
                    if (j==1)
                        minv = min(v(i-1, j),v(i-1, j+1));
                        minv = min(v(i, j),v(i, j+1), minv);
                        minv = min(v(i+1, j),v(i+1, j+1), minv);
                    else
                        if(j==y)
                            minv = min(v(i-1, j-1),v(i-1, j));
                            minv = min(v(i, j-1),v(i, j), minv);
                            minv = min(v(i+1, j-1),v(i+1, j), minv);
                        else
                            minv = min(v(i-1, j-1),v(i-1, j),v(i-1, j+1));
                            minv = min(v(i, j-1),v(i, j),v(i, j+1), minv);
                            minv = min(v(i+1, j-1),v(i+1, j),v(i+1, j+1), minv);
                        end
                    end
                end
            end
            if(v(i,j) ~= 0 && minv < v(i,j))
                v(i,j) = minv;
            end
        end
    end
    AF = v;
end

