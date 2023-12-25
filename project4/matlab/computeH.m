function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points

x11 = x1(:,1);
x12 = x1(:,2);

x21 = x2(:,1);
x22 = x2(:,2);
H = [];

len = size(x11,1);

for i = 1:len
    H(2*i-1,:) = [-(x11(i)), -(x21(i)), -1, 0, 0, 0, (x11(i))*(x21(i)), (x12(i))*(x21(i)), x21(i)];
    H(2*i,:) = [0, 0, 0, -(x11(i)), -(x12(i)), -1, (x11(i))*(x22(i)), (x12(i))*(x22(i)), x22(i)];
end
if  size(x1,1) <= 4
    [U, S, V] = svd(H);
else
    [U, S, V] = svd(H,'econ');
end
V = reshape(V(:,end),3,3);
[V(1,2),V(2,2), V(3,2)] = deal(V(2,2),V(3,2), V(1,2));
H2to1= V;
end
