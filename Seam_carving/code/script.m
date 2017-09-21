clear
pkg load image
tic()

I = imread('boat.jpg');

%Removing 200px from X direction
for i = 1:1:200
  I = seam_carving_x_direction(I);
end

%Transpose the color image
I = transpose_color(I);

%Removing 200px from Y direction
for i = 1:1:200
  I = seam_carving_x_direction(I);
end

imwrite(transpose_color(I),'out.jpg');
toc()

