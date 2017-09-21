function b = resample( a, x, y )
%   b = resample( a, x, y ) - resample a at points given in x and y
%   a   -   input image
%   x   -   image of x coordinates to sample, same size as y
%   y   -   image of y coordinates to sample, same size as x
%   b   -   resampled image - same size as x and y

% get size of a then reshape
[ma,na] = size(a);
a = [a(:); 0];      

% zero element for out of bounds
obounds = ma * na + 1;

% get size of b from x
[mb,nb] = size(x);
b = zeros(mb,nb);
    
% find grid coords from source image and offset of resample points
j = floor(y(:));
k = floor(x(:));
alph = x(:) - k;
beta = y(:) - j;
    
% weights for bilinear interpolation
w = [(1-alph).*(1-beta), (1-alph).*beta, alph.*(1-beta), alph.*beta ];
    
% get masks for out of bounds
mask1 = (1 <=  j    &  j    <= ma) & (1 <=  k    &  k    <= na);
mask2 = (1 <= (j+1) & (j+1) <= ma) & (1 <=  k    &  k    <= na);
mask3 = (1 <=  j    &  j    <= ma) & (1 <= (k+1) & (k+1) <= na);
mask4 = (1 <= (j+1) & (j+1) <= ma) & (1 <= (k+1) & (k+1) <= na);

% indices for points to use for bilinear interpolation
indx1 = j   + ma*(k-1);
indx2 = j+1 + ma*(k-1);
indx3 = j   + ma*(k  );
indx4 = j+1 + ma*(k  );
    
% replace indices for out of bounds with index for zero element in a
indx1 = mask1 .* indx1 + ~mask1 * obounds;
indx2 = mask2 .* indx2 + ~mask2 * obounds;
indx3 = mask3 .* indx3 + ~mask3 * obounds;
indx4 = mask4 .* indx4 + ~mask4 * obounds;
    
% get the indexed samples from a
A = [ a(indx1), a(indx2), a(indx3), a(indx4) ];
    
% resample the image
b = sum((w .* A)');
b = reshape( b, mb, nb );

endfunction
