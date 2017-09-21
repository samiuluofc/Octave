function Iw = warp( I, M, sz )
%   Iw = warp( I, M, sz )   -   warp image I using linear transform M
%   I   -   input image
%   M   -   linear coord transform matrix
%   sz  -   warped image size
%   Iw  -   warped image

% get row and column coordinates in row vectors
[x, y] = meshgrid(1:sz(2), 1:sz(1));
x = x(:)';
y = y(:)';
n = size(x,2);
    
% compute new coords
X = [x;y;ones(1,n)];
Xp = M * X;
x = reshape( Xp(1,:) ./ Xp(3,:), sz(1), sz(2) );
y = reshape( Xp(2,:) ./ Xp(3,:), sz(1), sz(2) );
    
% resample to warp the image
Iw = resample( I, x, y );
