clear
pkg load image

% Initialization of the mosaic area
I_mos = zeros(400,400);

img1 = imread('books0.pgm');
img2 = imread('books1.pgm');

% 8 Hand selected points from the image books0.pgm
p1 = [40,7,87,81,147,244,271,169;
        30,171,230,147,20,36,164,90;
        1,1,1,1,1,1,1,1];
        
% 8 Hand selected points from the image books1.pgm
p2 = [63,13,83,87,170,266,272,183;
        15,146,215,131,15,41,173,85;
        1,1,1,1,1,1,1,1];

% Calcalate Homography
H = my_homography(p1,p2);

% Initial transformation matrix (simple translation)
M = [ 1 0 -50; 0 1 -75; 0 0 1];

% Warp the image 'img1' into the mosaic 'I_mos' using transformation matrix M
Iw = warp(img1,M,size(I_mos));
pix_to_update = warp(ones(size(img1)),M,size(I_mos)) > 0;
I_mos(pix_to_update) = Iw(pix_to_update);

% Warp the image 'img2' into the mosaic 'I_mos' using transformation matrix H*M
Iw = warp(img2,H*M,size(I_mos));
pix_to_update = warp(ones(size(img2)),H*M,size(I_mos)) > 0;
I_mos(pix_to_update) = Iw(pix_to_update);

imwrite(uint8(I_mos),'out.jpg');