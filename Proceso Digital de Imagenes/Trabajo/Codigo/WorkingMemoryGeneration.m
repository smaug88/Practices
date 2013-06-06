function [ WM ] = WorkingMemoryGeneration( imgGLB, imMap )
    [x,y] = size(imgGLB);
    vmax = x*y+1;
    vmin = 0;
    WM = zeros(x,y);
    for k=1:8
        for i=1:x
            for j=1:y
                if(imgGLB == k)
                    if(imMap(i,j) == 1)
                        v(i,j) = i*y + j + 1;
                    else
                        if(imMap(i,j) == 3)
                            v(i,j) = vmax;
                        else
                            v(i,j) = vmin;
                        end
                    end
                else
                    v(i,j) = vmin;
                end
            end
        end
        for i=1:x
            for j=1:y
                if(v(i,j) ~= vmin && v(i,j) ~= vmax)
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
                    if(minv < v(i,j))
                        v2(i,j) = minv;
                    end
                else
                    v2(i,j) = v(i,j);
                end              
            end
        end
        for i=1:x
            for j=1:y
                if(v2(i,j) ~= vmin && v2(i,j) ~= vmax && WM(i,j) < v2(i,j))
                    WM(i,j) = v2(i,j);
                end
            end
        end
    end
end

