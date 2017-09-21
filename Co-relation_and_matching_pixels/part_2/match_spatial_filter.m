%{
This program finds the instances of each of the 10 templates I have created in the
previous step (part_1) using basic correlation only. It produce 10 plots (or images), 
one for each digit, with an “X” at the positions of the corresponding digits. 
You will get the 10 plots/images in the 'out' folder.
Templates are inside the 'template' folder.
%}

clear;
pkg load image;
tic()

% Reading and inverting the input image.
f = double(255-imread("data00.pgm"));

% Remove the top region (the file name) from the input image.
[f_height f_width] = size(f);
f = f(24:1:f_height,1:1:f_width); 

% Doing the basic correlation to find the instances of each digit. 
for i = 0:1:9 % For each templates (0-9).
  
  t = double(imread(strcat("template/",int2str(i),".jpg")));
  [t_height t_width] = size(t);
  
  % Correlation can be done using convolution by reversing kernal by 180 degree. 
  M_basic = conv2(f,flip(flip(t,1),2),'same');
  
  % Taking only the local maxima
  M = ordfilt2(M_basic,t_height*t_width,ones(t_height,t_width));
  M_local_max = double((M == M_basic)).* M_basic;
  
  % Scaling the values of matrix 'M_local_max' from 0 to 1.
  m = max(M_local_max(:)');
  M_local_max = M_local_max ./ m; 
  
  % Taking decision based on local maxima and, store the locations in [r c] matrix.
  [r c] = find(M_local_max > 0.87);
   
  % Draw a "X" sign at [r c] locations and write the image into the 'out' folder.
  plot_image = draw_star(r,c,f); 
  imwrite(uint8(plot_image),strcat("out/",int2str(i),".jpg"));

end

toc()

