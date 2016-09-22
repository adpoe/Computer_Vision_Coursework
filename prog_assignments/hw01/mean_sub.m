%%
%%%%%%%%%%%%%%%%%%
% (21) Create another script which reads in an image. 
% It computes the scalar average pixel value along each channel (R, G, B) separately.
% It then subtracts the average value per channel from the corresponding channel. 
% Finally, it writes the image to a file mean_sub.png.

I = imread('pittsburgh.png'); % Read a PNG image
I_dup = I;

% get a handle to the BLUE channel
B = I(:,:,3);
% compute its scalar average
b_mu_rows = mean(B);
b_mu_overall = mean(b_mu_rows);
% subtract the scalar average from B
B_prime = B - b_mu_overall;


% get a handle to the GREEN channel
G = I(:,:,2);
% compute its scalar average
g_mu_rows = mean(G);
g_mu_overall = mean(g_mu_rows);
% subtract the scalar average from G
G_prime = G - g_mu_overall;


% get a handle to the RED channel
R = I(:,:,3);
% compute its scalar average
r_mu_rows = mean(R);
r_mu_overall = mean(r_mu_rows);
% subtract the scalar average from B
R_prime = R - r_mu_overall;


% re-assign our channel values
% save the file again
I(:,:,3) = B_prime;
I(:,:,2) = G_prime;
I(:,:,1) = R_prime;
imwrite(I, 'mean_sub.png');
%%