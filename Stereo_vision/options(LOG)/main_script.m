clear
pkg load image

input_img = imread('dino.pgm');
[h,w] = size(input_img);
L = input_img(:,1:floor(w/2)); % Cropping left image.
R = input_img(:,floor(w/2)+1:w); % Cropping right image.

% Pre-process the L and R images with LOG filter
LOG = fspecial('log',[3 3],3); % 3 by 3 window, sigma = 3
L = conv2(double(L),LOG,'same');
R = conv2(double(R),LOG,'same');

% Calling the stereo function. Here smin = -5, smax = 5 and sigma = 3
D = stereo(L,R,-5,5,3);  

% Scaling pixel values of D to [0 to 255] range
min_value = min(D(:));
D = D - min_value;
max_value = max(D(:));
D = uint8((D./max_value) .* 255);

colormap(gray(256));
image(D+1); axis image;
%imwrite(D,'log_dino.jpg');

