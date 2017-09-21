function cylinder_image_create()
% This function will convert each input images into cylinder images using cylindrical
% warping. Write images into the 'cylinder_goose' folder.
  
  for i = 0 : 6
    str = strcat('goose/goose.',int2str(i),'.pgm');
    I = imread(str);   
    imwrite(uint8(cylinder(I,1050)),strcat('cylin_goose/goose.',int2str(i),'.pgm'))
  end
end

