clear

A(1,26:50) = ([1:25]./25).^2;             % A row vector of 50 elements
X(1,1:50) = A;                            % put A at the begining of X
X(1,51:100) = fliplr(-A);                 % Flipping A and Put into X
Y = uint8((((ones(50,1) * X)+1)./2)*255); % 50 duplicates row and scaling the values into the range 0 to 255

colormap(gray(256));                      
image(Y+1);
print -dpng cornsweet.png
