function [ v, vx, vy, a, ax, ay, alpha, beta, Mov, CHmov ] = MotionExtraction( img1, img2, CMov, CHmovt, CHmin, CHmax)
    [x,y] = size(img1);
    % Get the Motion presence matrix
    CHmov = zeros(x,y);
    for i=1:x
        for j=1:y
            if(img1(i,j)==img2(i,j))
                Mov(i,j) = 0;
                CHmov(i,j) = min(CHmovt(i,j) + CMov, CHmax);
            else
                Mov(i,j) = 1;
                CHmov(i,j) = CHmin;
            end
        end
    end
    % Get the velocity matrix
    for i=1:x
        for j=1:y
            if(i<x)
                vx(i,j) = CMov/(CHmov(i,j)-CHmov(i+1,j));
            else
                vx(i,j) = CMov/(CHmov(i,j));
            end
            if(j<y)
                vy(i,j) = CMov/(CHmov(i,j)-CHmov(i,j+1));
            else
                vy(i,j) = CMov/(CHmov(i,j));
            end
            beta(i,j) = atan(vy(i,j)/vx(i,j));
            v = sqrt(vx(i,j)*vx(i,j) + vy(i,j)*vy(i,j));
        end
    end
    % Get the acceletarion matrix
    for i=1:x
        for j=1:y
            if(i<x)
                ax(i,j) = CMov*(vx(i,j)-vx(i+1,j))/(CHmov(i,j)-CHmov(i+1,j));
            else
                ax(i,j) = CMov*(vx(i,j))/(CHmov(i,j));
            end
            if(j<y)
                ay(i,j) = CMov*(vy(i,j)-vy(i,j+1))/(CHmov(i,j)-CHmov(i,j+1));
            else
                ay(i,j) = CMov*(vy(i,j))/(CHmov(i,j));
            end
            alpha(i,j) = atan(ay(i,j)/ax(i,j));
            a = sqrt(ax(i,j)*ax(i,j) + ay(i,j)*ay(i,j));
        end
    end
end

