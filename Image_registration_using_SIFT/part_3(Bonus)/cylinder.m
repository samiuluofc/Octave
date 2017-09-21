function out = cylinder(I,f)
  % This function will do the cylindrical warping of image I considering f 
  % as focal length. I trial different values of f from 700 to 1200, and 
  % use the value 1050 that gives me the desire output.

  % Here, the equations are taken from reference [3]
  
  % Initializations
  [ydim xdim] = size(I);
  yc = ydim/2;
  xc = xdim/2;
  out = zeros(size(I));
  xp = yp = xo = yo = [];
  
  % For x = 1 to xdim find transformed x coordinates ximg
  x = 1:xdim;
  theta = (x - xc)./f;
  X = sin(theta);
  Z = cos(theta);
  xn = X ./ Z;
  ximg = floor(f .* xn + xc);
  
  % For y = 1 to ydim find transformed y coordinates yimg  
  for y = 1 : ydim  
    h = (y - yc)./f;
    yn = h ./ Z;       
    yimg = floor(f .* yn + yc);
    
    % Accumulating 1D points to make 2D grid of 
    % Original points [xo yo] and transformed points [xp yp]
    xp = [xp,ximg];
    xo = [xo,x];
    yp = [yp,yimg];
    yo = [yo,ones(1,xdim).*y];
  end

  % Removing some transformed points that are out of boundary of original image
  pos = find(xp < 1 | xp > xdim | yp < 1 | yp > ydim);
  xp(pos) =  yp(pos) = xo(pos) = yo(pos) = [];
  
  % Placing the pixel values using the mapping ([xp yp] <-> [xo yo])
  out(sub2ind([ydim, xdim],yo,xo)) = I(sub2ind([ydim, xdim],yp,xp));
end
