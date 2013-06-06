function [ output ] = SegmentarColor( img )
    [x,y] = size(img);
    for k=0:7
        for i=1:x
            for j=1:y
                if(img(i,j)==k)
                    output(k+1,i,j) = 255;
                else
                    output(k+1,i,j) = 0;
                end                    
            end
        end
    end
    figure
    b = output(1,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,1), imshow(c);
    imwrite(c,'salidas_color\0.jpg');
    b = output(2,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,2), imshow(c);
    imwrite(c,'salidas_color\1.jpg');
    b = output(3,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,3), imshow(c);
    imwrite(c,'salidas_color\2.jpg');
    b = output(4,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,4), imshow(c);
    imwrite(c,'salidas_color\3.jpg');
    b = output(5,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,5), imshow(c);
    imwrite(c,'salidas_color\4.jpg');
    b = output(6,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,6), imshow(c);
    imwrite(c,'salidas_color\5.jpg');
    b = output(7,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,7), imshow(c);
    imwrite(c,'salidas_color\6.jpg');
    b = output(8,:,:);
    c = permute(b,[1 3 2]);
    c = reshape(c,[],size(output,2),1)';
    subplot(4,2,8), imshow(c);
    imwrite(c,'salidas_color\7.jpg');
    
end

