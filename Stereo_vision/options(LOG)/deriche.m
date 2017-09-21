function Iout = deriche( Iin, sigma )
%
%   function Iout = deriche( Iin, sigma ) - use Deriche recursive filters to
%                           smooth an image with quasi-Gaussian kernel
%
%   Iin     -   input image
%   sigma   -   sigma for Gaussian kernel
%   Iout    -   smoothed output image
%

    % get the input image size
    [nr, nc] = size( Iin );
    
    % compute a few useful numbers
    alpha = 5.0 / (2.0 * sqrt( pi ) * sigma );
    expalpha = exp( -alpha );
    k = ( 1.0 - expalpha )^2 / ...
            ( 1.0 + 2.0 * alpha * expalpha - expalpha^2 );

    % use the numbers from above to compute the filter coefficients
    a1 = k;
    a5 = k;
    a2 = k * expalpha * (alpha - 1.0);
    a6 = k * expalpha * (alpha - 1.0);
    a3 = k * expalpha * (alpha + 1.0);
    a7 = k * expalpha * (alpha + 1.0);
    a4 = -k * expalpha^2;
    a8 = -k * expalpha^2;
    b1 = 2.0 * expalpha;
    b2 = -expalpha^2;
    c1 = 1.0;
    c2 = 1.0;

    % put the filter coefficents into z-polynomials
    N1f = [ a1, a2, 0 ];
    D1f = [ 1, -b1, -b2 ];
    N1r = [ 0, a3, a4 ];
    D1r = [ 1, -b1, -b2 ];
    N2f = [ a5, a6, 0 ];
    D2f = [ 1, -b1, -b2 ];
    N2r = [ 0, a7, a8 ];
    D2r = [ 1, -b1, -b2 ];
    
    % do first pass of the filter - filter rows
    y1 = zeros( nr, nc );
    for m = 1:nr
        y1(m,:) = filter( N1f, D1f, Iin(m,:) );
    endfor
    y2 = zeros( nr, nc );
    for m = 1:nr
        y2(m,nc:-1:1) = filter( N1r, D1r, Iin(m,nc:-1:1) );
    endfor
    r = c1 * (y1 + y2);
    
    % do second pass of the filter - filter columns
    for n = 1:nc
        y1(:,n) = filter( N2f, D2f, r(:,n) );
    endfor
    for n = 1:nc
        y2(nr:-1:1,n) = filter( N2r, D2r, r(nr:-1:1,n) );
    endfor
    Iout = c2 * (y1 + y2);

endfunction
