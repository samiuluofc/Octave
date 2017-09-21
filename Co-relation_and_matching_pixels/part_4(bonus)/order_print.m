%{
This function prints the digit values in correct order (row major order) as they' 
appear in the image. The matrix 'position' (n by 3) contains the locations (subscripts) 
of the identified digits and their values. 'n' is the total number of digits.
%}

function order_print(position, n)

  % Sort all the locations rowwise.
  position = sortrows(position,1);
  
  % To handle the boundary condition in the following for loop.
  position(n+1,1:3) = 10000;
  
  % Initializations and file open
  fd = fopen('out.txt','w');
  count = 0;
  X = position(1,:);
  
  for i = 1 : 1 : n % for all locations of the identified digits
    
    diff = abs(position(i,1) - position(i+1,1));
    
    % preparing a 'X' that contains all locations having row difference 
    % not more than 5 pixel. 
    if diff < 6     
        position(i+1,1) = position(i,1);
        X = [X; position(i+1,:)];   
    else
        % Now all locations inside the 'X' have same row values.
        % Sort all the locations in 'X' columnwise.
        X = sortrows(X,2);
        
        % print all the digit values in X.
        for j = 1: 1 : size(X,1)
          fprintf(fd, "%d", X(j,3));
          count = count + 1;
          if count == 60 % put new line after every 60 items
              count = 0;
              fprintf(fd,"\r\n");
          end
        end
        X = position(i+1,:); % new initialization of 'X'
    end   
  end

  fclose(fd);

endfunction