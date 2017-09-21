function [M1,I_mos] = stitch_new_image(str1,str2,M,I_mos)
  % This function will stitch the image 'str2' into the paranomic mosaic 
  % 'I_mos' based on the image 'str1'. M is the previous transformation matrix.  
 
  % Find matching pixels using SIFT. I have slightly modified at the end of 
  % the match function so that rather than displaying matched pixels (using line connections), 
  % i have returned the matched pixels. 
  [x1,x2] = match(str1,str2);
  
  % Find the projective homography
  % Use Ransac to remove outlier mathed pixels
  [H, inliers] = ransacfithomography(x1,x2, 0.005);
  
  % New transformation matrix = Current projective homography * previous transformation matrix
  M1 = H*M;
  
  % Warp the image 'str2' into the paranomic mosaic 'I_mos' using transformation matrix M1
  img2 = imread(str2);
  Iw = warp(img2,M1,size(I_mos));
  pix_to_update = warp(ones(size(img2)),M1,size(I_mos)) > 0;
  I_mos(pix_to_update) = Iw(pix_to_update);

end