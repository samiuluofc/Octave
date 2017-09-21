function x = append(mat, s)
  % function x = append(mat, s)
  % This function will padding the decomposition matrix 'mat' in such a way that
  % it will make the remaining(high frequency) part of the data unchanged.
  % x is the padded decomposition matrix and s is the desired dimention of x

  [r c] = size(mat);
  m = s-c;            % m is the additional lenth 
  x1 = zeros(r,m);
  x2 = eye(m);        % eye() is a buitin function for generate Identity matrix
  x3 = zeros(m,r);
  x = [mat,x1;x3,x2];
endfunction 