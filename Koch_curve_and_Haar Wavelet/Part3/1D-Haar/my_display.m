function my_display(x,y, msg, file_name)
  % This function will plot x and y having a msg (a level on the plot) on it.
  % Also print the plot as file_name.png
  
  plot(x,y);
  grid,axis([1 1200 -1.5 +1.5]);
  text (500, 1.2, msg);
  print(file_name,'-dpng');
endfunction