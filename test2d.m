% for j = 2:1:J % J - layers
%     for x = 2:1:n-1 % n - length horizontally
%         for y = 2:1:m-1 % m - length vertically
%             A(x-1,) = (tau * D * ( (A(j,i+1) - 2 * A(j,i) + A(j,i-1)) / h^2)) + A(j,i);    

A=imread('testsquare.gif');
%A=A./255.0;
A=im2double(A);


h = 0.5; % x step
D = 10; % coeff
tau = h^2 / (5*D); % time step
n = size(A,2); % length horizontally
m = size(A,1); % length vertically
L = 200;

 for l = 2:L % L - layers
    for j = 2:m-1
           for i = 2:n-1
               A(j,i,l) = (tau * D * ( (A(j,i+1,l-1) - 2 * A(j,i,l-1) + A(j,i-1,l-1)) / h^2)) + (tau * D * ( (A(j+1,i,l-1) - 2 * A(j,i,l-1) + A(j-1,i,l-1)) / h^2)) + A(j,i,l-1);
               
               A(j,1,l) = (A(j-1,1,l-1) + A(j+1,1,l-1) + A(j,2,l-1) + A(j,1,l-1))/4;
               A(j,n,l) = (A(j-1,n,l-1) + A(j+1,n,l-1) + A(j,n-1,l-1) + A(j,n,l-1))/4;
               A(1,i,l) = (A(1,i-1,l-1) + A(1,i+1,l-1) + A(2,i,l-1) + A(1,i,l-1))/4;
               A(m,i,l) = (A(m,i-1,l-1) + A(m,i+1,l-1) + A(m-1,i,l-1) + A(m,i,l-1))/4;
               
               A(1,1,l) = (A(1,2,l-1) + A(2,1,l-1) + A(1,1,l-1))/3;
               A(1,n,l) = (A(1,n-1,l-1) + A(2,n,l-1) + A(1,n,l-1))/3;
               A(m,n,l) = (A(m,n-1,l-1) + A(m-1,n,l-1) + A(m,n,l-1))/3;
               A(m,1,l) = (A(m,2,l-1) + A(m,1,l-1) + A(m,1,l-1))/3;
           end          
    end
    imshow(A(:,:,l));
    set(gcf, 'name', ['layer ' num2str(l) ' of ' num2str(L)])
 end