% num = match(image1, image2)
%
% This function reads two images, finds their SIFT features, and
%   A match is accepted only if its distance is less than distRatio times the distance to the
%   second closest match. It returns matched pixels.

function [x1,x2] = match(image1, image2)

% Find SIFT keypoints for each image
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);

% For efficiency in Matlab, it is cheaper to compute dot products between
%  unit vectors rather than Euclidean distances.  Note that the ratio of 
%  angles (acos of dot products of unit vectors) is a close approximation
%  to the ratio of Euclidean distances for small angles.

% distRatio: Only keep matches in which the ratio of vector angles from the
% nearest to second nearest neighbor is less than distRatio.
distRatio = 0.6;   

% For each descriptor in the first image, select its match to second image.
des2t = des2';                          % Precompute matrix transpose

for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
end

% Rather than displaying matched pixels (using line connections), I have 
% returned the pixels to calculate homographic projection matrix. 
x1 = x2 = [];

for i = 1: size(des1,1)
  if (match(i) > 0)
    x1(:,end+1) = [loc1(i,2) loc1(i,1) 1];
    x2(:,end+1) = [loc2(match(i),2) loc2(match(i),1) 1];
  end
end




