%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
ypredict = zeros(1,size(xtest,2));
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [val,index] = max(P);
    ypredict(1, i:i+99) = index;
end
figure
C = confusionmat(ytest,ypredict);
cm = confusionchart(C,[0:9],'ColumnSummary','column-normalized');
% https://www.mathworks.com/matlabcentral/answers/689494-how-to-calculate-confusion-matrix-accuracy-and-precision
accuracy = sum(ytest == ypredict,'all')/numel(ypredict);
cm.Title = ['Confusion Matrix: Accuracy = ' num2str(round(accuracy*100,2))];
fprintf('Test accuracy %.2f\n',round(accuracy*100,2))