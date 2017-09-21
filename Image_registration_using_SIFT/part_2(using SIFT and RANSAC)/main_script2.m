clear
pkg load image
tic()

% Initialization of panaromic mosaic with all zeros
I_mos = zeros(1100,2500);

% Initial transformation matrix (simple translation)
M1 = [ 1 0 -1000;0 1 -300;0 0 1];

% Place the first image at the center of the mosaic. I have started with goose.3 image.
% Then register goose.2, goose.1 and goose.0 (at the left of goose.3 image) and 
% goose.4, goose.5 and goose.6  images (at the right of goose.3 image).
read_str3 = strcat('goose/goose.',int2str(3),'.pgm'); 
img3 = imread(read_str3);
Iw = warp(img3,M1,size(I_mos));
pix_to_update = warp(ones(size(img3)),M1,size(I_mos)) > 0;
I_mos(pix_to_update) = Iw(pix_to_update);

% registering goose.2 image in the current mosaic image 'I_mos'
read_str2 = strcat('goose/goose.',int2str(2),'.pgm');  
[M,I_mos] = stitch_new_image(read_str3,read_str2,M1,I_mos);

% registering goose.1 image in the current mosaic image 'I_mos'
read_str1 = strcat('goose/goose.',int2str(1),'.pgm');  
[M,I_mos] = stitch_new_image(read_str2,read_str1,M,I_mos);

% registering goose.0 image in the current mosaic image 'I_mos'
read_str0 = strcat('goose/goose.',int2str(0),'.pgm');  
[M,I_mos] = stitch_new_image(read_str1,read_str0,M,I_mos);

% registering goose.4 image in the current mosaic image 'I_mos'
read_str4 = strcat('goose/goose.',int2str(4),'.pgm');  
[M,I_mos] = stitch_new_image(read_str3,read_str4,M1,I_mos);

% registering goose.5 image in the current mosaic image 'I_mos'
read_str5 = strcat('goose/goose.',int2str(5),'.pgm');  
[M,I_mos] = stitch_new_image(read_str4,read_str5,M,I_mos);

% registering goose.6 image in the current mosaic image 'I_mos'
read_str6 = strcat('goose/goose.',int2str(6),'.pgm');  
[M,I_mos] = stitch_new_image(read_str5,read_str6,M,I_mos);

imwrite(uint8(I_mos),'mosaic1.jpg');
toc()