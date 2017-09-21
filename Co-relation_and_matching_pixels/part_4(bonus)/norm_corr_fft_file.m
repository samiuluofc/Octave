%{
This program produces a text file (out.txt) to match 
the source.txt (data00.txt or data01.txt) file used to generate the image. 
You can check your results with the included python script (check.py).
%}

clear;
pkg load image;
tic();

% Reading and inverting the input image.
f = double(255-imread("data00.pgm"));

% Remove the top region (the file name) from the input image.
[f_h f_w] = size(f);
f = f(25:1:f_h,1:1:f_w); 

% Convert 'f' into binary image using dynamic threshold value.
bin_img = im2bw(uint8(f),graythresh(uint8(f)));       

% Labeling the connected components in the 'bin_image'.
[label_image number_of_com] = bwlabel(bin_img,8); 

 
%{
At each iteration, I crop one digit from the input image and do normalized 
correlation (in frequency domain) with each template (0 - 9).
Store the best macthed (maximum correlation among ten) digit value and its locations. 
%}
for L = 1:1: number_of_com
  
  % Croping a single digit from the input image.
  [row col] = find(label_image == L);
  f_digit = f(min(row):max(row), min(col):max(col));


  % Normalied version (F_norm) of the cropped digit.
  f_sq_sum = sqrt(sum((f_digit .^ 2)(:)));
  f_norm = f_digit ./ f_sq_sum;
  F_norm = fft2(f_norm);
  [f_height f_width] = size(F_norm);

  max_value = 0;
  
  for i = 0:1:9
    
    % Reading a template.
    t = double(imread(strcat("template/",int2str(i),".jpg"))); 
    [t_height t_width] = size(t);
 
    % Normalied version (T_norm) of the template.
    t_sq_sum = sqrt(sum((t .^ 2)(:)));
    t_norm = t ./ t_sq_sum;
    T_norm = fft2(t_norm,f_height,f_width);

    % Correlation of F_norm and T_norm.
    M_norm = real(ifft2(F_norm .* conj(T_norm))); 

    % One of the template among ten will have the maximum match.
    if max(M_norm(:)) > max_value 
      digit = i;
      max_value = max(M_norm(:));
    end
  
  end
  
  % Store the best-matched digit value and its location.
  % Later its needed to sort all the locations and print orderly.  
  position(L,1) =  min(row);
  position(L,2) =  min(col);
  position(L,3) = digit;

end

%printing all the identified digits in the order they appear in the input image
order_print(position, number_of_com);

toc()

