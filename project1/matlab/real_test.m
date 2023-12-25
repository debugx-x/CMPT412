%% Network defintion
layers = get_lenet();

%% Loading data
img = imread('../images/ID/img9.png');

%resize
img = imresize(img,[28 28]);

%2double
img = im2double(img);

%2gray
img = rgb2gray(img);

% load the trained weights
load lenet.mat

%% Testing the network
num = [0:9];
layers{1}.batch_size = 1;
[output, P] = convnet_forward(params, layers, img(:));
[val, index] = max(P);
disp([transpose(num) P])
fprintf('number: %i\n', index-1)