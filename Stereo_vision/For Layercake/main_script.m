clear
pkg load image

% Call the layercake function. It will generate a pair of stereo images 
% (L: left-eye and R: Right-eye). 
% 512 by 512 images (L and R) having 5 layers above the background.
[L,R] = layercake(512,512,5); 

% Calling the stereo function. Here smin = 0, smax = 5, sigma = 3 
D = stereo(L,R,0,5,3);

% Scaling pixel values of D to [0 to 255] range
min_value = min(D(:));
D = D - min_value;
max_value = max(D(:));
D = uint8((D./max_value) .* 255);

colormap(gray(256));
image(D+1); axis image;
%imwrite(D,'out_layercake.jpg');

