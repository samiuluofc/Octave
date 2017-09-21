clear
mat1 = decomposition_mat(1024); % docomposition matrix for level-1
mat2 = decomposition_mat(512);  % docomposition matrix for level-2
mat3 = decomposition_mat(256);  % docomposition matrix for level-3
x = double(imread('cat.png'));

% Applying Level-1 decomposition on whole input image.
y = ((x * mat1)' * mat1)'; 
% Applying Level-2 decomposition on low frequency image.
y(1:512,1:512) = ((y(1:512,1:512) * mat2)' * mat2)'; 
% Applying Level-3 decomposition on next low frequency image.
y(1:256,1:256) = ((y(1:256,1:256) * mat3)' * mat3)';

z = my_display(y); % create a well visible whole image
imwrite(z,'Haar_cat.png'); 
