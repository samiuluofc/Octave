function result = seam_carving_x_direction(I)
	%{
	Function that finds a Top-down (vertical) seam in the image I and removes the seam.
	Reduce one pixel in X direction and return the image as 'result' matrix.
	%}

  I_gray = rgb2gray(I); 
	[h w] = size(I_gray); 

	%Consider L1 norm as Energy.
  %Calculate energy in the grayscale version of the image I.
	dx = conv2(I_gray,[1 -1],'same');
	dy = conv2(I_gray,[1 ;-1],'same');
	Energy = abs(dx) + abs(dy);
    
	%Initialization
	Min_energy = zeros(h+1,w+2);
	Min_energy(:,1) = Min_energy(:,w+2) = inf;

	%Store the vertical seam directions left(-1), straight (0) and right (-1)
	direction = zeros(h,w); 

	%Dynamic programming for the seam finding
	for i = 1:h
	  [min_value, index] = min([Min_energy(i,1:w); Min_energy(i,2:w+1); Min_energy(i,3:w+2)]);  
		Min_energy(i+1,2:w+1) = Energy(i,1:w) + min_value;
		direction(i,:) = index-2;%Shifting 1,2,3 to -1,0,1    
	end

	%Find the min energy from the bottom row
	[val, col] = min(Min_energy(h+1,:));
  col = col - 1;
		
  %{
  BACKTRACKING(Finding the optimal energy path). 
	At the same time converting subscript into a row-major linear index.
	I am unable to do it using sub2ind function becuase it gives coloumn-major linear index.
	But I need row-major linear index. So i do it with a simple equation.
  %} 
	linear_ind = zeros(h,1);
	for i = h:-1:1
		linear_ind(i,1) = (i-1)*w+col; %Row-major linear index.
		col = col + direction(i,col);
	end

	%Channel(RGB)-wise seam removing. Iterates 3 times only. 
	for i = 1:1:3
		C = I(:,:,i)'(:);
		C(linear_ind) = []; %Deleting the whole seam
		result(:,:,i) = reshape(C,w-1,h)'; %Reshaping (Row major order)
	end 
end