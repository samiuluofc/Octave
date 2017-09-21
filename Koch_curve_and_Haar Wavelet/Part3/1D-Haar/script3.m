clear
x = 1:1:1024;
sin_noisy = sin(0:2*pi/1023:2*pi) + randn(1,1024)/10;
my_display(x, sin_noisy, 'Noisy Sine Curve', 'sine');

mat1 = decomposition_mat(1024); % Get Level-1 decomposition matrix

mat2 = decomposition_mat(512);  % Get Level-2 decomposition matrix
mat2 = append(mat2,1024);

mat3 = decomposition_mat(256);  % Get Level-3 decomposition matrix
mat3 = append(mat3,1024);

mat4 = decomposition_mat(128);  % Get Level-4 decomposition matrix
mat4 = append(mat4,1024);

mat5 = decomposition_mat(64);   % Get Level-5 decomposition matrix
mat5 = append(mat5,1024);

mat = mat1 * mat2 * mat3 * mat4 * mat5; % final decomposition matrix
y = sin_noisy * mat;                         
my_display(x, y, 'After applying all 5 decompositions', 'out');

cos_f = cos(0:2*pi/31:2*pi);  % generate cos curve
y = [cos_f, y(33:1024)];      % generate cos curve + high frequency
my_display(x,y, 'Cosine curve + High Frequency', 'cos');

rev = y * inv(mat);            % Recompostion done in a single operation
my_display(x,rev, 'Noisy Cosine', 'cos_noisy');
