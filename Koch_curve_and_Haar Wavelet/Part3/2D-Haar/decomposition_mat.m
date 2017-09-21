function X = decomposition_mat(n) 
  % function X = decomposition_mat(n)
  % This function will generate a matrix X for decomposing an image (of size n x n) using Haar wavelet.  
  % Here n should contain a value that is power of 2.

  full = n;
  half = n/2;
  mat1 = zeros(full,half); 
  mat2 = zeros(full,half);

  temp = eye(half).* 0.5; % Here eye() is an builtin function to generate Identity matrix.
  mat1(1:2:full,:) = temp(1:half,:);   
  mat1(2:2:full,:) = temp(1:half,:); 
  mat2(1:2:full,:) = temp(1:half,:);   
  mat2(2:2:full,:) = temp(1:half,:).*-1; 
  X = [mat1, mat2];
 endfunction