%{
I is the image and [r c] contains all the locations of the target digits.
This function will draw white "X" symbols inside image I at the digit locations in [r c].
%}

function I = draw_star(r,c,I)
  
  % A cross sign having pixel value of 255.
  star = [1 0 0 0 1; 
          0 1 0 1 0; 
          0 0 1 0 0; 
          0 1 0 1 0; 
          1 0 0 0 1].*255;
  
  % Draw all the cross signs at the top of each target digit.
  [h w] = size(I);
  
  % Moving the location of "X" at the top of the each digit.
  r = r - 11;
  c = c - 3;
  
  % Draw "X" on each locations.
  for i = 1: 1: size(r,1)
    I(r(i)-2:1:r(i)+2,c(i)-2:1:c(i)+2) = star;
  end
  
endfunction