function D = stereo(L,R,smin,smax,sig)
  % This function return the disparity map (D) of a pair of stereo images (L and R).
  % Here L is the left eye image, R is the right eye image, smin and smax are the 
  % range of disparity, and sig is the width of gaussian smoothing kernal. 
  
  % for all possible disparities between smin to smax
  for s = smin:smax  
    % M is the measure of similarity between L and shifted (columnwise) R.
    % Applying Gaussian smoothing kernal (Deriche implementation)
    M = deriche(abs(L.-shift(R,s,2)),sig); 
   
    if s == smin % If first iteration
      D = ones(size(L)) .* smin;
      M_min = M;
    else
      pos = find(M < M_min);
      D(pos) = s; % update the disparity map (D)
      M_min(pos) = M(pos); % update the M_min   
    end
  end
end