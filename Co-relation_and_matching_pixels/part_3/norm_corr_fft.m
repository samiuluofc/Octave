%{
This program finds the instances of each of the 10 templates I have created in the
previous step (part_1) using NORMALIZED correlation in FOURIER DOMAIN. 
It produces 10 plots (or images) as like the part_2(Basic Correlation). 
%}

clear;
pkg load image;
tic();

% Reading and inverting the input image.
f = double(255-imread("data00.pgm"));

% Remove the top region (the file name) from the input image.
[f_height f_width] = size(f);
f = f(24:1:f_height,1:1:f_width); 
[f_height f_width] = size(f); % Stores updated height and width.

% Fourier transform of the input image f and the square version of f image.
% Later, we need these frequency domain images for normalized correlation.
f_sq = f .^ 2;
F_sq = fft2(f_sq);
F = fft2(f);

% Doing the normalized correlation in fourier domain to find the instances of each digit.
for i = 0:1:9 % For each templates (0-9).
  
  % Find normalized Template 'T_norm'
  t = double(imread(strcat("template/",int2str(i),".jpg"))); 
  [t_height t_width] = size(t);
  t_sq_sum = sqrt(sum((t .^ 2)(:)));
  t_norm = t ./ t_sq_sum;
  T_norm = fft2(t_norm,f_height,f_width); % FFT with zero padding
  
  % For normalized correlation (in spatial domain), I need to convolve a 
  % kernal (all 1's + same size as the template) to calculte the sum of 
  % squares in f_sq. Here I am doing the same thing, but in the fourier domain.  
  T_ones = fft2(ones(t_height,t_width),f_height,f_width);
  I_sq_sum = sqrt(real(ifft2(F_sq .* T_ones)));

  % Calculating intermediate (still needed to be divided by 'I_sq_sum') normalized 
  % correlation in fourier domain. 
  % My observation is that after doing correlation in fourier domain, 
  % the center of the resulted matrix shifts according to the template size. To get
  % the correct result, I use circular shift after inverse fft.
  M_inter = real(ifft2(F .* conj(T_norm))); 
  M_inter = circshift(M_inter, [t_height-1 t_width-1]);
 
  % Normalized correlation values 
  M_norm =  M_inter ./ I_sq_sum;
  
  % Taking only the local maxima
  M = ordfilt2(M_norm,t_height*t_width,ones(t_height,t_width));
  M_local_max = double((M == M_norm)).* M_norm;
  
  % Taking decision based on normalized value and, store the locations in [r c] matrix.
  [r c] = find(M_local_max > 0.87);
  
  % Draw a "X" sign at [r c] locations and write the image into the 'out' folder.
  plot_image = draw_star(r,c,f);
  imwrite(uint8(plot_image),strcat("out/",int2str(i),".jpg"));
  
end

toc()

