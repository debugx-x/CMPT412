%% Network defintion
addpath('../matlab')
layers = get_lenet();

%% load the trained weights
load ../matlab/lenet.mat

%% Loading images data

Files=dir('../images');
for k=3:length(Files)
    ogimg = imread(append('../images/',Files(k).name));
    
    img = im2double(ogimg);
    img = rgb2gray(img);
    img = imcomplement(img);
    level = graythresh(img);
    img(img<level) = 0;
    img(img>level) = 255;
    BW = imbinarize(img,level);
    CC = bwconncomp(BW);
    S = regionprops(CC,'BoundingBox');
    S = struct2cell(S);
    
    bs = size(S,2);
    input = zeros(28*28,bs);
    layers{1,1}.batch_size = bs;
    
    for i=1:bs
    cimg = imcrop(img,S{1,i});
    %paddingclc
        if size(cimg,1) > size(cimg,2)
            pad = floor((size(cimg,1) - size(cimg,2))/2);
        else
            pad = floor((size(cimg,2) - size(cimg,1))/2);
        end
    cimg = padarray(cimg, [pad pad], 0, 'both');
    input(:,i) = (imresize(cimg,[28*28, 1])).';
    end  
    
    [output, P] = convnet_forward(params, layers, input);
    [val, index] = max(P);
    
    fprintf('Image: %s Digit recognition predictions are: \n', Files(k).name)
    disp(index-1)
    fprintf('\n')
    
    figure();
    imshow(ogimg)
    hold on 
    for i=1:bs
        pos = S{1,i};
        rectangle('Position',S{1,i},'EdgeColor','r')
    end
end