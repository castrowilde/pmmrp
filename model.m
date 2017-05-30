clearvars % clears variables

A = imread('img1.gif'); % load image (square)
% OR
% A = imread('img2.gif'); % load image (square) with noise
% OR
% A = imread('img3.gif'); % load image (glassware) with noise

A = im2double(A); % scale pixel value from 0-255 to 0-1

h = 1/4; % x step
% OR
% h = 1; % x step

Du = 2; % diff coeff, Du << Dv or 4*Du = Dv
Dv = 8; % diff coeff
eps = 0.0006; % 0 < eps << 1
a = 0.5; % threshold
b = 20; % 10 for mono-stable, 20 for bi-stable
tau = min( h^2 / (4 + Dv - h^2 * (1-b)), h^2 * eps / (4 * eps * Du + a * h^2));

n = size(A,2); % image size horizontally
m = size(A,1); % image size vertically
L = 220; % number of layers (optimal 120 - 220)

U(1:m, 1:n,1) = A(1:m, 1:n) * (1.0 + 0.05) - 0.05; % every pixel gets its own value by brightness
V(1:m, 1:n,1) = zeros(m,n); % initial V is 0 for all pixels
     
for k = 1:L
    for i = 2:m-1
        for j = 2:n-1

                 U(i, j, k+1) = tau * Du / (h^2) * ( U(i+1, j, k) + U(i, j+1, k) + U(i-1, j, k) + U(i, j-1, k) ) + ...
                 (1 - ( ( 4 * tau * Du) / h^2 )) * U(i, j, k)+ ...
                 tau * ( 1 / eps ) * ( U(i , j, k) * ( 1 - U(i, j, k) ) * ( U(i, j, k) - a) - V(i, j, k));
       
                 V(i, j, k+1) = tau * Dv / (h^2) * ( V(i+1, j, k) + V(i, j+1, k) + V(i-1, j, k) + V(i, j-1, k) ) + ...
                 (1 - ( ( 4 * tau * Dv) / h^2 )) * V(i, j, k) + ...
                tau * ( U(i , j, k) - b * V(i, j, k));

        end
    end

    imshow(U(:,:,k)); % show all the layers
    set(gcf, 'name', ['layer ' num2str(k) ' of ' num2str(L)]) % show layer number
end

% for k = 1:L
%     for i = 2:m-1
%         for j = 2:n-1
%             if (U(i, j, k) > 1)
%                 U(i, j, k) = 1;
%             elseif(U(i, j, k) < -0.05)
%                 U(i, j, k) = -0.05;
%             end
%         end
%     end
% end
% imshow(U(:,:,L)); % show all the layers