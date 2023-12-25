function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
count = 0;
H = [];
p = 0.99;
len = size(locs1,1);
least_dist = 1e10;
inliers = -1;
s = 4;
N = 500;
for i = 1:N
    rplts = randperm(len,s);
    x1 = locs1([rplts],:);
    x2 = locs2([rplts],:);
    homo = computeH_norm(x1,x2);
    proj = project2d(h.');
    tformplts = transformPointsForward(proj,locs2);
    dist = abs(locs1-tformplts);
    tempplts = [];
    c = 0;
    for j=1:len
        if norm(dist(j,:),2) <= 2.5
            tempplts = [tempplts, j];
            c = c+1;
        end
    end
    ninliers = len(locs1(tempplts,:));
    if ninliers > len(inliers)
        e = (1-ninliers/len);
        N = round(log10(1-p)/log10(1-(1-e)^s));
    end
    if c == count && sum(dist,'all') < least_dist
        least_dist = sum(dist,'all');
        x1 = locs1(tempplts,:);
        x2 = locs2(tempplts,:);
        H = homo;
        inliers = x1;
    elseif c > count
        least_dist = sum(dist,'all');
        x1 = locs1(tempplts,:);
        x2 = locs2(tempplts,:);
        H = homo;
        inliers = x1;
        count = c;
    end
end
if size(H,1) == 0
    bestH2to1 = computeH_norm(x1,x2);
else
    bestH2to1 = H.';
end
end