function Kn_1 = koch(Kn)
  % Kn_1 = koch(Kn)
  % koch function that calculates Kn+1 from Kn. Kn contains all points as arguments. 
  % As a return we will get all points of Kn+1 in Kn_1 matrix.
  
  co = size(Kn, 1);         % Number of points in Kn
  count = co .+ 3.*(co-1);  % Number of points in Kn_1
  Kn_1 = zeros(count,2);

  % In the following, I have generate points from Kn and place them in the right order 
  Kn_1(1:4:count,1) = Kn(1:co,1); % placing all X0
  Kn_1(1:4:count,2) = Kn(1:co,2);

  % generate and place all X2 in Kn_1
  Kn_1(2:4:count,1) = .667 .* Kn(1:co-1,1) + .333 .* Kn(2:co,1); 
  Kn_1(2:4:count,2) = .667 .* Kn(1:co-1,2) + .333 .* Kn(2:co,2);

  % generate and place all X3 in Kn_1
  sub_eq1 = .288 .* (Kn(1:co-1,2) - Kn(2:co,2));
  sub_eq2 = .288 .* (Kn(2:co,1) - Kn(1:co-1,1));
  Kn_1(3:4:count,1) = .5 .* Kn(1:co-1,1) + .5 .* Kn(2:co,1) + sub_eq1;
  Kn_1(3:4:count,2) = .5 .* Kn(1:co-1,2) + .5 .* Kn(2:co,2) + sub_eq2;

  % generate and place all X4 in Kn_1
  Kn_1(4:4:count,1) = .333 .* Kn(1:co-1,1) + .667 .* Kn(2:co,1);
  Kn_1(4:4:count,2) = .333 .* Kn(1:co-1,2) + .667 .* Kn(2:co,2);

endfunction
