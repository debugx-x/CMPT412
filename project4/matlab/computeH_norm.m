function [H2to1] = computeH_norm(x1, x2)
x11 = x1(:,1);
x12 = x1(:,2);
x21 = x2(:,1);
x22 = x2(:,2);
len = size(x11,1);
%% Compute centroids of the points
centroid1 = [mean(x11), mean(x12)];
centroid2 = [mean(x21), mean(x22)];
%% Shift the origin of the points to the centroid
s1 = [1, 0, centroid1(1);0,1,centroid1(2);0,0,1];
s2 = [1, 0, centroid2(1);0,1,centroid2(2);0,0,1];
%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
n1 = [sqrt(2)/centroid1(1), 0,0;0,sqrt(2)/centroid1(2), 0;0,0,1];
n2 = [sqrt(2)/centroid2(1), 0,0;0,sqrt(2)/centroid2(2), 0;0,0,1];
%% similarity transform 1
T1 = s1*n1;
%% similarity transform 2
T2 = s2*n2;
%% Compute Homography
p1 = [x11, x12, ones(len,1)];
p2 = [x21, x22, ones(len,1)];
p1 = (T1 * p1.').';
p2 = (T2 * p2.').';
H = computeH(p1, p2);
H = H.';
%% Denormalization
H2to1 = T2\H*T1;
end