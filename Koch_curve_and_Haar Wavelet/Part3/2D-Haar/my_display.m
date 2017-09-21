function y = my_display(y)  
  % High frequency components contain low values.  
  % Scaling the high frequency components to the range 0 to 255.
  
  temp = y(1:128,1:128); % seperate the low frequency part from whole image.
  y(1:128,1:128) = 0;  
  y = abs(y);
  y = y .- min(y(:));             %subtract the minimum value    
  y = uint8((y./max(y(:)))*256);  %Scaling to 0 to 255 
  
  y(1:128,1:128) = temp; % Appending the low frequency part again.
endfunction
