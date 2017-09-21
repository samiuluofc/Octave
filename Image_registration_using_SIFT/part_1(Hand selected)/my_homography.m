function H = my_homography(p1,p2)
  % This function uses Least Sqaure method to find the homographic matrix.
  % Here p1 and p2 is the set of matched points.
  
  %Initialization
  number_of_points = size(p1,2);
  A = [];
  b = [];

  % Constructing A and b for the least square approach considering P_33 = 1.
  for i = 1:number_of_points
    A = [A; p1(1,i), p1(2,i), p1(3,i), 0, 0, 0, -p1(1,i) * p2(1,i), -p1(2,i) * p2(1,i)];
    A = [A; 0, 0, 0, p1(1,i), p1(2,i), p1(3,i), -p1(1,i) * p2(2,i), -p1(2,i) * p2(2,i)];
    b = [b; p2(1,i); p2(2,i)];
  end

  % Solution using least square equation
  x = inv(A' * A) * A' * b;
  
  % Rearranging the solution into target 3x3 matrix
  H = [x(1),x(2),x(3); x(4),x(5),x(6); x(7),x(8),1];
end
