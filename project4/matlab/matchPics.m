function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary

% if image's no of channel is more than 3, convert to grayscale
if size(I1, 3) > 1
    I1 = rgb2gray(I1);
end

if size(I2, 3) > 1
    I2 = rgb2gray(I2);
end
%% Detect features in both images
I1corners = detectFASTFeatures(I1);
I2corners = detectFASTFeatures(I2);
%% Obtain descriptors for the computed feature locations
[desc1, loc1] = computeBrief(I1, I1corners.Location);
[desc2, loc2] = computeBrief(I2, I2corners.Location);
%% Match features using the descriptors
indexPairs = matchFeatures(desc1, desc2,'MatchThreshold', 10.0, 'MaxRatio', 0.68);
matchedPoints1 = loc1(indexPairs(:,1),:);
matchedPoints2 = loc2(indexPairs(:,2),:);
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
locs1 = matchedPoints1;
locs2 = matchedPoints2;
end