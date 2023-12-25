% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
img = imread('../data/cv_cover.jpg');
if size(img, 3) > 1
    img = rgb2gray(img);
end
%% Compute the features and descriptors
Icorners = detectFASTFeatures(img);
[desc, loc] = computeBrief(img, Icorners.Location);
count = [];
for i = 0:10:360
    %% Rotate image
    nimg = imrotate(img,i);
    %% Compute features and descriptors
    nIcorners = detectFASTFeatures(nimg);
    [ndesc, nloc] = computeBrief(nimg, nIcorners.Location);
    %% Match features
    indexPairs = matchFeatures(desc, ndesc,'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    %% Update histogram
    count = [count, size(indexPairs(:,1), 1)];
end
%% Display histogram
figure()
bar(count)

%% Using SURF features
count = [];
Icorners = detectSURFFeatures(img);
[desc, loc] = extractFeatures(img,Icorners.Location, 'Method', 'SURF');
for i = 0:10:360
    % Rotate image
    nimg = imrotate(img,i);
    % Compute features and descriptors
    nIcorners = detectSURFFeatures(nimg);
    [ndesc, nloc] = extractFeatures(nimg,nIcorners.Location, 'Method', 'SURF');
    % Match features
    indexPairs = matchFeatures(desc, ndesc,'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    matchedPoints1 = loc(indexPairs(:,1),:);
    matchedPoints2 = nloc(indexPairs(:,2),:);
    showMatchedFeatures(img,nimg,matchedPoints1,matchedPoints2,'montage');
    % Update histogram
    count = [count, size(indexPairs(:,1), 1)];
end
figure()
bar(count)