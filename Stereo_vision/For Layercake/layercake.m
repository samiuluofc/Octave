function [l,r] = layercake( m, n, nlayers )
%
%   [l,r] = layercake( m, n, nlayers ) - generate a layer-cake pair of
%                                        stereo images
%
%   m       - number of rows
%   n       - number of columns
%   nlayers - number of layers above the background
%
%   l       - left image
%   r       - right image
%

    % make background
    l = rand( m, n ) > 0.5;
    r = l;
    
    % add the tiers
    ml = m;
    nl = n;
    for layer = 1:nlayers
        % set size of image for layer to be half of layer blow it
        ml = floor(ml / 2);
        nl = floor(nl / 2);
        
        % make sure layer size is nonzero
        if ( ml <= 0 | nl <= 0 ) break; endif
        
        % create the random image for the layer
        im = rand(ml, nl) > 0.5;
        
        % find coords for layer in left image and put into left image
        r1 = floor(0.5 * (m - ml));
        r2 = r1 + ml - 1;
        c1 = floor(0.5 * (n - nl));
        c2 = c1 + nl - 1;
        l(r1:r2, c1:c2) = im;
        
        % find coords for layer in right image and put into right image
        c1 = c1 - layer;
        c2 = c2 - layer;
        r(r1:r2, c1:c2) = im;
    endfor

    l = l * 255;
    r = r * 255;

endfunction
