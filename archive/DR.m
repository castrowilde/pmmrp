clearvars % clears variables

A=imread('testsquare.jpg'); % load image
A=im2double(A); % scale pixel value from 0-255 to 0-1

h = 1/4; % x step
Du = 0.002; % diff coeff, Du << Dv or 4*Du = Dv
Dv = 0.008; % diff coeff
%tau = 1/600; % time step

n = size(A,2); % length horizontally
m = size(A,1); % length vertically
L = 100; % number of layers
eps = 0.001; % 0 < eps << 1
a = 0.4; % threshold
b = 20; % 10 for mono-stable, 20 for bi-stable
% tau = eps*(h^2)/((40*Du*eps) + a*(h^2));
tau = min( h^2 / (4 + Dv - h^2 * (1-b)), h^2 * eps / (4 * eps * Du + a * h^2));

U(1:m, 1:n,1) = A(1:m, 1:n) * (1.0 + 0.05) - 0.05; % every pixel gets its own value by brightness
V(1:m, 1:n,1) = zeros(m,n); % initial V is 0 for all pixels

% U(i, j, k+1) = tau * Du / (h^2) * ( U(i+1, j, k) + U(i, j+1, k) + U(i-1, j, k) + U(i, j-1, k) ) + ...
%              (1 - ( ( 4 * tau * Du) / h^2 )) * U(i, j, k) + ...
%              tau * ( 1 / eps ) * ( U(i , j, k) * ( 1 - U(i, j, k) ) * ( U(i, j, k) - a) - V(i, j, k));
% 
% V(i, j, k+1) = tau * Dv / (h^2) * ( V(i+1, j, k) + V(i, j+1, k) + V(i-1, j, k) + V(i, j-1, k) ) + ...
%              (1 - ( ( 4 * tau * Dv) / h^2 )) * V(i, j, k) + ...
%              tau * ( V(i , j, k) - b * V(i, j, k));

         
for k = 1:L
    for i = 2:m-1
        for j = 2:n-1

%             if (U(i, j, k) > a)
                 U(i, j, k+1) = tau * Du / (h^2) * ( U(i+1, j, k) + U(i, j+1, k) + U(i-1, j, k) + U(i, j-1, k) ) + ...
                 (1 - ( ( 4 * tau * Du) / h^2 )) * U(i, j, k) + ...
                 tau * ( 1 / eps ) * ( U(i , j, k) * ( 1 - U(i, j, k) ) * ( U(i, j, k) - a) - V(i, j, k));
%             else
%                  U(i, j, k+1) = tau * Dv / (h^2) * ( U(i+1, j, k) + U(i, j+1, k) + U(i-1, j, k) + U(i, j-1, k) ) + ...
%                  (1 - ( ( 4 * tau * Dv) / h^2 )) * U(i, j, k) + ...
%                  tau * ( 1 / eps ) * ( U(i , j, k) * ( 1 - U(i, j, k) ) * ( U(i, j, k) - a) - V(i, j, k));
%             end         
                 V(i, j, k+1) = tau * Dv / (h^2) * ( V(i+1, j, k) + V(i, j+1, k) + V(i-1, j, k) + V(i, j-1, k) ) + ...
                 (1 - ( ( 4 * tau * Dv) / h^2 )) * V(i, j, k) + ...
                 tau * ( U(i , j, k) - b * V(i, j, k));
             
            if (U(i, j, k) > 1)
                U(i, j, k) = 1;
            elseif(U(i, j, k) < -0.05)
                U(i, j, k) = -0.05;
            end
        end
    end

    imshow(U(:,:,k)); % show all the layers
    set(gcf, 'name', ['layer ' num2str(k) ' of ' num2str(L)]) % show layer number
end

% if (U(i, j, k) > a)
%         U(i, j, k) = 1;
% else
%         U(i, j, k) = 0;
% end

imshow(U(:,:,L)); % show all the layers
%  OLD CODE IS HERE
% 
%  for l = 2:L % L - layers
%     for j = 2:m-1
%            for i = 2:n-1
%                A(j,i,l) = (tau * D * ( (A(j,i+1,l-1) - 2 * A(j,i,l-1) + A(j,i-1,l-1)) / h^2)) + (tau * D * ( (A(j+1,i,l-1) - 2 * A(j,i,l-1) + A(j-1,i,l-1)) / h^2)) + A(j,i,l-1);
%                
%                A(j,1,l) = (A(j-1,1,l-1) + A(j+1,1,l-1) + A(j,2,l-1) + A(j,1,l-1))/4;
%                A(j,n,l) = (A(j-1,n,l-1) + A(j+1,n,l-1) + A(j,n-1,l-1) + A(j,n,l-1))/4;
%                A(1,i,l) = (A(1,i-1,l-1) + A(1,i+1,l-1) + A(2,i,l-1) + A(1,i,l-1))/4;
%                A(m,i,l) = (A(m,i-1,l-1) + A(m,i+1,l-1) + A(m-1,i,l-1) + A(m,i,l-1))/4;
%                
%                A(1,1,l) = (A(1,2,l-1) + A(2,1,l-1) + A(1,1,l-1))/3;
%                A(1,n,l) = (A(1,n-1,l-1) + A(2,n,l-1) + A(1,n,l-1))/3;
%                A(m,n,l) = (A(m,n-1,l-1) + A(m-1,n,l-1) + A(m,n,l-1))/3;
%                A(m,1,l) = (A(m,2,l-1) + A(m,1,l-1) + A(m,1,l-1))/3;
%            end          
%     end
%     
%     imshow(A(:,:,l)); % show all the layers
%     set(gcf, 'name', ['layer ' num2str(l) ' of ' num2str(L)]) % show layer number
%     
%  end
