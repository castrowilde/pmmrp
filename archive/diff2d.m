clear all;

A=imread('test1.jpg');

%A=A/255.0;
tau = 0.005; % time step
h = 0.01; % x step
D = 1; % coeff
X = 10; % X
T = 100; % max T
n = size(A,2); % length horizontally
m = size(A,1); % length vertically
L = h/tau * 100;

for l = 2:L % L - layers
    A(2:m-1, 2:n-1, l) = D * ( (A(1:m-2, 1:n-2, l-1) + A(1:m-2, 2:n-1, l-1) + A(1:m-2, 3:n, l-1) + A(2:m-1, 1:n-2, l-1) + ...
    A(2:m-1, 3:n, l-1) + A(3:m, 1:n-2, l-1) + A(3:m, 2:n-1, l-1) + A(3:m, 3:n, l-1) ) / 8);

    A(2:m-1, 1, l) = D * ( (A(1:m-2, 1, l-1) + A(3:m, 1, l-1) + A(1:m-2, 2, l-1) + A(2:m-1, 2, l-1) + A(3:m, 2, l-1) ) / 5);

    A(2:m-1, n, l) = D * ( ( A(1:m-2, n, l-1) + A(3:m, n, l-1) + A(1:m-2, n-1, l-1) + A(2:m-1, n-1, l-1) + A(3:m, n-1, l-1) ) / 5);

    A(1, 2:n-1, l) = D * ( ( A(1, 1:n-2, l-1) + A(1, 3:n, l-1) + A(2, 1:n-2, l-1) + A(2, 2:n-1, l-1) + A(2, 3:n, l-1) ) / 5);

    A(m, 2:n-1, l) = D * ( ( A(m, 1:n-2, l-1) + A(m, 3:n, l-1) + A(m-1, 1:n-2, l-1) + A(m-1, 2:n-1, l-1) + A(m-1, 3:n, l-1) ) / 5);

    A(1, 1, l) = D * ( ( A(1, 2, l-1) + A(2, 1, l-1) + A(2, 2, l-1) ) / 3);

    A(m, 1, l) = D * ( ( A(m, 2, l-1) + A(m-1, 1, l-1) + A(m-1, 2, l-1) ) / 3);

    A(1, n, l) = D * ( ( A(1, n-1, l-1) + A(2, n, l-1) + A(2, n-1, l-1) ) / 3);

    A(m, n, l) = D * ( ( A(m, n-1, l-1) + A(m-1, n, l-1) + A(m-1, n-1, l-1) ) / 3);
    
    imshow(A(:,:,l));
    
%     for j=2:m-1
%            for i=2:n-1
%                %A(j,i,l) = (tau * D * ( (A(j,i+1,l-1) - 2 * A(j,i,l-1) + A(j,i-1,l-1)) / h^2)) + (tau * D * ( (A(j+1,i,l-1) - 2 * A(j,i,l-1) + A(j-1,i,l-1)) / h^2)) + A(j,i,l-1);           
%            end
%     end
end
