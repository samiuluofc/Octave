%{
This is the program that will do the first part of the assignment 2. The program 
will extract individual digits (1500 digits) from one of the sample images and save 
these as separate image files into the 'out' folder. I have manually identified one
example of each digit (0 through 9) to use for template and put them into 
the 'template' folder.
%}

clear;
pkg load image;

% Reading and inverting the input image.
f = 255-imread('data00.pgm'); 

% Remove the top region (the file name) from the input image.
[f_height f_width] = size(f);
f = f(24:1:f_height,1:1:f_width); 

% Converting f into binary image using dynamic thresholding.
% This is needed for finding binary connected components (each digits).
bin_img = im2bw(f,graythresh(f));

% Labeling the connected components of 'bin_image' considering 8 neighbours.
[label_image number_of_com] = bwlabel(bin_img,8); 

% Cropping connected components from the input image based on the 'label_image'.
% Here, total number of components is 'number_of_com'.
for L = 1:1:number_of_com
  
  [row col] = find(label_image == L);
  f_digit = f(min(row):max(row), min(col):max(col));
  
  % Write the cropped image into the 'out' folder
  imwrite(f_digit,strcat("out/",num2str(L),".jpg"));
end
