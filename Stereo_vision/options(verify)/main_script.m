clear
pkg load image

input_img = imread('dino.pgm');
[h,w] = size(input_img);
half_of_width = floor(w/2);
L = input_img(:,1:half_of_width); % Cropping left image.
R = input_img(:,half_of_width+1:w); % Cropping right image.

% Calling the stereo function. Here smin = -5, smax = 5 and sigm = 5
D_LR = stereo(double(L),double(R),-5,5,5); % Forward (left to right)
D_RL = stereo(double(R),double(L),-5,5,5); % Reverse (right to left)


% Verify using forward and reverse match. 
% Generate a binary image where match is found.

% Creating row grid and column grid
row_grid = repmat([1:h]',1, half_of_width);
col_grid = repmat(1:half_of_width,h,1);  

% Adding forward disparity with 'col_grid'
new_col_grid = col_grid .+ D_LR; 

% Remove row,column values where column values are out of boundary
pos = find(new_col_grid < 1 | new_col_grid > half_of_width);
col_grid(pos) = [];
new_col_grid(pos) = [];
row_grid(pos) = [];

% Generate linear index
location_LR  = sub2ind([h half_of_width],row_grid,col_grid);  
location_RL  = sub2ind([h half_of_width],row_grid,new_col_grid);  

% Binary image
bin = false(h,half_of_width);
bin(location_LR) = D_LR(location_LR) == -1*D_RL(location_RL); % If match is valid 

bin = uint8(bin) .* 255;
colormap(gray(256));
image(bin+1); axis image;
%imwrite(bin,'bin_dino.jpg');

