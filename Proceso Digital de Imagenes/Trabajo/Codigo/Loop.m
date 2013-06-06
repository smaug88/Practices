function [ output ] = Loop(imgV, n)
    img0 = imread(imgV{1});
    tam = size(img0);
    img0 = rgb2gray(img0);
    img0 = ColorExtraction(zeros(tam), img0, 5, 1);
    tam = size(img0);
    AM = zeros(tam);
    CHmov = zeros(tam);
    for i=2:n
        img1 = imread(imgV{i});
        img1 = rgb2gray(img1);
        img1 = ColorExtraction(img0, img1, 5, 2);
        [ v, vx, vy, a, ax, ay, alpha, beta, Mov, CHmov ] = MotionExtraction(img0, img1, 1, CHmov, 0, 255);
        imMap = InterestMapGeneration(Mov);
        WM = WorkingMemoryGeneration(img1, imMap);
        [AM, AF] = AttentionReinforcement(WM, 250, 50, 0, 255, AM);
        img0 = img1;
        output(i,:,:) = AM;
        i
    end
end

