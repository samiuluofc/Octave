function result = transpose_color(I)
% The function will do Channel-wise(RGB) matrix transpose for the image I.
% The transposed color image will be returned as 'result' image.
  
  result(:,:,1) = I(:,:,1)';
  result(:,:,2) = I(:,:,2)';
  result(:,:,3) = I(:,:,3)'; 
end